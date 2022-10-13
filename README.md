# Zotero Bibliography
<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Zotero Bibliography](#zotero-bibliography)
- [Introduction](#introduction)
- [Zotero Export Formats](#zotero-export-formats)
    - [Intro](#intro)
    - [BibLatex](#biblatex)
    - [Better BibLatex](#better-biblatex)
    - [BibTex](#bibtex)
    - [Better BibTex](#better-bibtex)
    - [Better BibTex JSON](#better-bibtex-json)
    - [Zotero RDF](#zotero-rdf)
    - [Bibliontology RDF](#bibliontology-rdf)
    - [COiNS](#coins)
    - [Collected Notes](#collected-notes)
    - [Citation Graph](#citation-graph)
    - [Better CSL YAML](#better-csl-yaml)
    - [Citation Key](#citation-key)
- [Normalize Tags](#normalize-tags)

<!-- markdown-toc end -->

# Introduction

The ACCORD project uses a shared Zotero bibliography [Semantic BIM](https://www.zotero.org/groups/3007408/semantic_bim).

Gdoc [Zotero Productivity # Tag Normalization](https://docs.google.com/document/d/16x4FxvBpBp1rjvnkRArOTTW5ZmScOzBW9v5KT1zh4xQ/edit#heading=h.9ktxpbwgwzb) describes ideas how to use Zotero and additional goodies, 
and should become an agreed "local guide" on how we use it.
  
This project includes Zotero `export` (in various formats) and other files for processing Zotero data.
In particular, we have these ideas:

- [Normalize Tags](#normalize-tags)
- Map tags to Wikidata and OpenAlex topics. 
  However, WD is missing even our root topic "automated compliance checking", so we'll need to build up
- Build a Mind Map of the domain, perhaps using Zotero export to "The Brain"
- Build a comprehensive Citation Network
- Build a semantic Knowledge Graph

# Zotero Export Formats

## Intro

- Install [zotero-better-bibtex](https://github.com/retorquere/zotero-better-bibtex/releases), which doubles the number of output formats
- Rclick on the collection "Semantic BIM"
- Export
- Try out each one of the formats
  - Select UTF-8
  - Select maximum options (notes etc)
- Have Tools> Developer> Error Console open so you can record errors
  - "Clear" this often if the list gets too large

For RDF formats, convert them to Turtle for easier reading and validation, 
eg Zotero RDF was invalid 9 years ago (see https://github.com/aurimasv/zotero-import-export-formats/issues/4):
```
riot --formatted=turtle "Zotero.rdf"  1>Zotero RDF.ttl
11:08:17 ERROR riot            :: [line: 1380, col: 59] {E205} rdf:resource is not allowed as an element tag here.
```

TODO:
- If we want to auto-publish some of the formats, see https://retorque.re/zotero-better-bibtex/exporting/auto/
- It's also possible to pull up to date bibliography from latex, see https://retorque.re/zotero-better-bibtex/exporting/pull/


## BibLatex
`biblatex.bib`
- human-readable
- exports abstract, extra (`note`), tags (`keywords`), notes (`annotation`)
- generates good citation keys
- handles special chars in tags
- needlessly quotes uppercase words `{...}` (but tools take care of this)

```
	keywords = {@read, {GraphQL}, {GraphSPARQL}, knowledge graphs, linked data, {SPARQL}},
	annotation = {How does this compare to Ontotext Semantic Objects {GraphQL}?
```
Missing:
- collection
- year, month (but "date" is there)
- date added, modified
- TODO

## Better BibLatex
`better-biblatex.bib`

The ordering is different, so it's not so easy to compare them
- Better and more flexible citekey generation
- Excessive quoting of capitalized words, eg `{{BIM}}`
- TODO

## BibTex
TODO

Should be pretty similar to BibLatex, but maybe doesn't support UTF-8 as well?

## Better BibTex
TODO

## Better BibTex JSON
`better-bibtex-json.json`

Good JSON that mimics the Bibtex fields

## Zotero RDF
`zotero.rdf, zotero.ttl`

- Uses relative URLs but doesn't define `@base`
- Tags are in dc:subject;
  - manually added as string: `"hybrid" , "RDF"`
  - ingested with metadata as node: `[rdf:type   z:AutomaticTag; rdf:value  "Data interoperability"]`
- `dc:date` is not normalized, comes as entered (although Zotero recognizes the `d-m-y` parts)
- 56% of items also have `dcterms:dateSubmitted` (eg "2021-05-09 19:57:03", not quite XSD format).
  This is date creatd, but maybe only for those that were modified after adding.
  Also, inconsistent time offsets are applied between what I see in Zotero and what is recorded.

## Bibliontology RDF
`bibliontology.ttl, bibliontology.rdf`

These are partial files due to this error:
```
[JavaScript Error: "item.creators is undefined" {file: "chrome://zotero/content/xpcom/translation/translate_firefox.js line 425 > eval" line: 1097}]
```
The only item without Creator is a Standlone note (which is just text and has no metadata).
- Posted https://forums.zotero.org/discussion/100000/bug-bibliontology-rdf-fails-on-standalone-note
- (The Zotero RDF exporter doesn't have this bug)

## COiNS
`coins.html`

Metadata Embedded in HTML spans.
This is only useful if you want to publish metadata to some other 

## Collected Notes
`collected-notes.html, collected-notes.md`

- Dump of library content:
  - Each collection is a seciton
  - Each item is a line, followed by
  - All notes about the item, including images
- IF an item is in 2 collections, it is printed twice, with all its notes

## Citation Graph
`citation-graph.dot`

Graphviz dot source to generate a citation graph.
- But because we don't have any "related" links, there's no graph

## Better CSL YAML
`better-csl-yaml.yaml`

## Citation Key
`better-citation-key.txt`

A long `\cite{}` with the keys of all selected items

# Normalize Tags

go to `tag_normalization/README.md`



