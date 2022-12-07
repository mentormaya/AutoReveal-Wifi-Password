@echo off

::
:: (c) Elias Bachaalany <lallousz-x86@yahoo.com>
:: Batchography: The Art of Batch Files Programming
::

setlocal enabledelayedexpansion

:main
    title WiFiPasswordReveal v1.0 (c) ajaysingh.com.np - The Batchography book
    echo WiFiPasswordReveal v1.0 (c) ajaysingh.com.np - The Batchography book > "wifi.txt"
    
    echo.
    echo. >> "wifi.txt"
    echo Reveal all saved WiFi passwords Batch file script v1.0 (c) ajaysingh.com.np
    echo Reveal all saved WiFi passwords Batch file script v1.0 (c) ajaysingh.com.np >> "wifi.txt"
    echo.
    echo. >> "wifi.txt"
    echo Inspired by the book "Batchography: The Art of Batch Files Programming"
    echo Inspired by the book "Batchography: The Art of Batch Files Programming" >> "wifi.txt"
    echo.
    echo. >> "wifi.txt"

    :: Get all the profiles
    call :get-profiles r

    :: For each profile, try to get the password
    :main-next-profile
        for /f "tokens=1* delims=," %%a in ("%r%") do (
            call :get-profile-key "%%a" key
            if "!key!" NEQ "" (
                echo WiFi: [%%a] Password: [!key!]
                echo WiFi: [%%a] Password: [!key!] >> "wifi.txt"
            )
            set r=%%b
        )
        if "%r%" NEQ "" goto main-next-profile

    echo.
    @REM pause

    goto :eof

::
:: Get the WiFi key of a given profile
:get-profile-key <1=profile-name> <2=out-profile-key>
    setlocal

    set result=

    FOR /F "usebackq tokens=2 delims=:" %%a in (
        `netsh wlan show profile name^="%~1" key^=clear ^| findstr /C:"Key Content"`) DO (
        set result=%%a
        set result=!result:~1!
    )
    (
        endlocal
        set %2=%result%
    )

    goto :eof

::
:: Get all network profiles (comma separated) into the result result-variable
:get-profiles <1=result-variable>
    setlocal

    set result=

   
    FOR /F "usebackq tokens=2 delims=:" %%a in (
        `netsh wlan show profiles ^| findstr /C:"All User Profile"`) DO (
        set val=%%a
        set val=!val:~1!

        set result=%!val!,!result!
    )
    (
        endlocal
        set %1=%result:~0,-1%
    )

    goto :eof