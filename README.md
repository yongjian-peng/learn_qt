
## 运行指令

```powershell
$env:PATH='E:\Qt\Qt5.12\Tools\mingw1310_64\bin;E:\Qt\Qt5.12\6.10.2\mingw_64\bin;C:\ninja;' + $env:PATH
& 'E:\Qt\Qt5.12\Tools\CMake_64\bin\cmake.exe' -S . -B build -G Ninja -DCMAKE_PREFIX_PATH='E:\Qt\Qt5.12\6.10.2\mingw_64'
& 'E:\Qt\Qt5.12\Tools\CMake_64\bin\cmake.exe' --build build

```
