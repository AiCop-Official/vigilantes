# Vigilantes

Revisa cada 10 minutos que las páginas estén arriba y avisa a [healthchecks.io](https://healthchecks.io) (cuenta `publicidadreal@hotmail.com`).

| Página | Secreto con la URL del check |
|---|---|
| https://www.ranchenatoradio.com | `HC_RANCHENATO` |
| https://www.vipstereo.com | `HC_VIPSTEREO` |
| https://www.publicidadreal.com | `HC_PUBLICIDADREAL` |

- La revisión está en `revisar.sh`: visita la página como un navegador (el hosting bloquea con 406 a los robots) y, si responde 2xx o 3xx, avisa al check; si no, le avisa la falla (`/fail`).
- Si una página no tiene secreto, se omite.
- Agregar una página: crear el check en healthchecks, guardar su URL como secreto del repositorio (Settings → Secrets and variables → Actions) y añadir un paso en `.github/workflows/paginas.yml`.
- En healthchecks, cada check con *Period* 10 minutos y *Grace* 20 minutos (GitHub a veces atrasa las tareas programadas).
- GitHub apaga las tareas programadas de un repositorio público tras 60 días sin cambios; si pasa, healthchecks alerta porque dejan de llegar avisos. Se reactiva en la pestaña Actions.
