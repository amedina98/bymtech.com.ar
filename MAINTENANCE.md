# Mantenimiento de ByM Tech

## Publicación en un comando

Desde la raíz del repositorio:

```powershell
.\scripts\deploy-bymtech.ps1 -Message "Descripción del cambio"
```

Para validar sin modificar Git ni publicar:

```powershell
.\scripts\deploy-bymtech.ps1 -Message "Prueba" -DryRun
```

El script valida el JavaScript embebido, ejecuta `git diff --check`, limita el despliegue a archivos del sitio y excluye automáticamente los archivos del generador de firmas.

## Estructura

- `index.html`: landing principal, productos y ventanas de detalle.
- `portal-proveedores/index.html`: landing específica del Portal de Proveedores.
- `productos/`: landings específicas, estilos y formularios del resto de productos y servicios.
- `assets/platforms/`: logos y galerías de TOTVS Protheus, Odoo, Metabase y SyncMaster.
- `assets/portal-proveedores/`: capturas reales del Portal de Proveedores.
- `assets/portal-clientes/`: video, portada y capturas del Portal de Clientes.
- `form-config.js`: destino de formularios; no almacenar credenciales SMTP.

## Criterios

- Mantener una única sección de Productos en la home.
- Cada tarjeta con detalle abre su propia ventana y galería.
- No presentar marcas integradas como clientes o partners oficiales.
- Preservar `firma-email-bymtech.html`, `generador-firma.html` y `logo-email.png` salvo pedido explícito.
- Probar escritorio y móvil antes de publicar cambios visuales.

