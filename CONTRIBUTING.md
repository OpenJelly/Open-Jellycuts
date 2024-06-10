<!-- omit in toc -->
# Contributing to Open Jellycuts

First off, thank you so much for taking the time to contribute! ❤️

All types of contributions are encouraged and valued. See the [Table of Contents](#table-of-contents) for different ways to help and details about how this project handles them. Please make sure to read the relevant section before making your contribution. It will make it a lot easier for us maintainers and smooth out the experience for all involved. The community looks forward to your contributions. 🎉

> And if you like the project, but just don't have time to contribute, that's fine. There are other easy ways to support the project and show your appreciation, which we would also be very happy about:
> - Star the project
> - Toot about it
> - Refer this project in your project's readme
> - Mention the project at local meetups and tell your friends/colleagues

<!-- omit in toc -->
## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [I Have a Question](#i-have-a-question)
- [I Want To Contribute](#i-want-to-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Enhancements](#suggesting-enhancements)
  - [Your First Code Contribution](#your-first-code-contribution)
  - [Improving The Documentation](#improving-the-documentation)
- [Styleguides](#styleguides)
  - [Commit Messages](#commit-messages)
- [Join The Project Team](#join-the-project-team)


## Code of Conduct

This project and everyone participating in it is governed by the
[Open Jellycuts Code of Conduct](https://github.com/OpenJelly/Open-Jellycuts/blob/master/CODE_OF_CONDUCT.md).
By participating, you are expected to uphold this code. Please report unacceptable behavior
to <jellycuts@gmaill.com>.


## I Have a Question

<!-- > Documentation for the main app needs to be created. If you want to ask a question, we assume that you have read the available [Documentation](https://jellycuts.com/). -->

Before you ask a question, it is best to search for existing [Issues](https://github.com/OpenJelly/Open-Jellycuts/issues) that might help you. In case you have found a suitable issue and still need clarification, you can write your question in this issue. It is also advisable to search the internet for answers first.

If you then still feel the need to ask a question and need clarification, we recommend the following:

- Open an [Issue](https://github.com/OpenJelly/Open-Jellycuts/issues/new).
- Provide as much context as you can about what you're running into.
- Provide project and platform versions (nodejs, npm, etc), depending on what seems relevant.

We will then take care of the issue as soon as possible.

<!--
You might want to create a separate issue tag for questions and include it in this description. People should then tag their issues accordingly.
-->

## I Want To Contribute

> ### Legal Notice <!-- omit in toc -->
> When contributing to this project, you must agree that you have authored 100% of the content, that you have the necessary rights to the content and that the content you contribute may be provided under the project license.

### Reporting Bugs

<!-- omit in toc -->
#### Before Submitting a Bug Report

A good bug report shouldn't leave others needing to chase you up for more information. Therefore, we ask you to investigate carefully, collect information and describe the issue in detail in your report. Please complete the following steps in advance to help us fix any potential bug as fast as possible.

- Make sure that you are using the latest version.
- Determine if your bug is really a bug and not an error on your side e.g. using incompatible environment components/versions (Make sure that you have read the [documentation](https://jellycuts.com/). If you are looking for support, you might want to check [this section](#i-have-a-question)).
- To see if other users have experienced (and potentially already solved) the same issue you are having, check if there is not already a bug report existing for your bug or error in the [bug tracker](https://github.com/OpenJelly/Open-Jellycuts/issues?q=label%3Abug).
- Also make sure to search the internet (including Stack Overflow) to see if users outside of the GitHub community have discussed the issue.
- Collect information about the bug:
  - Stack trace (Traceback)
  - OS, Platform and Version (Windows, Linux, macOS, x86, ARM)
  - Version of the interpreter, compiler, SDK, runtime environment, package manager, depending on what seems relevant.
  - Possibly your input and the output
  - Can you reliably reproduce the issue? And can you also reproduce it with older versions?

<!-- omit in toc -->
#### How Do I Submit a Good Bug Report?

> You must never report security related issues, vulnerabilities or bugs including sensitive information to the issue tracker, or elsewhere in public. Instead sensitive bugs must be sent by email to <jellycuts@gmaill.com>.
<!-- You may add a PGP key to allow the messages to be sent encrypted as well. -->

We use GitHub issues to track bugs and errors. If you run into an issue with the project:

- Open an [Issue](https://github.com/OpenJelly/Open-Jellycuts/issues/new). (Since we can't be sure at this point whether it is a bug or not, we ask you not to talk about a bug yet and not to label the issue.)
- Explain the behavior you would expect and the actual behavior.
- Please provide as much context as possible and describe the *reproduction steps* that someone else can follow to recreate the issue on their own. This usually includes your code. For good bug reports you should isolate the problem and create a reduced test case.
- Provide the information you collected in the previous section.

Once it's filed:

- The project team will label the issue accordingly.
- A team member will try to reproduce the issue with your provided steps. If there are no reproduction steps or no obvious way to reproduce the issue, the team will ask you for those steps and mark the issue as `needs-repro`. Bugs with the `needs-repro` tag will not be addressed until they are reproduced.
- If the team is able to reproduce the issue, it will be marked `needs-fix`, as well as possibly other tags (such as `critical`), and the issue will be left to be [implemented by someone](#your-first-code-contribution).


### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion for Open Jellycuts, **including completely new features and minor improvements to existing functionality**. Following these guidelines will help maintainers and the community to understand your suggestion and find related suggestions.

<!-- omit in toc -->
#### Before Submitting an Enhancement

- Make sure that you are using the latest version.
<!-- - Read the [documentation](https://jellycuts.com/) carefully and find out if the functionality is already covered, maybe by an individual configuration. -->
- Perform a [search](https://github.com/OpenJelly/Open-Jellycuts/issues) to see if the enhancement has already been suggested. If it has, add a comment to the existing issue instead of opening a new one.
- Find out whether your idea fits with the scope and aims of the project. It's up to you to make a strong case to convince the project's developers of the merits of this feature. Keep in mind that we want features that will be useful to the majority of our users and not just a small subset. If you're just targeting a minority of users, consider writing an add-on/plugin library.

<!-- omit in toc -->
#### How Do I Submit a Good Enhancement Suggestion?

Enhancement suggestions are tracked as [GitHub issues](https://github.com/OpenJelly/Open-Jellycuts/issues).

- Use a **clear and descriptive title** for the issue to identify the suggestion.
- Provide a **step-by-step description of the suggested enhancement** in as many details as possible.
- **Describe the current behavior** and **explain which behavior you expected to see instead** and why. At this point you can also tell which alternatives do not work for you.
- You may want to **include screenshots and animated GIFs** which help you demonstrate the steps or point out the part which the suggestion is related to. You can use [this tool](https://www.cockos.com/licecap/) to record GIFs on macOS and Windows, and [this tool](https://github.com/colinkeenan/silentcast) or [this tool](https://github.com/GNOME/byzanz) on Linux.
- **Explain why this enhancement would be useful** to most Open Jellycuts users. You may also want to point out the other projects that solved it better and which could serve as inspiration.

<!-- You might want to create an issue template for enhancement suggestions that can be used as a guide and that defines the structure of the information to be included. If you do so, reference it here in the description. -->

### Your First Code Contribution
The first steps in contributing to Open Jellycuts is getting the repository running on your machine!

#### Cloning the repository using the Terminal
To correctly clone the repository it is **VERY** important that you use the `--recursive` flag when using the `git clone` command. This will ensure that all of the correct submodules are cloned.
```
git clone --recursive https://github.com/OpenJelly/Open-Jellycuts.git
``` 

#### Cloning using a Git Client
A git client should be able to just take the url `https://github.com/OpenJelly/Open-Jellycuts` and properly clone all of the submodules. If you are missing submodules we recommend that you use the command line to clone instead of a client.

#### Setting up Xcode
This project is meant to be used with [Apple's Xcode IDE](https://developer.apple.com/xcode/). After you have cloned the repository your next step should be to open the Xcode project in the cloned directory. This will begin cloning all of the Swift Packages used by the project, this may take some time depending on your network so give it some time.

After you have cloned all of the Swift Packages the next step is to change the team identifier and bundle identifier in the signing page of the project settings. You should set these to your own values otherwise the project will not build on your system.

#### Adding a Key Provider
After you have cloned the repository and set up Xcode, you will see a build error. This error is caused by the PurchaseHandler not having a provided publicKey. This code is initially commented out because the file is a secondary file to an internal file that provides the App Store validation with a public key for verifying results from the server. 

All you need to do is uncomment the following line in `Open-PublicKey.swift`:

```swift
extension PurchaseHandler: PublicKeyProvider {
    static var publicKey: String {
        "INSERT_PUBLIC_SIGNING_KEY"
    }
}
```

#### Now write your enhancement or fix that bug!
It is now time to write code! Everything should be compiling and signing correctly if you have followed the above steps.

- If you had any issues throughout this process open an [Issue](https://github.com/OpenJelly/Open-Jellycuts/issues/new) and one of the maintainers will help you get everything resolved!

### Improving The Documentation
Currently Open-Jellycuts does not have any documentation. If you want to create some, Awesome! Currently the sister project [Open Jellycore](https://github.com/OpenJelly/Open-Jellycore) uses the [DocC](https://developer.apple.com/documentation/docc) documentation generation tool. Setting up DocC is fairly straightforward, the main part of documentation comes from adding documentation comments above all classes, structs and functions throughout the app.

## Styleguides
### Commit Messages
Commit messages do not have an particular style. Just make sure they make it clear what you changed.

## Join The Project Tea
Currently we are not accepting a new lead maintainers for the project. But we may be in the future!

<!-- omit in toc -->
## Attribution
This guide is based on the **contributing-gen**. [Make your own](https://github.com/bttger/contributing-gen)!
