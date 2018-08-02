Art and Rare Materials (ARM) Ontology and Vocabulary Versioning and Change Management
==========================

Table of Contents
------------

* [Introduction](#intro)
* [Ontology Versioning](#ontology-versioning)
* [Vocabulary Versioning](#vocabulary-versioning)
* [Version Numbering](#version-numbering)
* [Issuance and Modification Datetimes](#datetimes)
* [Change Descriptions](#change-descriptions)


<a name="intro">Introduction</a>
------------

This document describes a process and protocol for versioning and change management of the ARM ontologies and vocabularies.


<a name="ontology-versioning">Ontology Versioning</a>
------------

The following protocols are used to version the ontologies. 

* The use of OWL versioning predicates follows the [OWL 2 specification](https://www.w3.org/TR/owl2-syntax/#Ontology_IRI_and_Version_IRI).
* `owl:ontologyIRI` identifies the unversioned ontology namespace; e.g., `https://w3id.org/arm/core/ontology/`.
* `owl:versionIRI` identifies a particular version of the ontology; e.g., `https://w3id.org/arm/core/ontology/0.1/`. 
* The `owl:ontologyIRI` redirects to the `owl:versionIRI` of the current version of the ontology.
* Previous versions of the ontology continue to be available at their `owl:versionIRI`.
* By importing or referencing terms from a particular `owl:versionIRI`, users are insulated from non-backward-compatible changes in newer published versions until they decide to upgrade.
* Version numbering (`MAJOR.MINOR.PATCH`). See [discussion below](#version-numbering) on two possible numbering conventions.
* The `owl:versionIRI` is updated for `MAJOR` and `MINOR` versions, but not `PATCH` versions. It thus includes only the `MAJOR` and `MINOR` version numbers.


<a name="vocabulary-versioning">Vocabulary Versioning</a>
------------

Several of the predicates used in the ontology versioning protocol are of type `owl:OntologyProperty` and thus cannot be used with our vocabularies, which are typed `void:Dataset` rather than
`owl:Ontology`.  In particular, `owl:ontologyIRI` and `owl:versionIRI` have domain `owl:Ontology`, so only versioned URIs are used for the vocabularies (e.g., `https://w3id.org/arm/core/vocabularies/typeface/0.1/`), using the same schema outlined for ontologies. Versioning is also supported by defining `owl:versionInfo` on the Dataset 
and following the conventions described below for use of [version numbers](#version-numbering), [issuance and modification datetimes](#datetimes), and [change descriptions](#change-descriptions). 

<a name="version-numbering">Version Numbering</a>
----------------

Two possible version number conventions are shown here. Note that Model A is more rigorously defined than Model B, because the latter uses subjective notions of "sufficiently large" and "sufficiently significant" alongside the
objective notions of backward- and non-backward-compatibility. Possibly Model B can be provided a fully objective formulation.

**MODEL A (the bibliotek-o model)**
    * `MAJOR`: non-backward-compatible modifications
    * `MINOR`: backward-compatible semantic modifications
    * `PATCH`: non-semantic modifications, such as fixing typos or adding rdfs:labels in other languages
    
**MODEL B:**
    * `MAJOR`: a sufficiently large set of sufficiently significant and non-backward-compatible changes so as to represent a new major version 
    * `MINOR`: non-backward-compatible semantic modifications
    * `PATCH`: backward-compatible semantic modifications as well as non-semantic modifications, such as fixing typos or adding rdfs:labels in other languages


* To avoid an unnecessary proliferation of `MAJOR` versions, `owl:deprecated` is applied to terms slated for removal. The precise implementation depends on the choice of Model A or B above:
  * Model A: A term deprecated in a `MINOR` version will be removed in the next `MAJOR` version
  * Model B: A term deprecated in a `PATCH` version will be removed in the next `MINOR` version

* `owl:versionInfo` provides a label containing the version number, formatted as "Version n.n.n"; e.g., "Version 1.1.0". This version number is also used to tag the repository, in this case `v1.1.0`. 
* `owl:priorVersion` provides the URI of the previous MAJOR.MINOR version of the ontology, if any.
* `owl:backwardCompatibleWith` or `owl:incompatibleWith` may also be used to reference previous `MAJOR.MINOR` versions of the ontology, where applicable.



<a name="datetimes">Issuance and Modification Datetimes</a>
------------

* `dcterms:issued` is used on each term, and on the ontology or vocabulary as a whole, to indicate datetime of first issuance.
* `dcterms:modified` is used on each term, and on the ontology or vocabulary as a whole, to indicate last modification datetime. 
* Terms not modified since first issuance have the same `dcterms:issued` and `dcterms:modified` values.
* Datetime values are expressed in ISO-8601 format; e.g., "2017-04-22T01:30:00-04:00".
* The `dcterms` values do not include extraneous text, so that they are machine-readable without parsing. Change descriptions are provided by `skos:changeNote` (see following section).

<a name="change-descriptions">Change Descriptions</a>
------------
* `skos:changeNote` is used to provide human-readable descriptions of term modifications. 
* One `skos:changeNote` is used per version. That is, if more than one change is made to the same term in the same version, all are recorded in the same change note. If multiple changes are made to the same term in different versions, they are recorded in multiple change notes.
* The change note also records the ontology or vocabulary version, so that modifications to a term can be traced through the affected versions of the ontology. The format used is, e.g., "Fix rdfs:label (v1.0.1)".
* A `skos:changeNote` could be applied to the ontology or vocabulary itself to record major, broad, or high-level changes affecting multiple terms.
* Changes are also recorded in change logs for each ontology, vocabulary, and application profile. 


