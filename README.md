# GitHub Action for ModuleStudio Generator

This repository contains a GitHub Action for using the standalone generator from ModuleStudio.

The standalone generator is always providing the latest Git revision of [the generator's project](https://github.com/Guite/MostGenerator/).

## Inputs

1. Full name of your model file. Default `"AcmeNews.mostapp"`.
2. Name of your module including the vendor and the `Module` suffix. Default `"Acme/NewsModule"`.
3. Path to the directory containing the `extensions/` folder (including trailing slash). Default `""`.
4. Whether to enable verbose output (set to `true`). Default `false`.

## Outputs

### `results`

Generated files.

## Example usage

```
uses: docker://guite/generator-action:latest
with:
  args: MultiHook.mostapp Zikula/MultiHookModule src/ true
```

A sample project using this GitHub Action can be found [here](https://github.com/Guite/test-actions).

## Usage without GitHub Actions

The Docker image for this action is built automatically and located here: <https://hub.docker.com/r/guite/generator-action>.

You can run it in any given directory like this:

```
docker run --rm -it -w=/app -v ${PWD}:/app guite/generator-action:latest MultiHook.mostapp Zikula/MultiHookModule src/ true
```
