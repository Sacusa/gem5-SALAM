# RELIEF

This README borrows from the original gem5-SALAM README.

## gem5-SALAM Setup

### Required Dependencies

#### All Required Dependencies

```bash
sudo apt install build-essential m4 scons python-dev libprotobuf-dev python-protobuf protobuf-compiler libgoogle-perftools-dev
```

#### GCC (The Compiler used)

``` bash
sudo apt install build-essential m4
```

#### SCons (Build Environment)

```bash
sudo apt install scons
```

#### Python 2 (Required Libraries)

```bash
sudo apt install python-dev
```

#### Protobuf (Used for trace playback and generation)

```bash
sudo apt-get install libprotobuf-dev python-protobuf protobuf-compiler libgoogle-perftools-dev
```

### Optional Dependencies

#### ARM GCC Cross Compiler

```bash
sudo apt-get install gcc-arm-none-eabi
```

#### LLVM/Clang Setup

To build LLVM, you need to have CMake installed. If you don't already have it installed, you can easily install it from the Ubuntu repositories.

```bash
sudo apt install cmake
```

First, clone the LLVM source from github.

```bash
git clone https://github.com/llvm/llvm-project.git
```

Since we are going to be using LLVM 3.8.1, we want to checkout the LLVM 3.8.x branch.

```bash
cd llvm-project/
git checkout release/3.8.x
```

Copy clang into the LLVM tools directory so it is build with it

```bash
cp -r clang llvm/tools
```

Next, make your build directory

```bash
mkdir build
cd build
```

Now that the build directory has been made, we can tell CMake to configure LLVM to be built with the options needed.

Below are some recommended CMake flags:

- DCMAKE_INSTALL_PREFIX: Changes your install directory to from /usr/local to a user defined value. This makes uninstalling and changing LLVM versions significantly easier.

- DLLVM_ENABLE_ASSERTIONS: Enables code assertions, which helps with debugging

- BUILD_SHARED_LIBS: Builds each LLVM component as a shared library. Helps reduce disk space used.

```bash
cmake -DCMAKE_INSTALL_PREFIX=<your_install_dir> -DBUILD_SHARED_LIBS=true - DLLVM_ENABLE_ASSERTIONS=true -G "Unix Makefiles" ../llvm
```

Now that the build environment is setup, you can go ahead and run make

```bash
make -j`nproc`
```

After the project is finished compiling, install the binaries to your defined directory.

```bash
make install
```

Finally, update your alternatives to point to your compiled binaries.

### Building gem5-SALAM

Once you have successfully installed all of the necessary dependencies, you can go ahead and build gem5. Below are the bash commands you would use to build the opt or debug binary.

```bash
scons build/ARM/gem5.opt -j`nproc`
```

```bash
scons build/ARM/gem5.debug -j`nproc`
```

For more information regarding the binary types, and other build information refer to the gem5 build documentation [here](https://www.gem5.org/documentation/general_docs/building).
