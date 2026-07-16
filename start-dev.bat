@echo off
REM Sailing Log - local preview server
REM Double-click this file (or run it) to start the dev server, then open http://localhost:8000
cd /d "%~dp0"
echo Starting Sailing Log preview at http://localhost:8000  (press Ctrl+C to stop)
npx -y serve -l 8000
