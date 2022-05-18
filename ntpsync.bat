@echo off

echo.
echo =================================================
echo   管理者権限で実行する必要があるため
echo   ユーザアクセス制御(UAC)ダイアログが表示されたら
echo   「はい」をクリックしてください。
echo =================================================
echo.

for /f "tokens=3 delims=\ " %%A in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%A
if not "%LEVEL%"=="High" (
powershell -NoProfile -ExecutionPolicy Unrestricted -Command "Start-Process \"%~f0\" -Verb runas"
exit
)

rem Windows Timeサービス (W32Time) 状態判定
sc query W32Time | findstr STATE | findstr RUNNING > NUL
if %ERRORLEVEL% neq 0 (
rem Windows Timeサービス (W32Time) を開始
echo.
echo ==============================================
echo   Windows Timeサービス W32Time を開始します。
echo ==============================================
echo.
net start W32Time
echo.
echo ========================================================================= 
echo   失敗した場合は、「設定」から「時刻を自動的に設定する」を検索し、
echo   「時刻を自動的に設定する」を「ON」にして再度このバッチファイルを
echo   実行してください。
echo ========================================================================= 
echo. 
timeout /T 10 > NUL
)

echo.
echo ====================
echo   時刻を同期します。
echo ====================
echo.
w32tm /resync
echo 同期しました。

echo.
echo ====================================
echo   最終同期時刻をご確認ください
echo ====================================
echo.

w32tm /query /status
echo 時刻同期完了しました。
timeout /T 5
pause
exit
