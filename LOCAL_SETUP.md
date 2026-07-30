# Local Setup Guide

How to preview this website on your own machine before publishing.

This site is built with [Jekyll](https://jekyllrb.com/) (the same engine GitHub
Pages uses). Running it locally lets you see changes at `http://localhost:4000/`
**before** you commit and push them to the live site at
[rupeshprasad.com](https://rupeshprasad.com).

> **Local server vs. live site** — they are separate.
> The local server (`localhost:4000`) is a private preview that only runs while
> you have it open. Your live website (`rupeshprasad.com`) is built and hosted by
> GitHub automatically, 24/7. Stopping the local server, closing the terminal, or
> restarting your machine has **no effect** on the live site.

---

## Quick start (machine already set up)

1. Double-click **`serve.bat`** in this folder.
   *(Or, in a terminal: `bundle exec jekyll serve --livereload`)*
2. Open **http://localhost:4000/** in your browser.
3. Edit files — the browser auto-reloads on save (LiveReload).
4. Press **Ctrl+C** in the terminal window to stop.

To publish changes: commit and push to `main`. GitHub Pages rebuilds
`rupeshprasad.com` within ~1 minute.

---

## First-time setup on a new machine (Windows)

### 1. Install Ruby + DevKit

Using **winget** (built into Windows 10/11) — no admin rights needed:

```powershell
winget install --id RubyInstallerTeam.RubyWithDevKit.3.3
```

> Alternatively, download the "Ruby+Devkit" installer from
> <https://rubyinstaller.org/> and run it. When it finishes, let it run
> `ridk install` (choose option 3, MSYS2 + MINGW).

**Close and reopen your terminal** afterward so `ruby` is on your PATH. Verify:

```powershell
ruby --version
gem --version
```

### 2. Install Bundler

```powershell
gem install bundler
```

### 3. (Corporate networks only) Fix SSL certificate errors

If you see errors like *"self-signed certificate in certificate chain"* or
*"Root certificate is not trusted ... netskope"*, your network inspects SSL
traffic and Ruby doesn't trust its certificate. Export the Windows trust store
to a file Ruby can use:

```powershell
$certDir = "$env:USERPROFILE\.certs"
New-Item -ItemType Directory -Force -Path $certDir | Out-Null
$pem = Join-Path $certDir "windows-ca-bundle.pem"
$sb = [System.Text.StringBuilder]::new()
Get-ChildItem Cert:\LocalMachine\Root, Cert:\CurrentUser\Root -ErrorAction SilentlyContinue |
    Sort-Object Thumbprint -Unique | ForEach-Object {
        $b64 = [System.Convert]::ToBase64String($_.RawData, 'InsertLineBreaks')
        [void]$sb.AppendLine("-----BEGIN CERTIFICATE-----")
        [void]$sb.AppendLine($b64)
        [void]$sb.AppendLine("-----END CERTIFICATE-----")
    }
[System.IO.File]::WriteAllText($pem, $sb.ToString())

# Make Ruby use it permanently (for your user account)
[System.Environment]::SetEnvironmentVariable("SSL_CERT_FILE", $pem, "User")
$env:SSL_CERT_FILE = $pem
```

`serve.bat` also points at this file automatically if it exists.

### 4. Install the project's gems

From this project folder:

```powershell
bundle config set --local path 'vendor/bundle'
bundle install
```

This reads the `Gemfile` and installs Jekyll + the `github-pages` gem
(so your local build matches GitHub exactly).

### 5. Run it

```powershell
bundle exec jekyll serve --livereload
```

Open **http://localhost:4000/**. Done.

---

## Setup on macOS / Linux

Ruby is usually preinstalled, but a version manager is recommended:

```bash
# macOS (Homebrew)
brew install chruby ruby-install
ruby-install ruby 3.3.5

# then, in this folder:
gem install bundler
bundle install
bundle exec jekyll serve --livereload
```

The SSL step (section 3) is Windows/corporate-specific and normally not needed
on macOS/Linux.

---

## Project structure

| Path | Purpose |
|------|---------|
| `index.html`, `experience.html`, `research.html`, `skills.html`, `contact.html` | Page content (front matter + body) |
| `_layouts/default.html` | Shared page shell (html, head, nav, footer) |
| `_includes/head.html`, `nav.html`, `footer.html` | Reusable partials |
| `assets/style.css` | Shared stylesheet |
| `assets/*.jpg` | Images |
| `_config.yml` | Jekyll configuration |
| `Gemfile` | Ruby dependencies (pins the github-pages gem) |
| `serve.bat` | One-click local preview launcher (Windows) |
| `CNAME` | Custom domain (`rupeshprasad.com`) |

The header, navigation, and footer live once in `_layouts` / `_includes`; each
page file contains only its own content. Change a shared part once and it updates
on every page.

---

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| `ruby` / `bundle` "not recognized" | Close and reopen the terminal after installing Ruby so PATH updates. |
| SSL / certificate errors on `bundle install` | Do section 3 (SSL fix), then retry. |
| `Address already in use` on port 4000 | A server is already running, or use a different port: `bundle exec jekyll serve --port 4001`. |
| Build error mentioning `vendor/bundle` | Ensure `vendor` is in the `exclude:` list in `_config.yml` (it already is). |
| Page shows raw `{{ }}` / `{% %}` or no styling | You opened the raw `.html` file directly. Use the server (`localhost:4000`) instead — Jekyll must build the page first. |
| Changes not showing | Hard-refresh the browser (Ctrl+Shift+R), or restart the server. |
