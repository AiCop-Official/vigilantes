#!/usr/bin/env bash
# Visita una página y avisa a su check de healthchecks.io.
# Uso: revisar.sh <página> <url del check>
# Responde bien (2xx o 3xx): ping normal. Si no: ping de falla (/fail) para que la alerta llegue de una vez.
set -u

pagina="$1"
check="${2:-}"

if [ -z "$check" ]; then
  echo "Sin check configurado para $pagina, se omite."
  exit 0
fi

# Los hostings con mod_security responden 406 a clientes que no parecen navegador.
navegador="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0 Safari/537.36"

codigo=$(curl -s -o /dev/null -L -A "$navegador" --max-time 30 --retry 2 --retry-delay 10 -w "%{http_code}" "$pagina")
codigo=${codigo:-000}
echo "$pagina respondió $codigo"

if [ "$codigo" -ge 200 ] && [ "$codigo" -lt 400 ]; then
  curl -fsS -m 10 --retry 3 "$check" > /dev/null
else
  curl -fsS -m 10 --retry 3 --data-raw "HTTP $codigo" "$check/fail" > /dev/null
fi
