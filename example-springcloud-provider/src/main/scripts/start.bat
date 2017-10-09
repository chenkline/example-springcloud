@ECHO OFF
echo "Example Provider Service"

set "OLD_CURRENT_DIR=%cd%"

cd /d %~dp0/..

set "CURRENT_DIR=%cd%"
if not "%SERVICE_HOME%" == "" goto gotHome
set "SERVICE_HOME=%CURRENT_DIR%"
if exist "%SERVICE_HOME%\bin\start.bat" goto okHome
cd ..
set "SERVICE_HOME=%cd%"
cd "%CURRENT_DIR%"
:gotHome
if exist "%SERVICE_HOME%\bin\start.bat" goto okHome
    echo The SERVICE_HOME environment variable is not defined correctly
    echo This environment variable is needed to run this program
goto end
:okHome

rem Set JavaHome if it exists
if exist { "%JAVA_HOME%\bin\java" } (
    set "JAVA="%JAVA_HOME%\bin\java""
)

mkdir "%SERVICE_HOME%\log"

echo Using JAVA_HOME:       "%JAVA_HOME%"
echo Using SERVICE_HOME:   "%SERVICE_HOME%"

set JAVA_OPTS=
set JAVA_OPTS_SCRIPT=
set LOG_STDOUT_FILE=%SERVICE_HOME%\log\stdout.txt
echo LOG into file: %LOG_STDOUT_FILE%  

cd /d %OLD_CURRENT_DIR%
%JAVA% -Dspring.config.location="file:%SERVICE_HOME%\config\bootstrap.yml" %JAVA_OPTS% %JAVA_OPTS_SCRIPT% -cp %SERVICE_HOME%\lib\* cxy.example.ExampleProviderApp >> %LOG_STDOUT_FILE% &
