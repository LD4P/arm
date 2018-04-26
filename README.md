Art and Rare Materials Ontologies
==========================

Introduction
------------

The ontologies housed in this repository have been developed as extensions of the [BIBFRAME ontology](http://id.loc.gov/ontologies/bibframe/) 
for generalized bibliographic description to provide specialized modeling in the art and rare materials domains. These were originally conceived of as
two separate projects: Columbia University led the art ontology project to describe both two-and three-dimensional artworks, while the rare materials 
project, led by Cornell University in conjunction with the ACRL Rare Books and Manuscript Section's Bibliographic Standards Committee (RBMS-BSC), was
intended to provide modeling for the complexity of rare materials, particularly item-level description not addressed in BIBFRAME. 

As work proceeded, it became apparent that most of the modeling needs of the two groups overlapped: physical description, physical condition and conservation,
custodial history, measurements, awards and exhibitions, and so on. It was thus decided to merge the projects and jointly develop a single set of models. 
At the same time, some of the models being developed were seen to be separable from the core models and amenable to independent implementation, and by users outside the 
bibliographic domain who would not be interested in the bibliocentric parts of the modeling. These models have been pulled out of the core
ontology into three modularized ontologies for description of awards, custodial history, and measurements.

In addition to the ontologies, the group has generated several other outputs:
- A set of controlled vocabularies for arrangement of physical objects (e.g., rolled and unrolled), origin (e.g., of titles), status (e.g., of identifiers), 
and typefaces.
- Detailed recommendations for every aspect of the modeling. These include use cases; model overviews with motivation and rationale
in reference to the use cases and legacy data; diagrams; RDF samples; term specifications; recommendations for future modifications to BIBFRAME, where applicable; 
and lists of related topics out of scope of the current project but of interest for future research.
- Application profiles, formalized in SHACL and accompanied by external ontologies and vocabularies, to support form and display interfaces 
in [VitroLib](https://github.com/ld4l-labs/vitrolib), an RDF cataloging tool under development in the associated 
[Linked Data for Libraries Labs](https://wiki.duraspace.org/pages/viewpage.action?pageId=77447730) project to support experimental
RDF cataloging based on these ontologies. Two application profiles are under development, one for art and one for rare monographs; these may be merged
when complete if there proves to be enough overlap for that to be feasible and productive.
- Experimental: SHACL validation profiles stored with the associated ontologies, which can be used as a basis for application profiles but whose primary
purpose is to define expected implementation of the ontologies independent of any application. Some current proof-of-concept application profiles are built on the validation
SHACL in this way, but when complete we will evaluate the feasibility and usefulness of refactoring all the application profiles
according to this model.

The Art and Rare Materials ontologies are a product of the Mellon Foundation-funded Linked Data for Production (LD4P) project, 2016-2018. 
See the [LD4P public wiki](https://wiki.duraspace.org/pages/viewpage.action?pageId=74515029) for more information about this project. 

Adoption and use of these ontologies will be determined by RBMS-BSC and ARLIS **[MELANIE: NOT SURE IF ARLIS SHOULD BE MENTIONED HERE, and if so whether
it should also be mentioned in the first paragraph, and full name given, as for RBMS]** following initial development and assessment.

News
-------------

* **2018-04-27** Release of Version 0.1 of all ontologies and vocabularies.

Structure of the Repository
--------------

The core ontology and the three modularized ontologies are each housed in their own top-level directory, which contains the OWL ontology files, 
associated vocabularies, human-readable documentation, and SHACL validation profiles (in progress). Also at the top level of the directory tree
are the modeling recommendations and the SHACL application profiles. 

Versioning
-----------

To support modularity, each ontology and vocabulary is versioned independently. SHACL validation and application profiles reference specific 
versions of these, but are not themselves versioned via namespace or version number but rather via GitHub.


### Ontology versioning

The following protocols are used to version the ontologies. 

* The use of OWL versioning predicates follows the [OWL 2 specification](https://www.w3.org/TR/owl2-syntax/#Ontology_IRI_and_Version_IRI).
* `owl:ontologyIRI` identifies the unversioned ontology namespace; e.g., `https://w3id.org/arm/core/ontology/`.
* `owl:versionIRI` identifies a particular version of the ontology; e.g., `https://w3id.org/arm/core/ontology/0.1/`. 
* The `owl:ontologyIRI` redirects to the `owl:versionIRI` of the current version of the ontology.
* Previous versions of the ontology continue to be available at their `owl:versionIRI`.
* By importing or referencing terms from a particular `owl:versionIRI`, users are insulated from non-backward-compatible changes in newer published versions until they decide to upgrade.
* Version numbering convention (`MAJOR.MINOR.PATCH`):

**[JAK/SF/MW/SW: TWO MODELS - which one do we prefer?]**

**[MODEL A: (bibliotek-o)]**

    * `MAJOR`: non-backward-compatible modifications
    * `MINOR`: backward-compatible semantic modifications
    * `PATCH`: non-semantic modifications, such as fixing typos or adding rdfs:labels in other languages
    
**[MODEL B:]**

    * `MAJOR`: a sufficiently large set of sufficiently significant and non-backward-compatible changes so as to represent a new major version 
    **[THIS IS SUBJECTIVE - CAN WE COME UP WITH A RIGOROUS DEFINITION?]**
    * `MINOR`: non-backward-compatible semantic modifications
    * `PATCH`: backward-compatible semantic modifications as well as non-semantic modifications, such as fixing typos or adding rdfs:labels in other languages
    
* The `owl:versionIRI` is updated for `MAJOR` and `MINOR` versions, but not `PATCH` versions. It thus includes only the `MAJOR` and `MINOR` version numbers.

**[NB: The following applies to MODEL A. If we use MODEL B, we would deprecate in the patch and remove in the next minor or major version.]**

* To avoid an unnecessary proliferation of `MAJOR` versions, `owl:deprecated` is applied to terms slated for removal. A term deprecated in a `MINOR` version will be removed in the next `MAJOR` version. 

* `owl:versionInfo` provides a label containing the version number, formatted as "Version n.n.n"; e.g., "Version 1.1.0". This version number is also used to tag the repository, in this case `v1.1.0`. 
* `owl:priorVersion` provides the URI of the previous MAJOR.MINOR version of the ontology, if any.
* `owl:backwardCompatibleWith` or `owl:incompatibleWith` may also be used to reference previous MAJOR.MINOR versions of the ontology, where applicable.


### Issuance and modification datetimes
* `dcterms:issued` is used on each ontology term, and on the ontology as a whole, to indicate datetime of first issuance.
* `dcterms:modified` is used on each ontology term, and on the ontology as a whole, to indicate last modification datetime. 
* Terms not modified since first issuance have the same `dcterms:issued` and `dcterms:modified` values.
* Datetime values are expressed in ISO-8601 format; e.g., "2017-04-22T01:30:00-04:00".
* The `dcterms` values do not include extraneous text, so that they are machine-readable without parsing. Change descriptions are provided by `skos:changeNote` (see following section).

### Change descriptions
* `skos:changeNote` is used to provide human-readable descriptions of term modifications. 
* One `skos:changeNote` is used per version. That is, if more than one change is made to the same term in the same version, all are recorded in the same change note. If multiple changes are made to the same term in different versions, they are recorded in multiple change notes.
* The change note also records the ontology version, so that modifications to a term can be traced through the affected versions of the ontology. The format used is, e.g., "Fix rdfs:label (v1.0.1)".
* A `skos:changeNote` could be applied to the ontology itself to record major, broad, or high-level changes affecting multiple terms.
* Changes are also recorded in change logs for each ontology, vocabulary, and application profile. 

### Vocabulary versioning

Several of the predicates used in the ontology versioning protocol are of type `owl:OntologyProperty` and thus cannot be used with our vocabularies, which are typed `void:Dataset` rather than
`owl:Ontology`.  Vocabularies are versioned by including version number in the URI (e.g., https://w3id.org/arm/core/vocabularies/typeface/0.1/) , using the same schema outlined for ontologies; defining `owl:versionInfo` on the Dataset; 
and following the protocols described above for use of timestamps and change descriptions. 
