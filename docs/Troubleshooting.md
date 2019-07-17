- [Troubleshooting based on exit status](#Troubleshooting-based-on-exit-status)
  - [General errors ```x```](#General-errors-x)
    - [Not enough arguments](#Not-enough-arguments)
    - [Language not supported](#Language-not-supported)
  - [Errors while compiling ```1x```](#Errors-while-compiling-1x)
    - [Compiling failed due to errors](#Compiling-failed-due-to-errors)
    - [Compiling failed due to warnings](#Compiling-failed-due-to-warnings)
  - [Script errors ```9x```](#Script-errors-9x)
- ["Timeout" output](#%22Timeout%22-output)
- ["Error: diff returned ```x```, ignoring"](#%22Error-diff-returned-x-ignoring%22)
- [Reporting problems](#Reporting-problems)

## Troubleshooting based on exit status
For addition informations refer to [Examples](https://github.com/JakMar17/ATT---Automatic-Testing-Tool/wiki/Examples).

### General errors ```x```
#### Not enough arguments
Exit status: __1__\
Troubleshooting: refer to [Running script](https://github.com/JakMar17/ATT---Automatic-Testing-Tool/wiki/Getting-started/#2-Running-script)

#### Language not supported
Exit status: __2__
Troubleshooting: refer to [Supported languages](https://github.com/JakMar17/ATT---Automatic-Testing-Tool/wiki/Getting-started/#Supported-languages--l)

### Errors while compiling ```1x```
#### Compiling failed due to errors
Exit status: __11__
Troubleshooting: Compiling wasn't successful, there were errors. Check ```error.txt``` file to see compiler output.

#### Compiling failed due to warnings
Exit status: __12__
Troubleshooting: Compiler returns warnings:
1. Check ```error.txt``` file to see compiler output.
2. Use ```-w true``` to compile&test with warnings

### Script errors ```9x```
Report them as new issue on GitHub repository.

## "Timeout" output
Test case was aborted because tested program took more then $timeout value:
1. Increase timeout limit (_default is 1 second_) using ```-t _new timeout_```
2. Change source code of tested program

## "Error: diff returned ```x```, ignoring"
```diff``` had internal error while comparing 2 files, ```x``` is his internal exit status. Check its output in ```diff``` folder.
Common problems:
* test case does not exist in $testCases directory

## Reporting problems
Every problem that is not listed above should be reported in issues in GitHub repository.
