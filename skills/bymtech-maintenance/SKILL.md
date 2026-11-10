---
name: bymtech-maintenance
description: Mantener, validar y publicar el sitio bymtech.com.ar desde su repositorio local. Usar para cambios de contenido, productos, imágenes, formularios, responsive o despliegues de ByM Tech.
---

# ByM Tech Website Maintenance

Trabajar en `C:\Users\AlanMedina\Documents\ChatGPT\ByM Tech Page`.

## Flujo

1. Leer `MAINTENANCE.md` y revisar `git status --short`.
2. Preservar cambios ajenos y excluir los archivos del generador de firmas salvo pedido explícito.
3. Mantener una sola sección de Productos; sus tarjetas abren detalles desde templates en `index.html`.
4. Guardar galerías bajo `assets/` con nombres descriptivos y rutas relativas compatibles con GitHub Pages.
5. No guardar secretos SMTP. Los formularios usan `form-config.js` y un proveedor HTTPS apto para sitio estático.
6. Validar con `git diff --check`, sintaxis del JavaScript embebido y una revisión visual responsive.
7. Cuando el usuario autorice publicar, ejecutar:

```powershell
.\scripts\deploy-bymtech.ps1 -Message "Descripción del cambio"
```

8. Verificar la ejecución de GitHub Pages y `https://bymtech.com.ar/`.

## Límites

- No afirmar asociaciones comerciales por mostrar una plataforma integrada.
- No publicar material con datos sensibles visibles.
- No alterar `firma-email-bymtech.html`, `generador-firma.html` ni `logo-email.png` sin una solicitud específica.
- Si faltan capturas, reutilizar diagramas claramente identificados; no fabricar evidencia de producto.
