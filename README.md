# Open Jellycuts
An Open-Source version of Jellycuts that will allow anyone to add features and improve upon Jellycuts!

## Packages
This version of Jellycuts aims to use more modern Open Source packages for everything, improving upon the previous version of Jellycuts. Specifically this version includes [Runestone](https://github.com/simonbs/Runestone) and [Tree-Sitter](https://tree-sitter.github.io/tree-sitter/) as the backend for the text editor and language parsing.

- [Custom Runestone Fork](https://github.com/ActuallyTaylor/Runestone)
    - A custom Runestone fork is being used because the original packages Tree-sitter itself. To allow for neater code, I have pulled out treesitter and moved it to it's own Swift Package.
- [Tree-Sitter Fork](https://github.com/ActuallyTaylor/tree-sitter-spm)
    - This tree-sitter fork adds support for the Swift Package manager

## Features (Compared to closed Jellycuts)
| Feature                    | Open Jellycuts                    | Private Jellycuts |
| -------------------------- | --------------------------------- | ----------------- |
| Open Jelly Files           | ✅                                | ✅                |
| Edit Jelly Files           | ✅                                | ✅                |
| Create Jelly Files         | ✅                                | ✅                |
| Compile Jell Files         | ✅                                | ✅                |
| Error Reporting            | ✅                                | ✅                |
| Project Settings           | ❌                                | ✅                |
| Documentation              | ✅                                | ✅                |
| Icon Creator               | ✅                                | ✅                |
| Dictionary Builder         | ✅ (No support for nested arrays) | ✅                |
| Jellycuts Bridge           | ❌                                | ✅                |
| Third-Party Object Storage | ❌                                | ✅                |
| Learning Center            | ❌                                | ✅                |
| Changelogs                 | ❌                                | ✅                |
| Editor Customization       | ❌                                | ✅                |
| App Icons                  | ❌                                | ✅                |
| App Tint                   | ❌                                | ✅                |
| Haptic Feedback            | ❌                                | ✅                |
| External Safari            | ❌                                | ✅                |
| Project Sort               | ❌                                | ✅                |
| Privacy Page               | ❌                                | ✅                |
| Credits Page               | ❌                                | ✅                |
| About Page                 | ❌                                | ✅                |
| Contact & Bug Report       | ❌                                | ✅                |
