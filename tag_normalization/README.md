# Tag Normalization

- gdoc [Zotero Productivity # Tag Normalization](https://docs.google.com/document/d/16x4FxvBpBp1rjvnkRArOTTW5ZmScOzBW9v5KT1zh4xQ/edit#heading=h.9ktxpbwgwzb)
- issue https://github.com/windingwind/zotero-tag/issues/38 REQ: tag cleanup (normalize/canonicalize tags)


Tag normalization consists of the process of identifing tags that are duplicate(ex. LBD and Linked Building Data) the same thing and merge them into a single concept.

Additionally these normalized tags can be further transformed to an associated superconcept to help identify larger concepts within papers(ex. the Building Topology Ontology (BOT) can be associated with Linked Building Data (LBD) in general) 


## Methodology
  
First we'll need to export the tags en masse so we can edit them better as using the Zotero UI can be cumbersome.

### Export with Zotero-tag Addon

The creator of the [addon](https://github.com/windingwind/zotero-tag) assited in creating a an export function that gathers all tags, counts them and lists their location. Check `tags_original.csv` is an example.

Pros:

 - easy to use

Cons:

 - the array of titles is quoted but uses ',' as a separtor and bugs the python parser -> calc or excel parses it correctly and can change the field seperator to a ';' making usable in pandas.

### Editing Tags

#### OnToRefine project

In our hosted [OnToRefine](http://refine.ontotext.com/) project we have import the tags seen above as and added a new field *normalized_tags*.

There we have used the notion of [**clustering**](https://docs.openrefine.org/technical-reference/clustering-in-depth) to identify and merge simmillar-looking tags.

Pros:

 - Easier clustering with the GUI. Many different types of algos and parameter customization

Cons:

 - Algorithms can only fix typos in the tags. Can't help with abbreviated tags(BOT - > Building Ontology Topology (BOT))

#### Manual

Going in to the abstract of the paper we can search for the term and modify the value ourselves. This is necessary most of the times.

### Importing back to Zotero

#### Manual

Via clicking on a tag in the bottem-left of the Zotero UI we can modify a tag and it wil change the value of the tag in every occurence in the library.

#### Zotero Web API

We can access the items in the library via a the Web API using for example the python library [pyzotero](https://pyzotero.readthedocs.io/en/latest/#creating-and-updating-items).

```python
import pandas as pd
from pyzotero import zotero

zot = zotero.Zotero(3007408, 'group', 'Yv2xY0CH9vjjf40sQiVcCQt3')
library = zot.everything(zot.items())
for item in library:
    tags = item['data']['tags']
    ## find and change tag here
    zot.update_item(item)
```
This however requires searching up each and every item and doesn't provide the possibility of mass editing tags.

#### Javascript API

The [local API](https://www.zotero.org/support/dev/client_coding/javascript_api) provides more functionallty as it allows us to interact with the native Zotero class on your local installation.

In the UI, in the Tools → Developer menu, select Run JavaScript. The API is not well documented and users may struggle with the async nature of the API.

The given script `change_tags.js` can parse a *.csv*
like `tags_refined.csv` and update a tag form the *tag* with a value from the *normalized_tag* column. 












