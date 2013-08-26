ilastik-build-Linux
===================

Use buildem to compile ilastik and all its dependencies on Linux. Usage:

```
> mkdir <ilastik_build_dir>
> cd <ilastik_build_dir>
> git clone https://github.com/ilastik/ilastik-build-Linux.git
> mkdir build
> cd build
> cmake ../ilastik-build-Linux -D BUILDEM_DIR=<ilastik_build_dir>
> make           # or 'make -j8' for parallel builds
> make package   # to create a 'ilastik-0.6.a-Linux.tar.gz' binary installer
```
