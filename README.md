# with-anybar [![Build Status](https://travis-ci.com/Linyxus/with-anybar.svg?branch=master)](https://travis-ci.com/Linyxus/with-anybar)
 Simple command line task monitoring with AnyBar.

## Install

To use `with-anybar`, you have to firstly install [AnyBar](https://github.com/tonsky/AnyBar). You can either download the dmg file available on the project website, or use Homebrew Cask:
```shell
brew cask install anybar
```

`with-anybar` can also be installed via Homebrew with:
```shell
brew install linyxus/tools/with-anybar
```

Or you can download prebuilt binaries from the release page.

`with-anybar` is only available on macOS.

## Usage

Firstly, please ensure that AnyBar is started and listening on **the default port (1738)**. Then, to monitor a command, say `nix-env -qaP hello`, type:
```
wab nix-env -qaP hello
```

You will see the anybar icon blinking while the command is running. The circle stops blinking as soon as the command is finished, and its color indicates the exit status of the command.
Green for success, and red for a failure.
