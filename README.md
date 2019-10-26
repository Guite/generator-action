# GitHub Action for ModuleStudio Generator
This repository contains a GitHub Action for using the standalone generator from ModuleStudio.

The standalone generator is always providing the latest Git revision of [the generator's project](https://github.com/Guite/MostGenerator/).

## Inputs

### `model-name`
**Required** Full name of your model file. Default `"AcmeNews.mostapp"`.

### `model-name`
**Required** Name of your module including the vendor and the `Module` suffix. Default `"Acme/NewsModule"`.

## Outputs

### `results`
Generated files.

## Example usage

```
uses: guite/generator-action@v1
with:
  model-name: 'MultiHook.mostapp'
  module-name: 'Zikula/MultiHookModule'
```

A dummy project using this GitHub Action can be found [here](https://github.com/Guite/TestGenGHA).
