# textinputplayground

An example Flutter project that demonstrates some common text input use cases.

See it running live on the web at: [justinmc.github.io/textinputkitchensink/](https://justinmc.github.io/textinputkitchensink/).

See a non-Flutter version of this app at: [justinmc.github.io/textinputkitchensink-web/](https://justinmc.github.io/textinputkitchensink-web/).

## Releasing on web
  1. flutter build web
  1. rm -rf docs
  1. cp -r build/web/ docs
  1. Modify docs/index.html <base href="/"> to <base href="/textinputkitchensink/">
  1. Commit and push to main.
