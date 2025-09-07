# Mergemeta Extension For Quarto

This extension is a work-around for quarto projects that use common `_quarto.yaml` or `_metadata.yaml` metadata. Currently (quarto 1.7.33), custom document yaml mostly overwrites the corresponding yaml keys from `_quarto.yaml` or `_metadata.yaml`. With this filter, selected keys can be merged instead of overwritten. This is useful for updating long yaml list as they may occur e.g. with the [`search-replace`](https://github.com/ute/search-replace) extension

## Installing

```bash
quarto add ute/mergemeta
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

_TODO_: Describe how to use your extension.

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).

