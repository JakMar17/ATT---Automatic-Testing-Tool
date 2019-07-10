# ATT - Automatic Testing Tool

ATT is a tool to automaticly test your program with test cases and inputs.

## Getting Started

ATT can be used with Linux/UNIX based operating systems. Under certain conditions it can be used also on Windows 10 (with installed Linux subsystem or changing source code). 

### Prerequisites

You need system that fully support bash scripts. Running bash inside Powershell or CMD console on Windows using ```sh``` command breaks code.

>At this point you need to have source code of your testing programs __in the same directory__ as ATT bash script.

### Directory structure

```
|---Tester.sh
|
|---Program(source code for testing)
|---testCases*
|    |---test01**.txt
|    |---test02**.txt
|    |---...
|---input*
|    |---test01**.txt
|    |---test02**.txt
|    |---...
|---output*
     |---programOutput
     |    |---test01**.txt
     |    |---test02**.txt
     |    |---...
     |---diff
     |    |---test01**.txt
     |    |---test02**.txt
     |    |---...

* can be change using arguments
** can be different, but associated input and test case has to have same name (files in programOutput and diff folders will have same name also)
```

## Using ATT

ATT needs at least 1 argument given. That is __file name__ of source code that is being tested. __File name should be given without file extension.__ 

```bash
bash ./Tester.sh Hello
```

### Display help

You can display help screen using _help_ command.

```
bash ./Tester.sh help
```

### Additional arguments

* Language ```-l```: is used to change language of source file, default is Java (```java```)
  > supported languages: Java (```java```), C (```c```), C++ (```cpp```)
* Directory of test cases ```-test```: is used to change default directory of test cases, default is ```./testCases```
* Directory of input data ```-i```: change default directory of input data for running test program, default is ```./input```
* Directory of output data: change default diretory of output data (and its subfolders), default is ```./output``` (```./output/programOutput```, ```./output/diff```)
* Emoji displaying ```-e```: use ```false``` for not displaying emojis, default is ```true```
* Testing with warnings ```-w```: use ```true``` to continue testing after compiler returned warnings (supported on C and C++), default is ```false```

#### Examples
Run ATT with Program.c without emoji displaying and with warnings if given by compiler:
```bash
./Tester.sh Program -l c -e false -w true
```

## How does it work

ATT gets at least 1 argument (name of testing program without file extension), after that:
1. ATT reads any additional arguments given
2. ATT compiles program
   *   if compiler returns __error(s)__: ATT shows ```Compiling failed``` error and prints error messege into ```./output/programOutput``` folder _(if not changed with -o argument)_
   *   if compiler returns __warning(s)__: ATT exits or continues testing _(if changed with -w argument to ```true```)_
3. ATT test program with test cases: for every file in ```./input``` starts program and insert input data from that file
   * ATT returns __Timeout__: if execution time was equal or greater then time set in ATT _(default: 1 second)_
4. ATT compare output data store in ```./output/programOutput``` and test case data stored in ```./testCases```, files has to have same _.txt_ name, result of comparing is stored into file in ```./output/diff```
   *   ATT returns __OK__ if test case and program are the same
   *   ATT returns __NOK__ if test case and program are not the same

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on code of conduct, and the process for submitting pull requests to repository.


## Authors

* **Jakob Marušič** - *Initial work* - [JakMar17](https://github.com/jakmar17)
* _nothing to show here just yet_


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

_nothing to show here just yet_
