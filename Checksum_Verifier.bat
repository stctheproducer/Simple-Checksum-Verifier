TITLE Checksum Verifier (Written by Chanda Mulenga)
:: ****************************
:: Script: Checksum Verifier 1.0.0.0
:: Created On: 30/08/2017
:: Last Modified On: 30/08/2017
:: Author: Chanda Mulenga
:: E-mail: stconeten@gmail.com
:: ****************************
:: Description:  This program compares checksums of a selected file
::               with newly generated checksums to ensure file integrity.
::               It must be run in same folder as the file being verified.
:: ****************************


@ECHO off
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
ECHO Checksum Verifier 1.0.0.0
ECHO Written by Chanda Mulenga
ECHO Email: stconeten@gmail.com &ECHO.

ECHO -----------------------------------------------------------------
ECHO ENSURE THE FILE IS IN THE SAME DIRECTORY. INCLUDE FILE EXTENSION.
ECHO -----------------------------------------------------------------
SET /P file="Enter filename (include file extension): "

::Generate checksums
CALL calcMD5 %file%
CALL calcSHA1 %file%
CALL calcSHA256 %file%
CALL calcSHA512 %file%

::Store checksums in variables and delete temporal file
FOR /F "skip=1 delims=" %%i IN (tmpFile.txt) DO IF NOT DEFINED genMD5 SET "genMD5=%%i"
FOR /F "skip=4 delims=" %%i IN (tmpFile.txt) DO IF NOT DEFINED genSHA1 SET "genSHA1=%%i"
FOR /F "skip=7 delims=" %%i IN (tmpFile.txt) DO IF NOT DEFINED genSHA256 SET "genSHA256=%%i"
FOR /F "skip=10 delims=" %%i IN (tmpFile.txt) DO IF NOT DEFINED genSHA512 SET "genSHA512=%%i"
DEL tmpFile.txt

::Convert checksums to upper case
CALL :UCase genMD5 GENMD5
CALL :UCase genSHA1 GENSHA1
CALL :UCase genSHA256 GENSHA256
CALL :UCase genSHA512 GENSHA512

:MENU
ECHO.
ECHO ***************************************************
ECHO               GENERATED CHECKSUMS
ECHO ***************************************************
ECHO.
ECHO    MD5: %GENMD5%
ECHO   SHA1: %GENSHA1%
ECHO SHA256: %GENSHA256%
ECHO SHA512: %GENSHA512%
ECHO.
ECHO ***************************************************
ECHO               SELECT A TASK BELOW
ECHO ***************************************************
ECHO.
ECHO [1] Compare MD5 checksum with generated checksum
ECHO [2] Compare SHA1 checksum with generated checksum
ECHO [3] Compare SHA256 checksum with generated checksum
ECHO [4] Compare SHA512 checksum with generated checksum
ECHO [Q] Quit program
ECHO.

SET /P P="Your choice: "
IF %P%==1 GOTO :MD5 
IF %P%==2 GOTO :SHA1
IF %P%==3 GOTO :SHA256
IF %P%==4 GOTO :SHA512
IF /I "%P%"=="Q" GOTO :QUIT

::Compare MD5 checksum
:MD5
ECHO.
SET /P checksum="MD5 checksum to verify: " &ECHO.
ECHO Your input: %checksum%
ECHO  Generated: %GENMD5%
ECHO. & ECHO Now verifying... & ECHO.

IF /I "%checksum%"=="%GENMD5%" (
    ECHO Your file is OK &ECHO.
) ELSE (
    ECHO ERROR: Your file is corrupt &ECHO.
)

GOTO :ASK

::Compare SHA1 checksum
:SHA1
ECHO.
SET /P checksum="SHA1 checksum to verify: " &ECHO.
ECHO Your input: %checksum%
ECHO  Generated: %GENSHA1%
ECHO. & ECHO Now verifying... & ECHO.

IF /I "%checksum%"=="%GENSHA1%" (
    ECHO Your file is OK &ECHO.
) ELSE (
    ECHO ERROR: Your file is corrupt &ECHO.
)

GOTO :ASK

::Compare SHA256 checksum
:SHA256
ECHO.
SET /P checksum="SHA256 checksum to verify: " &ECHO.
ECHO Your input: %checksum%
ECHO  Generated: %GENSHA256%
ECHO. & ECHO Now verifying... & ECHO.

IF /I "%checksum%"=="%GENSHA256%" (
    ECHO Your file is OK &ECHO.
) ELSE (
    ECHO ERROR: Your file is corrupt &ECHO.
)

GOTO :ASK

::Compare SHA512 checksum
:SHA512
ECHO.
SET /P checksum="SHA512 checksum to verify: " &ECHO.
ECHO Your input: %checksum%
ECHO  Generated: %GENSHA512%
ECHO. & ECHO Now verifying... & ECHO.

IF /I "%checksum%"=="%GEN512%" (
    ECHO Your file is OK &ECHO.
) ELSE (
    ECHO ERROR: Your file is corrupt &ECHO.
)

GOTO :ASK

:LCase
:UCase
:: Converts to upper/lower case variable contents
:: Syntax: CALL :UCase _VAR1 _VAR2
:: Syntax: CALL :LCase _VAR1 _VAR2
:: _VAR1 = Variable NAME whose VALUE is to be converted to upper/lower case
:: _VAR2 = NAME of variable to hold the converted value
:: Note: Use variable NAMES in the CALL, not values (pass "by reference")

SET _UCase=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
SET _LCase=a b c d e f g h i j k l m n o p q r s t u v w x y z
SET _Lib_UCase_Tmp=!%1!
IF /I "%0"==":UCase" SET _Abet=%_UCase%
IF /I "%0"==":LCase" SET _Abet=%_LCase%
FOR %%Z IN (%_Abet%) DO SET _Lib_UCase_Tmp=!_Lib_UCase_Tmp:%%Z=%%Z!
SET %2=%_Lib_UCase_Tmp%
GOTO :EOF

::Prompt user to go to menu
:ASK
SET /P C="Do you want to go back to the menu? [Y/N]"
IF /I "%C%"=="Y" CLS && GOTO :MENU
IF /I "%C%"=="N" GOTO :QUIT

::Quit program
:QUIT
ECHO.
ECHO The program will now close... & ECHO. & PAUSE
CLS

ENDLOCAL