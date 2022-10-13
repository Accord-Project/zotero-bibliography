# Tag Normalization

- gdoc [Zotero Productivity # Tag Normalization](https://docs.google.com/document/d/16x4FxvBpBp1rjvnkRArOTTW5ZmScOzBW9v5KT1zh4xQ/edit#heading=h.9ktxpbwgwzb)
- issue https://github.com/windingwind/zotero-tag/issues/38 REQ: tag cleanup (normalize/canonicalize tags)
- colab notebook with [experiments](https://drive.google.com/file/d/1czcGCdG8l5p1X1GgaD09RIxd07AdVVNP/view?usp=sharing)

First we need to export the tags from a library. For now two ways:

## Zotero-tag Addon

The creator of the [addon](https://github.com/windingwind/zotero-tag) assited in creating a an export function that gathers all tags, counts them and lists their location. Check `tags_original.csv`

Pros:

 - easy to use

Cons:

 - the array of titles is quoted but uses ',' as a separtor and bugs the python parser -> calc or excel parses it correctly and can change the field seperator to a ';' making usable in pandas.

### Further steps

The author can help with a feature to replace the tags with their normalized version.

 --> If so, prepare a two-column file with original and normalized tags as input. 

## Zotero API

The [Zotero API](https://www.zotero.org/support/dev/web_api/v3/start) permits to do custom read/write requests on items in a zotero library.
Python library pyzotero helps with the tasks

Pros:

 - can achieve our task with the help of custom logic.

Cons:

 - Not AS easy as using the addon

### Further steps

Write cusotm  logic if author doesn't make feature.

## Normalization of tags

To the clustering on the tags, two options:

### OpenRefine

We can treat the tags manually. [List of clustering algos](https://docs.openrefine.org/technical-reference/clustering-in-depth)

Pros:

 - todo

Cons:

 - todo

### sklearn

If using python this library is the basis for all ML stuff.

Pros:

 - Integrated in python, so everything can be automated

Cons:

 - todo

### Comparison










