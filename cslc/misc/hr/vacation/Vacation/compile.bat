path=%path%;C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727
md ..\vacationsite.tmp
aspnet_compiler -fixednames -u -v / -p ..\vacation ..\vacationsite.tmp
xcopy /i /e /y ..\vacationsite.tmp ..\vacationsite
rd /s /q ..\vacationsite.tmp
