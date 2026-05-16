# Plan Integral — Portal personal de seguimiento

Portal web personal para Lucía y Alfredo. Permite registrar entrenamientos, alimentación, hábitos diarios y seguimiento corporal. Sin frameworks, sin build, un único archivo HTML que se conecta a Supabase.

## Stack

- HTML/CSS/JS vanilla en un único archivo `index.html`.
- Base de datos en Supabase (Postgres + API REST gratuita).
- Despliegue estático en Vercel.

## Pasos para ponerlo a funcionar (~15 minutos)

### 1. Crear proyecto en Supabase

1. Entra a [supabase.com](https://supabase.com) y crea una cuenta gratis si no tienes.
2. Clic en **"New project"**.
3. Nombre: `plan-integral` (o el que prefieras).
4. Password de la base de datos: genera una y guárdala (no la necesitas para este portal, pero guárdala por seguridad).
5. Región: elige la más cercana (ej. `South America (São Paulo)`).
6. Clic en **"Create new project"** y espera ~2 minutos a que termine el setup.

### 2. Ejecutar el schema SQL

1. Una vez creado el proyecto, en el menú lateral izquierdo entra a **"SQL Editor"**.
2. Clic en **"New query"**.
3. Abre el archivo `schema.sql` de este repo y copia todo su contenido.
4. Pégalo en el editor de Supabase y clic en **"Run"** (o `Cmd/Ctrl + Enter`).
5. Deberías ver "Success. No rows returned". Las 7 tablas quedan creadas con sus políticas de acceso.

### 3. Copiar credenciales de Supabase

1. En el menú lateral izquierdo, entra a **"Project Settings"** (ícono de engranaje) → **"API"**.
2. Verás dos cosas que necesitas:
   - **Project URL**: algo tipo `https://xxxxxxxxxxxx.supabase.co`
   - **anon public key**: una cadena larga que empieza con `eyJ...`
3. Mantén esta ventana abierta.

### 4. Pegar credenciales en `index.html`

1. Abre `index.html` en este repo (puedes hacerlo desde la web de GitHub clicando en el archivo y luego en el ícono del lápiz, o desde tu editor local).
2. En las primeras líneas dentro del primer `<script>` verás:

   ```javascript
   // === CONFIGURAR ANTES DE USAR ===
   const SUPABASE_URL = 'PEGAR_AQUI_TU_PROJECT_URL';
   const SUPABASE_ANON_KEY = 'PEGAR_AQUI_TU_ANON_KEY';
   // =================================
   ```

3. Reemplaza `PEGAR_AQUI_TU_PROJECT_URL` por tu Project URL.
4. Reemplaza `PEGAR_AQUI_TU_ANON_KEY` por tu anon public key.
5. Guarda y haz commit (si lo editaste en GitHub web, simplemente clic en "Commit changes").

### 5. Desplegar en Vercel

1. Entra a [vercel.com/new](https://vercel.com/new) y conecta tu cuenta de GitHub si no lo has hecho.
2. Clic en **"Import"** junto al repo `plan-integral`.
3. No cambies ninguna configuración. Vercel detecta que es un sitio estático.
4. Clic en **"Deploy"**.
5. En ~30 segundos te da una URL tipo `https://plan-integral-tunombre.vercel.app`.

### 6. Probar

- Abre la URL desde tu celular y desde tu computador.
- En cada dispositivo selecciona "Soy Lucía" o "Soy Alfredo".
- Registra una sesión de prueba.
- Verifica en Supabase (Table Editor) que aparece la fila.

### 7. Acceso directo en celular (recomendado)

**En iPhone (Safari):**
1. Abre la URL del portal en Safari.
2. Toca el botón de compartir (cuadrado con flecha arriba).
3. Baja y toca **"Agregar a pantalla de inicio"**.
4. Confirma el nombre y toca **"Agregar"**.

**En Android (Chrome):**
1. Abre la URL del portal en Chrome.
2. Toca el menú de tres puntos arriba a la derecha.
3. Toca **"Agregar a pantalla principal"** o **"Instalar app"**.
4. Confirma.

Ahora el portal aparece como una app en tu pantalla de inicio.

## Estructura del repo

```
.
├── index.html      # Portal completo, autocontenido
├── schema.sql      # SQL para crear las tablas en Supabase
├── vercel.json     # Configuración de Vercel
└── README.md       # Este archivo
```

## Funcionalidades

- **Hub de entrada**: selección de perfil (Lucía / Alfredo).
- **Deporte**: rutina semanal precargada con detalle de cada ejercicio (3 días de pesas + Pilates para Lucía + caminatas). Registro serie por serie con peso y reps. Historial con progresión.
- **Alimentación**: plan diario de 2 semanas precargado (porciones diferenciadas por perfil). Registro de comidas reales y adherencia. Cálculo de proteína diaria.
- **Hábitos**: CRUD de hábitos diarios con racha y vista mensual.
- **Seguimiento**: registro corporal (peso, cintura, notas) con gráfico de evolución.

## Notas técnicas

- Las credenciales de Supabase (anon key) son **públicas por diseño**. La seguridad se basa en las políticas RLS de la base de datos. En este portal las políticas son abiertas (lo que tiene la URL puede leer/escribir todo), lo cual está bien para un portal personal de uso privado entre dos personas. Si compartes la URL públicamente, alguien podría leer/escribir tus datos.
- Los datos quedan persistidos en Supabase y se sincronizan entre dispositivos automáticamente.
- El selector de perfil queda guardado en `localStorage` del navegador, así que cada dispositivo recuerda qué perfil eligió.

## Solución de problemas

- **"Configurar credenciales de Supabase..."**: no pegaste las credenciales en `index.html`. Vuelve al paso 4.
- **El portal carga pero no guarda nada**: revisa la consola del navegador (`F12` → Console). Probablemente hay un error de red o las credenciales son incorrectas.
- **Error al ejecutar el SQL en Supabase**: si las tablas ya existen, el script falla. Bórralas primero o usa un proyecto nuevo.
