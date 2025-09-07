# Mergemeta Extension For Quarto

This extension is a workaround for quarto projects that use common `_quarto.yaml` or `_metadata.yaml` metadata and share (custom) yaml keys between document and project yaml. Currently (quarto 1.7.33), custom document yaml mostly overwrites the corresponding yaml keys from `_quarto.yaml` or `_metadata.yaml`. With this filter, selected keys can be merged instead of overwritten. This is useful for updating long yaml list as they may occur for example with the [`search-replace`](https://github.com/ute/search-replace) extension. 

## Installing

```bash
quarto add ute/mergemeta
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

To define mergeable yaml keys in the document, they need to have a different name. With the present filter, you can then merge the document yaml into the project or folder yaml. 

In the document yaml, use
```yaml
filters:
  - mergemeta
  - customfilters # some filters that evaluates the yaml data

myKeys:
  # some definitions only for the present document, e.g.
  A: "awesome"

# now use myKeys to update the keys in metadata intended for your other filters, e.g. customKeys 

mergemeta:
   customKeys: myKeys
```


## Example

Here is the source code for an example: [example.qmd](example.qmd).
To run the example, copy [_metadata.yml](_metadata.yml) into the same folder.
