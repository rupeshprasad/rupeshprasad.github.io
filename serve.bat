@echo off
REM ============================================================
REM  Local preview server for rupeshprasad.com (Jekyll)
REM  Double-click this file to start a local preview.
REM  Then open http://localhost:4000/ in your browser.
REM  Press Ctrl+C in this window to stop the server.
REM ============================================================

cd /d "%~dp0"

REM Point Ruby/Bundler at the Windows certificate bundle so gem/
REM plugin downloads work behind corporate SSL inspection (Netskope).
if exist "%USERPROFILE%\.certs\windows-ca-bundle.pem" (
    set "SSL_CERT_FILE=%USERPROFILE%\.certs\windows-ca-bundle.pem"
)

echo.
echo ============================================================
echo   Starting local preview for rupeshprasad.com
echo   Open http://localhost:4000/ in your browser
echo   Press Ctrl+C here to stop
echo ============================================================
echo.

call bundle exec jekyll serve --livereload --host 127.0.0.1 --port 4000

REM Keep the window open if the server exits with an error
if errorlevel 1 (
    echo.
    echo The server stopped unexpectedly. See the messages above.
    pause
)
