# Daybook

A personal progress tracker: plan tomorrow, tick off today, file a daily report, and track points, streaks, levels, badges and monthly progress.

Everything is a single `index.html` with no build step. Data is saved in your browser's localStorage. Use **Export backup** / **Import backup** to save it or move it to another device.

Run locally: open `index.html` in a browser, or `python3 -m http.server 8000` and visit http://localhost:8000.

## Sync across devices with a login (Supabase)

1. Create a free project at https://supabase.com.
2. In **SQL Editor**, run `setup.sql`. It creates the table and turns on Row Level Security, so each account can only read its own data.
3. In **Authentication -> URL Configuration**, set **Site URL** to your site address (e.g. `https://newton-raphson.github.io/daybook/`).
4. Copy the **Project URL** and **anon / publishable key** from **Project Settings -> API** into `config.js`.
5. Open the site, create your account, confirm the email, and sign in. Then turn off **Allow new users to sign up** (Authentication -> Sign In / Providers) so nobody else can register.

With `config.js` empty, the app runs without a login and saves to the browser only.
