# textinputplayground

An example Flutter project that demonstrates some common text input use cases.

See it running live on the web at: [justinmc.github.io/textinputkitchensink/](https://justinmc.github.io/textinputkitchensink/).

## Releasing on web
  1. flutter build web
  1. rm -rf docs
  1. cp -r build/web/ docs
  1. Modify docs/index.html <base href="/"> to <base href="/textinputkitchensync/">
  1. Commit and push to main.
