- [1) Install script on local PC](#1-Install-script-on-local-PC)
  - [Forking GitHub repository (prefered way)](#Forking-GitHub-repository-prefered-way)
  - [Downloading .zip file](#Downloading-zip-file)
- [2) Running script](#2-Running-script)
  - [Linux/MacOS](#LinuxMacOS)
  - [Microsoft Windows](#Microsoft-Windows)
- [3) Arguments](#3-Arguments)
  - [Supported languages ```-l```](#Supported-languages--l)
- [Examples](#Examples)

## 1) Install script on local PC
Script can be downloaded to PC in 2 ways:
### Forking GitHub repository (prefered way)
```bash
git clone https://github.com/JakMar17/ATT---Automatic-Testing-Tool.git
```
Further informations: [cloning repository](https://help.github.com/en/articles/cloning-a-repository)

### Downloading .zip file
You can download repository in .zip format by using [download link](https://github.com/JakMar17/ATT---Automatic-Testing-Tool/archive/master.zip).

## 2) Running script
### Linux/MacOS
Bash scripts are natively supported on both Linux and MacOS. Run it with either of this ways:
```bash
bash att <name of tested program> <arguments>
```

```bash
./att <name of tested program> <arguments>
```

### Microsoft Windows
Bash scripts are not supported on Microsoft Windows systems. But you can run ATT with _Linux subsystem_ (if your Windows version is 10 or up).

To run script using Linux subsytem you need to install subsystem firts (refer to [Windows Subsystem for Linux Installation Guide for Windows 10](https://docs.microsoft.com/en-us/windows/wsl/install-win10)).

After subsystem is installed you can run script in two ways:
1. open Linux subsystem, navigate to ATT directory and follow steps in [Linux/MacOS](#LinuxMacOS).
2. run command:

```bash
<name of subsystem> run bash att <name of tested program> <arguments>
## for example if Ubuntu subsystem is installed use
ubuntu run bash att <name of tested program> <arguments>
```

> #### Running ```sh``` command in Powershell
> Note that running Powershell command ```sh``` (for example: ```sh att <arguments>```) doesn't work.
> Given error:
> ```powershell
> ERROR: Invalid syntax. Default option is not allowed more than '1' time(s).
>Type "TIMEOUT /?" for usage.
>```

## 3) Arguments
Supported arguments:

| Argument | Name | Description | Example |
|:--------:|------|-------------|:-------:|
| -l _language_| Programming language | _Langugage that tested program's source code is written in_ | -l c|
| -p _path_ | Project path | _Where is source code and subdirectories stored_ | -p example |
| -i _path_ | Input path | _Where is input data stored, this is always subdirectory of project path_ | -i example/i |
| -o _path_ | Output path | _Where will output data be stored, this is always subdirectory of project path_ | -o example/o |
| -test _path_ | Input path | _Where are test cases stored, this is always subdirectory of project path_ | -test example/test |
| -e _boolean_ | Display emojis | _Display emojis, default is true_ | -e false |
| -w _boolean_ | Compile with warnings | _Compile with warnings, default is false_ | -w true |
| -t _number_ | Timeout | _Set timeout value per test case, default is 1 second._ | -t 0.5 |
| -times | Show time | _Show time per test case_ | -times

### Supported languages ```-l```
At this time those are supported languages in ATT (with their argument code)

| Language | Code | Example | Notes |
|:--------:|:----:|:-------:|-------|
| Java | ```java``` | ```att Program``` | _default_ |
| C | ```c``` | ```att Program -l c``` | - |

## Examples
Refere to [Examples](https://github.com/JakMar17/ATT---Automatic-Testing-Tool/wiki/Examples).