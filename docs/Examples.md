- [Base case](#Base-case)
- [Base case, different language](#Base-case-different-language)
- [Base case, different timeout value](#Base-case-different-timeout-value)
- [Base case, emoji disabled](#Base-case-emoji-disabled)
- [Base case, showing time per test case](#Base-case-showing-time-per-test-case)
- [Compile with warnings](#Compile-with-warnings)
- [Source code is in other directory](#Source-code-is-in-other-directory)

## Base case
Tested program and ATT are in "." directory, input data and test cases are in default locations (_input data: ./input test cases: ./testCases_). Source code is written in default language (_Java_) and it is called _Program.java_.

```bash
bash att Program
```

Output example in command line:
```bash
❔  Testing: Program.java
✔  Compiling: OK

✔  test1.txt     OK 
✔  test2.txt     OK 
✔  test3.txt     OK 
✔  test4.txt     OK 
✔  test5.txt     OK 
✔  test6.txt     OK 
⌛  test7.txt   Timeout
Result: 6/7 (85%) �
```

## Base case, different language
Tested program and ATT are in "." directory, input data and test cases are in default locations (_input data: ./input test cases: ./testCases_). Source code is written in C language (_c_) and it is called _Program.c_.

```bash
bash att Program -l c
```

Output example in command line:
```bash
❔  Testing: Program.c
✔  Compiling: OK

✔  test1.txt     OK 
✔  test2.txt     OK 
✔  test3.txt     OK 
✔  test4.txt     OK 
✔  test5.txt     OK 
Result: 5/5 (100%) � � �
```

## Base case, different timeout value
Tested program and ATT are in "." directory, input data and test cases are in default locations (_input data: ./input test cases: ./testCases_). Source code is written in default language (_Java_) and it is called _Program.java_. Timeout value is changed to 2 second.

```bash
bash att Program -t 2
```
```bash
bash att Program -t 2s
```

## Base case, emoji disabled
Tested program and ATT are in "." directory, input data and test cases are in default locations (_input data: ./input test cases: ./testCases_). Source code is written in default language (_Java_) and it is called _Program.java_. Emojis are not shown.

```bash
bash att Program -e false
```

Output example in command line:
```bash
Testing: Program.java
Compiling: OK

test1.txt        OK 
test2.txt        OK 
test3.txt        OK 
test4.txt        OK 
test5.txt        OK 
test6.txt        OK 
test7.txt       Timeout
Result: 6/7 (85%)
```

## Base case, showing time per test case
Tested program and ATT are in "." directory, input data and test cases are in default locations (_input data: ./input test cases: ./testCases_). Source code is written in default language (_Java_) and it is called _Program.java_. Command line showing time per test case.

```bash
bash att Program -times
```

Output example in command line:
```bash
❔  Testing: Program.java
✔  Compiling: OK

✔  test1.txt     OK  (387 ms)
✔  test2.txt     OK  (191 ms)
✔  test3.txt     OK  (173 ms)
✔  test4.txt     OK  (187 ms)
✔  test5.txt     OK  (183 ms)
✔  test6.txt     OK  (233 ms)
⌛  test7.txt   Timeout
Result: 6/7 (85%) �
```

## Compile with warnings
Tested program and ATT are in "." directory, input data and test cases are in default locations (_input data: ./input test cases: ./testCases_). Source code is written in C and it is called _Program.c_. Source code is compiled with warnings.

```bash
bash att Program -w true
```

```bash
bash att Program -times
```

Output example in command line:
```bash
❔  Testing: Program.c
Compiled with warnings
✖  test01.txt    NOK
✖  test02.txt    NOK
✔  test03.txt    OK 
✔  test04.txt    OK 
✔  test05.txt    OK 
Result: 3/5 (60%) �
```


## Source code is in other directory
ATT is in current "." directory, tested program, input data and test cases are in subdirectory (_example_). Language is default (_java_), tested program is called _Program.java_.

```bash
bash att Program -p example
```