- [What is my exit status?](#What-is-my-exit-status)
- [No error exit status](#No-error-exit-status)
- [General errors ```x```](#General-errors-x)
- [Errors while compiling ```1x```](#Errors-while-compiling-1x)
- [Errors in script ```9x```](#Errors-in-script-9x)
- [General UNIX exit statuses](#General-UNIX-exit-statuses)

## What is my exit status?
To find out with what status ATT exited use following command:
```bash
## in bash (default in most Linux distributions) and most other shells
echo $?

## in fish shell
echo $status
```

> Which shell am I using?
> ```bash
> echo $0
> ```

## No error exit status

| No. of exit status | Description |
|:------------------:|-------------|
| 0 | no error |
| 42 | no error, finnished |

_Default exit status without errors is __42___.

## General errors ```x```

| No. of exit status | Description |
|:------------------:|-------------|
| 1 | not enough arguments |
| 2 | language not supported |
| 3 | returned in help() function, no errors |

## Errors while compiling ```1x```

| No. of exit status | Description |
|:------------------:|-------------|
| 11 | compilling failed due to erros reported by compiler |
| 12 | compiling failed due to warnings reported by compiler |

## Errors in script ```9x```
> Those errors should not encored during running ATT. If there appear, create new issue in repository on GitHub.

| No. of exit status | Description |
|:------------------:|-------------|
| 91 | error while compiling (function for compiling not found) |
| 92 | error while running |

## General UNIX exit statuses

| No. of exit status | Description |
|:------------------:|-------------|
| 130 | process killed using ```ctrl + c``` |