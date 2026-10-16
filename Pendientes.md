# Ajustes pendientes de backend (derivados del diseño)

## /usuarios
- Agregar `genero: 'hombre' | 'mujer'` y `fechaNacimiento: timestamp`, ambos OBLIGATORIOS.
- Regla de create: exigir ambos campos con tipo válido.
- Regla de update: el dueño puede cambiar `genero` y `fechaNacimiento` (con validación de tipo).
  Quitar `telefono` (y correo) de los campos editables por el cliente: deben cambiarse
  solo vía Cloud Function con OTP (`cambioTelefono`, `cambioCorreo`).
- El límite de 2 cambios de nombre se aplica en una Cloud Function (`cambiarNombre`) con un
  contador `cambiosNombre` que el cliente no puede escribir.

## Registro
- El diseño de "Crear cuenta" solo pide correo y contraseña; falta definir dónde se
  capturan nombre, primer apellido, género y fecha de nacimiento.

## Peticiones de oración
- El modal de diseño no tiene selector de tipo (oración / agradecimiento) que exige el modelo.