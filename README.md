# dynamight

Homebrew tap for [@abhijit424515](https://github.com/abhijit424515)'s apps.

```sh
brew tap abhijit424515/dynamight
```

## Casks

| Cask | What it is |
| --- | --- |
| [`tether`](https://github.com/abhijit424515/tether) | Menu bar app that keeps macOS audio on your preferred input and output devices across reconnects. |

```sh
brew install --cask --no-quarantine tether
```

### Why `--no-quarantine`

These apps are ad-hoc signed rather than notarized by Apple, which costs $99 a year.
Gatekeeper only checks files carrying the quarantine attribute, so skipping that
attribute lets an ad-hoc signed app launch normally. It also means you are choosing to
trust the source instead of Apple's notary service — the build scripts are in each app's
repository if you would rather read them and build it yourself.
