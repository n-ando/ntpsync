@echo off

echo.
echo =================================================
echo   �Ǘ��Ҍ����Ŏ��s����K�v�����邽��
echo   ���[�U�A�N�Z�X����(UAC)�_�C�A���O���\�����ꂽ��
echo   �u�͂��v���N���b�N���Ă��������B
echo =================================================
echo.

for /f "tokens=3 delims=\ " %%A in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%A
if not "%LEVEL%"=="High" (
powershell -NoProfile -ExecutionPolicy Unrestricted -Command "Start-Process \"%~f0\" -Verb runas"
exit
)

rem Windows Time�T�[�r�X (W32Time) ��Ԕ���
sc query W32Time | findstr STATE | findstr RUNNING > NUL
if %ERRORLEVEL% neq 0 (
rem Windows Time�T�[�r�X (W32Time) ���J�n
echo.
echo ==============================================
echo   Windows Time�T�[�r�X W32Time ���J�n���܂��B
echo ==============================================
echo.
net start W32Time
echo.
echo ========================================================================= 
echo   ���s�����ꍇ�́A�u�ݒ�v����u�����������I�ɐݒ肷��v���������A
echo   �u�����������I�ɐݒ肷��v���uON�v�ɂ��čēx���̃o�b�`�t�@�C����
echo   ���s���Ă��������B
echo ========================================================================= 
echo. 
timeout /T 10 > NUL
)

echo.
echo ====================
echo   �����𓯊����܂��B
echo ====================
echo.
w32tm /resync
echo �������܂����B

echo.
echo ====================================
echo   �ŏI�������������m�F��������
echo ====================================
echo.

w32tm /query /status
echo ���������������܂����B
timeout /T 5
pause
exit
