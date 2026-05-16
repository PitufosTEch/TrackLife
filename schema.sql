-- Esquema de base de datos para el Plan Integral
-- Pegar este archivo completo en el SQL Editor de Supabase y ejecutar.

create table workout_sessions (
  id uuid primary key default gen_random_uuid(),
  user_name text not null check (user_name in ('lucia', 'alfredo')),
  routine_day text not null,
  planned_weekday text not null,
  actual_date date not null,
  notes text,
  created_at timestamptz default now()
);

create table workout_sets (
  id uuid primary key default gen_random_uuid(),
  session_id uuid references workout_sessions(id) on delete cascade,
  exercise_name text not null,
  set_number int not null,
  weight_kg numeric,
  reps int,
  exercise_notes text,
  created_at timestamptz default now()
);

create table activities (
  id uuid primary key default gen_random_uuid(),
  user_name text not null check (user_name in ('lucia', 'alfredo')),
  activity_type text not null,
  planned_weekday text,
  actual_date date not null,
  duration_minutes int,
  notes text,
  created_at timestamptz default now()
);

create table meal_logs (
  id uuid primary key default gen_random_uuid(),
  user_name text not null check (user_name in ('lucia', 'alfredo')),
  log_date date not null,
  meal_type text not null check (meal_type in ('desayuno', 'almuerzo', 'snack', 'cena')),
  followed_plan boolean default true,
  description text,
  protein_grams numeric,
  notes text,
  created_at timestamptz default now()
);

create table habits (
  id uuid primary key default gen_random_uuid(),
  user_name text not null check (user_name in ('lucia', 'alfredo')),
  name text not null,
  icon text,
  active boolean default true,
  created_at timestamptz default now()
);

create table habit_logs (
  id uuid primary key default gen_random_uuid(),
  habit_id uuid references habits(id) on delete cascade,
  log_date date not null,
  completed boolean default true,
  created_at timestamptz default now(),
  unique(habit_id, log_date)
);

create table body_tracking (
  id uuid primary key default gen_random_uuid(),
  user_name text not null check (user_name in ('lucia', 'alfredo')),
  log_date date not null,
  weight_kg numeric,
  waist_cm numeric,
  notes text,
  created_at timestamptz default now()
);

alter table workout_sessions enable row level security;
alter table workout_sets enable row level security;
alter table activities enable row level security;
alter table meal_logs enable row level security;
alter table habits enable row level security;
alter table habit_logs enable row level security;
alter table body_tracking enable row level security;

create policy "allow all workout_sessions" on workout_sessions for all using (true) with check (true);
create policy "allow all workout_sets" on workout_sets for all using (true) with check (true);
create policy "allow all activities" on activities for all using (true) with check (true);
create policy "allow all meal_logs" on meal_logs for all using (true) with check (true);
create policy "allow all habits" on habits for all using (true) with check (true);
create policy "allow all habit_logs" on habit_logs for all using (true) with check (true);
create policy "allow all body_tracking" on body_tracking for all using (true) with check (true);
