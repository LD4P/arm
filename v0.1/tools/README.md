# ARM Tools

## `build-lode-docs.py` -- Build HTML documentation

The Python script `build-lode-docs.py` uses the [LODE](http://www.essepuntato.it/lode) service to build HTML documentation for the ARM ontologies and vocabularies.

### Processing steps

The set of RDF ontology and vocabulary files to be processed is hard-coded into the `RDF_FILES` array of `build-lode-docs.py`. This is a list of paths relative to the repository root. It is also possible to use the `--src` argument to the script to process a single RDF file.

For each RDF ontology or vocabulary file, the script performs the following set of steps:

1. Reads the RDF/XML file for the ontology or vocabulary and makes two substitutions (based on simple string matches so potentially fragile):
  * `skos:definition` -> `rdfs:comment` - because the LODE script does not look for `skos:definition`.
  * `void:Dataset` -> `owl:Ontology` - because the LODE script is designed only to work with OWL ontologies and will ignore the `void:Dataset` descriptions used with the ARM vocabularies.
2. Extracts the namespace from either:
  * the `owl:versionIRI` property for the ontologies, or
  * the subject of the `owl:Ontology` type definition (was `void:Dataset` before substitution above) for the vocabularies.
3. Sends the modified RDF/XML to the LODE service and receives an HTML datastream in return.
4. Makes the following modifications:
  * The internal anchors are modified to use the property and class names so that property and class URIs can be made to resolve correctly after the redirect from the namespace URI changes them from a path element to a fragment id. For example, <https://w3id.org/arm/core/ontology/0.1/Attribution> becomes <https://ld4p.github.io/arm/core/ontology/0.1/core.html#Attribution> after redirect, which relies upon the internal anchor `#Attribution`.
  * Changes the anchor text "Ontology source" to "Vocabulary source" for vocabularies.
  * Make changes to present IRI and versionIRI which aren't in our `void:Dataset` description for the vocabularies. Takes the URI that LODE outputs as the IRI, strips version suffix for IRI, puts full URI in the versionURI field instead.
  * Fixes link target for source to use canonical URI.
  * Changes absolute URIs to LODE website for CSS, favicon, JavaScript to instead point to local copies in `/css/` and `/js/`.
5. Saves the modified HTML to a file with the same path and name as the RDF/XML input except with extension changed from `.rdf` to `.html` (e.g. processing `award/ontology/0.1/award.rdf` writes `award/ontology/0.1/award.html`).

Before committing updates it is useful to use `git diff` to see whether the changes make sense.

### Running

The script is written to be run with Python 3.5 or higher. It depends on the `requests` and `requests_toolbelt` modules which can be installed with `pip` or `easy_install` depending upon your Python setup:

```
> pip install requests requests_toolbelt
```

or

```
> easy_install requests requests_toolbelt
```

The script is designed to be run from the root directory of the ontology and with no arguments will produce/update documentation for all of the ontologies and vocabularies:

```
> python tools/build-lode-docs.py
```

Alternatively, it may be run on a single RDF file with:

```
> python tools/build-lode-docs.py --src award/ontology/0.1/award.rdf
INFO:root:Creating LODE docs for award/ontology/0.1/award.rdf
INFO:rdflib:RDFLib Version: 4.2.1
INFO:root: - namespace https://w3id.org/arm/award/ontology/0.1/
INFO:root: - replacing anchor d4e103 with AwardLonglist
...
INFO:root: - replacing anchor d4e61 with AwardGranterActivity
INFO:root: - written award/ontology/0.1/award.html
INFO:root:Done.
```

Adding the `-v` argument produces more verbose output, `-h` shows help.
