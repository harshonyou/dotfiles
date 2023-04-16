### Stow

```zsh
# Flags 
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

```zsh
# Example
stow --adopt -nvt ~ *
```
