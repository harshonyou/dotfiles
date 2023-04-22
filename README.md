
## Stow
GNU [`stow`](https://www.gnu.org/software/stow/) is required to use the dotfiles.

### Usage
```zsh
# <flags> : "explanation" 
-n
Dry run

-v
Debug mode

-S
Stow the package (defualt)

-D
Unstow the package

-d
Stow directory (default to current dir)

-t
Target directory (mostly $HOME aka ~) (default is parent of stow dir)

--adopt
Import existing files into stow package from the target
```

### Example
```zsh
stow --adopt -nvt ~ *
```
