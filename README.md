# batmobile
a bat script that turbocharges windows terminal navigation and replaces all needs for cd, cd.. and cd + TAB until match

## Replacing cd with c

Comparison:
go from current dir to domaintests

```plaintext
root
├── source
│   └── repos
│       ├── my_foo_dir
│       ├── my_bar_dir
│       │   ├── app
│       │   ├── apptests
│       │   ├── domain
│       │   └── domaintests  <--
```

using the batmobile (c.bat) script:
![using batmobile c.bat script](./gifs/batmobile_navigate.gif)
using cd
![using cd](./gifs/cd_navigate.gif)

## Replacing cd.. with c
Calling c without any arguments is the equivalent of calling cd..

## Replacing cd + TAB on multiple matches
using the "-l" command allows for choosing a match for a search that will then be remembered until the terminal session is ended

## todos
- [X] Persist list choice for next resolve
- [X] multi string search support
 if the second input is not "-l" also do a string contains search on that
  - [X] update documentation
- [X] fix null file bug
 repro: c into dir - src dir now has weird file

- [-] Cool documentation
  - [X] comparison (use foobar thing)
    - [X] comparison multi string support
  - [X] new vid with more intricate paths + zoom
  - [X] make them exactly the same length time

  - [ ] comparison go back
  - [ ] persist choice on multiple match in terminal session


