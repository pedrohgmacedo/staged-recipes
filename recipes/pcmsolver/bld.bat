@ECHO ON

cmake %CMAKE_ARGS% ^
      -G "Ninja" ^
      -S %SRC_DIR% ^
      -B build ^
      -D CMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
      -D CMAKE_BUILD_TYPE=Release ^
      -D CMAKE_C_COMPILER=clang-cl ^
      -D CMAKE_CXX_COMPILER=clang-cl ^
      -D CMAKE_Fortran_COMPILER=flang ^
      -D CMAKE_C_FLAGS="/wd4018 /wd4101 /wd4996 /EHsc %CFLAGS%" ^
      -D CMAKE_CXX_FLAGS="/wd4018 /wd4101 /wd4996 /EHsc %CXXFLAGS%" ^
      -D CMAKE_Fortran_FLAGS="%FFLAGS%" ^
      -D CMAKE_INSTALL_LIBDIR="lib" ^
      -D CMAKE_INSTALL_INCLUDEDIR="include" ^
      -D CMAKE_INSTALL_BINDIR="bin" ^
      -D CMAKE_INSTALL_DATADIR="share" ^
      -D PYMOD_INSTALL_LIBDIR="\..\..\Lib\site-packages" ^
      -D PYTHON_EXECUTABLE="%PYTHON%" ^
      -D CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON ^
      -D STATIC_LIBRARY_ONLY=ON ^
      -D BUILD_TESTING=OFF ^
      -D CMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
      -D ENABLE_OPENMP=OFF ^
      -D ENABLE_GENERIC=OFF ^
      -D ENABLE_TESTS=ON ^
      -D ENABLE_TIMER=OFF ^
      -D ENABLE_LOGGER=OFF ^
      -D BUILD_STANDALONE=ON ^
      -D ENABLE_CXX11_SUPPORT=ON

if errorlevel 1 exit 1

cmake --build build ^
      --config Release ^
      --target install ^
      -- -j %CPU_COUNT%
if errorlevel 1 exit 1

ctest --output-on-failure
if errorlevel 1 exit 1
