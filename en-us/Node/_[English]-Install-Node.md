`PlatON` supports different installation methods and different operating environments, Please find the installation guide according to your needs:


- Source code compilation and installation
  - [Ubuntu installation](#Ubuntu-source-code-compilation-and-installation)
  - [Windows installation](#Windows-source-code-compilation-and-installation)
- PPA installation
  - [Ubuntu installation](#PPA-source-installation-under-Ubuntu)

After the node installation is complete, need to start the node to join the network, please refer to the [Network](/en-us/Network/[English]-MainNet-and-TestNet.md). To become a validator node, please refer to the [Install Validator](/en-us/Node/[English]-Install-Validator.md).



## Ubuntu source code compilation and installation


Ubuntu compilation environment requirements:

 
- System version: `Ubuntu 18.04.1 and above`
- git: `2.19.1 and above`
- Compilers: `gcc (4.9.2+)`, `g ++ (5.0+)`
- Go language development kit: `go (1.7+)`
- cmake: `3.0 +`

 

##### Get the source code


```
git clone -b release-0.9.0 https://github.com/PlatONnetwork/PlatON-Go.git --recursive 
```


##### Compile


```bash
cd PlatON-Go;
find ./build -name "*.sh" -exec chmod u+x {} \;
make all;
```

After compilation is complete, a series of executable files such as `platon` will be generated in the` PlatON-Go/build/bin` directory. You can copy the executable file to your own working directory and run it according to your needs.




## Windows source code compilation and installation


Windows compilation environment requirements :


- git: `2.19.1 and above`
- Go language development kit: `go (1.7+)`
- mingw: `mingw (V8.1.0)`
- cmake: `3.0 +`


You can install the above compilation environment yourself. Please make sure the above environment can run normally before compiling `PlatON` source code.


> You can also use `Chocolatey` to install the compilation environment (if you do not already have `chocolatey`, you can follow the instructions on <https://chocolatey.org> to install), start `PowerShell` as an administrator, and then execute the following command:
>
> Install git:
>
> ```
> choco install git
> ```
>
> Install golang:
>
> ```
> choco install golang
> ```
>
> Install mingw:
>
> ```
> choco install mingw
> ```
>
> Install cmake:
>
> ```
> choco install cmake
> ```
>
> Most software installed using the `chocolatey` package manager has a default installation path, and some software may have various paths, depending on the publisher of the software. Installing these packages will modify the Path environment variable. The final installation path can be viewed in the PATH. Some machine environments may not find the installation path of these tools in the PATH, and you need to add it manually at this time. After installation, please make sure the installed Go version is 1.7 (or higher).
>
> For example: After installing cmake, type cmake on the CMD command line. If you are prompted that the command cannot be found, you need to add the path where cmake is installed.

 

##### Get the source code

 

Create `src/github.com/PlatONnetwork/` and `bin` directories under the current`% GOPATH% `directory, and clone the source code of` PlatON-GO` under the `PlatONnetwork` directory:


```
cd src/github.com/PlatONnetwork/;
git clone -b release-0.9.0 https://github.com/PlatONnetwork/PlatON-Go.git --recursive
```

 

##### Compile

 

> The following compilation commands need to be run in the `Git-bash` environment, and the compilation environment in step 1 has been successfully installed!

 

Go to the source directory `PlatON-Go`:

 

```
cd PlatON-Go
```

 

Before compiling the source directory, execute the following script in the source directory `PlatON-Go` to compile the required libraries:

 

```
./build/build_deps.sh
```

Since the compilation depends on the bls library, PlatON-Go\crypto\bls\bls_win\lib needs to be configured into the path environment variable of the system.

Otherwise it will report `exit status 3221225781` error.

 

Executing the following compilation commands in the source directory `PlatON-Go` can generate` platon`, `keytool` executable files, as follows:

 

```
go run build/ci.go install ./cmd/platon
go run build/ci.go install ./cmd/keytool
```

 

After compiling, `platon`,` keytool` executable files will be generated in the` PlatON-Go/build/bin` directory. Copy these three executable files to your working directory and run.

 

> Repeated compilation will overwrite the previously generated executable file.



## PPA source installation under Ubuntu

Currently only supports PPA of Ubuntu 18.04.1 or above. Please choose the correct Ubuntu version.


Add PPA:


```bash
sudo add-apt-repository ppa:ppatwo/platon
```


Perform the update:


```bash
sudo apt-get update
```

Install PlatON:

 

```bash
sudo apt-get install platon0.9.0
```


After the installation is complete, the executable files will be installed to: `/usr/bin/`.
