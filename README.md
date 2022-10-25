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
COinS is an abbreviation for "ContextObjects in Spans". It's basically an html tag <span> with some metadata inside it. One of the use cases is to embed bibliographic citation to web pages.

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

# Export formats comparison

The result are based on comparing 4 item types:
- Journal article
- Video recording
- Conference paper
- Blog post

## Result table

| Export format | Missing values | Is a candidate | Additional notes |
|---|---|---|---|
| CSV |  | :white_check_mark: | Looks fine, the only concern is a csv format itself |
| bibliontology.rdf | Item type, Publication year, Date modified, Access date | :white_check_mark: | Looks like all "important" data are here |
| better-bibtex-json.json | Publication year, Short title | :white_check_mark: | There might be more tags than in csv file for some reasons. Few values are missing, but nothing critical |
| zotero.rdf | Key, Publication Year, Date Modified | :white_check_mark: | Looks good overall. That's and RDF format |
| MODS (XML data format) | Key, Publication year, Date modified, Running time, Access date | :white_check_mark: | Few values are missing in comparison to csv |
| endnote.xml | Key, Date added, Date modified, Access date | :white_check_mark: | Looks fine: XML format fits us and only few dates missing |
| better-csl.json | Key, Publication year, Access date, Manual tags, Automatic tags | :x: | Tags are missing, but this information looks important |
| ref-works-tagged.txt | Key, Date modified, Library catalog, Running time, Short title | :x: | Unsatisfactory format |
| RIS | Key, Date, Date modified, Running time, Short title | :x: | Unsatisfactory format |
| wikipeadia-сitation-еemplates.txt | Key, Item type, Abstract, Date added, Date modified, Library catalog, Manual tags, Automatic tags, Language | :x: | Unsatisfactory format. A lot of missing data |
| wikidata-quick-statements.txt | Key, Item type, Publication year, Abstract, Date added, Date modified, Access date, Library catalog, Automatic tags, Running time, ISBN, Publisher, Conference name, | :x: | Unsatisfactory format. A lot of missing data |
| unqualified-dublin-core.rdf | Key, Publication year, Publication title, Abstract note, Date added, Date modified, Access date, Pages, Issue, Volume, Journal abbreviation, Language, Library catalog, Extra, Manual tags, Automatic tags | :x: | A lot of missing data |
| TEI (XML data format) | Abstract note, Date, Date added, Date modified, Access date, Pages, Language, Library catalog, Extra, Manual tags, ISBN, DOI, Automatic tags, Conference name | :x: | A lot of missing data |
| simple-evernote-export.enex | Key, Item type, Publication year, Author, Publication title, ISSN, ISBN, DOI, Url, Abstract note, Date, Date added, Date modified, Access date, Pages, Issue, Volume, Journal abbreviation, Language, Library catalog, Extra | :x: | Unsatisfactory format. A lot of missing data |
| refer:biblx.txt | Key, Publication year, ISSN, DOI, Date added, Date modified, Access date, Library catalog, Extra, Running time, Conference name, Short title | :x: | A lot of missing data |
| csl.json | Key, Publication year, Date added, Date modified, Short title, Language, Manual tags, Automatic tags | :x: | A lot of missing data |
| collected-notes.html | No data exporting video recording, conference paper, blog post. Exporting journal article only title, authors and date presented | :x: | A lot of missing data |
| citation-graph.dot | No data | :x: |  |
| bookmarks.html | Key, Item type, Publication year, Author, Publication title, ISSN, DOI, Abstract note, Date, Date added, Date modified, Access date, Pages, Issue, Volume, Journal abbreviation, Language, Library catalog, Extra, Running time, Short title | :x: | A lot of missing data |
| bibtex.bib | Key, Item type, Date, Date added, Date modified, Access date, Library catalog, Running time, conference name, Short title | :x: | A lot of missing data |
| biblatex.bib | Key, Item type, Publication year, Date added, Date modified, Access date, Library catalog, Running time, Short title | :x: | A lot of missing data |
| better-csl-yaml.yaml | Key, Publication year, Date, Date added, Date modified, Short title, Language, Manual tags, Automatic tags | :x: | Might be a candidate if we don't care about the missing fields. From my point of view, tags might be important |
| better-bibtex-citation-key-quick-copy.txt | No data | :x: |  |
| better-bibtex.bib | Key, Publication year, Title, Url, Date added, Date modified, Access date, Library catalog, Running , Conference name, Short title | :x: | A lot of missing data |
| better-biblatex.bib | Key, Item type, Publication year, Date, Date modified, Library catalog, Running time, Short title | :x: | Might be a candidate, but there is other formats to choose with less missing data |
| coins.html | Key, Item type, Publication year, Url, Abstract, Date added, Date modified, Access date, Library catalog, Extra, Manual tags, Automatic tags, Running time | :x: | Unsatisfactory format. A lot of missing data |

# Normalize Tags

go to `tag_normalization/README.md`



