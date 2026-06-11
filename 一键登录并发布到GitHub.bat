@echo off
chcp 65001 >nul
setlocal
set "GH=C:\Program Files\GitHub CLI\gh.exe"
cd /d "%~dp0"

echo ============================================================
echo   小红薯助手 - GitHub 介绍页一键发布
echo ============================================================
echo.
echo 第 1 步：登录 GitHub（只需做一次）
echo   - 稍后会显示一个 8 位代码（XXXX-XXXX），请记下
echo   - 浏览器会自动打开，把代码粘进去、点 Authorize 即可
echo   - 如果没有 GitHub 账号，浏览器里先点 Sign up 注册一个
echo.
pause

"%GH%" auth login --hostname github.com --git-protocol https --web
if errorlevel 1 (
  echo.
  echo [!] 登录未完成，请重新运行本文件。
  pause
  exit /b 1
)

echo.
echo 第 2 步：创建仓库并发布...
"%GH%" repo create xiaohongshu-assistant-overview --public --source "%~dp0" --remote origin --push

if errorlevel 1 (
  echo.
  echo [!] 发布失败。常见原因：同名仓库已存在。
  echo     可改名后重试，或把下面这行里的名字换掉再单独运行：
  echo     gh repo create 新名字 --public --source . --remote origin --push
  pause
  exit /b 1
)

echo.
echo ============================================================
echo   发布成功！仓库地址已在上方显示。
echo   以后改了 README，在本文件夹运行：git add . ^&^& git commit -m "update" ^&^& git push
echo ============================================================
pause
