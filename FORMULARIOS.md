# Formularios de contacto

El sitio se publica como HTML estático en GitHub Pages. Por seguridad, no deben
guardarse usuario, contraseña ni claves SMTP en este repositorio: cualquier
visitante podría verlas desde el navegador.

La configuración pública está en `form-config.js`. Actualmente utiliza
FormSubmit para entregar las consultas a `ventas@bymtech.com.ar` sin exponer
credenciales.

## Activación inicial

1. Enviar una consulta de prueba desde cualquiera de los formularios.
2. FormSubmit enviará un correo de activación a `ventas@bymtech.com.ar`.
3. Confirmar ese correo una sola vez.

## Cambiar de proveedor

Se puede reemplazar `endpoint` en `form-config.js` por un endpoint propio de
Formspree, Web3Forms o una función serverless. El endpoint debe aceptar `POST`
con `FormData` y responder con un estado HTTP exitoso.

Si se desea usar SMTP propio, debe implementarse en una función serverless o
backend y guardar las credenciales como secretos del servidor, nunca dentro del
HTML o JavaScript público.
