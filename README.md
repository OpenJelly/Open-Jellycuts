# Open Jellycuts
 An Open-Source version of Jellycuts

## Packages
This version of Jellycuts aims to use more modern Open Source packages for everything, improving upon the previous version of Jellycuts. Specifically this version includes [Runestone](https://github.com/simonbs/Runestone) and [Tree-Sitter](https://tree-sitter.github.io/tree-sitter/) as the backend for the text editor and language parsing.

- [Custom Runestone Fork](https://github.com/ActuallyTaylor/Runestone)
    - A custom Runestone fork is being used because the original packages Tree-sitter itself. To allow for neater code, I have pulled out treesitter and moved it to it's own Swift Package.
- [Tree-Sitter Fork](https://github.com/ActuallyTaylor/tree-sitter-spm)
    - This tree-sitter fork adds support for the Swift Package manager