Art and Rare Materials (ARM) BIBFRAME Ontology Extension
==========================

Introduction
------------

The ontologies housed in this repository have been developed as extensions of the [BIBFRAME ontology](http://id.loc.gov/ontologies/bibframe/) for generalized bibliographic description to provide specialized modeling in the art and rare materials domains. These were originally conceived of as two separate projects: Columbia University led [ArtFrame](https://wiki.duraspace.org/display/LD4P/ArtFrame), an ontology extension for the description of two-and three-dimensional artworks, in collaboration with the Art Libraries Society of North America's [Cataloging Advisory Committee](https://www.arlisna.org/organization/committees/76-cataloging-advisory-committee) (ARLIS CAC), the Library of Congress Prints and Photographs Division, The Clark Library, and the Morgan Library & Museum. Meanwhile, Cornell University led the [Rare Materials Ontology Extension](https://wiki.duraspace.org/display/LD4P/Rare+Materials+Ontology+Extension) (RareMat) in collaboration with the ACRL Rare Books and Manuscript Section's [Bibliographic Standards Committee](http://rbms.info/committees/bibliographic_standards/) (RBMS-BSC); RareMat was intended to provide modeling for the complexity of rare materials, particularly item-level description not addressed in BIBFRAME. 

As work proceeded, it became apparent that many of the modeling needs of the two groups overlapped: physical description, physical condition and conservation, custodial history, measurements, awards and exhibitions, and so on. It was thus decided to merge the projects and jointly develop a single set of models. 

Meanwhile, select models were considered separable from the core models, amenable to independent implementation by users within and outside the bibliographic domain. These models have been pulled out of the core ontology into three modularized ontologies: awards, custodial history, and measurements.

In addition to ontologies, the group has generated several other outputs:
- A set of controlled vocabularies for arrangement of physical objects (e.g., rolled and unrolled), origin (e.g., of titles), status (e.g., of identifiers), typefaces, and handwriting types.
- Detailed documentation of each model. These include use cases; model overviews, with motivation and rationale in reference to the use cases and legacy data; diagrams; RDF samples; term specifications; recommendations for future modifications to BIBFRAME, where applicable; and lists of related topics out-of-scope of the current project but of interest for future research.
- Application profiles, formalized in SHACL and accompanied by external ontologies and vocabularies, to support form and display interfaces in [VitroLib](https://github.com/ld4l-labs/vitrolib), an RDF cataloging tool under development in the associated [Linked Data for Libraries Labs](https://wiki.duraspace.org/pages/viewpage.action?pageId=77447730) project. Two application profiles are under development: art and rare monographs.
- Experimental: SHACL validation profiles stored with the associated ontologies, which can be used as a basis for application profiles but whose primary purpose is to define expected implementation of the ontologies independent of any application. Some proof-of-concept application profiles are built on the validation SHACL in this way; when the profiles are complete we will evaluate the feasibility and usefulness of refactoring all the application profiles according to this model.

The Art and Rare Materials BIBFRAME Ontology Extension is a product of the Andrew W. Mellon Foundation funded Linked Data for Production (LD4P) project, 2016-2018. See the [LD4P public wiki](https://wiki.duraspace.org/pages/viewpage.action?pageId=74515029) for more information about this project. 

Adoption and use of these ontologies will be determined by RBMS-BSC and ARLIS CAC following initial development and assessment.

News
-------------

* **2018-04-27** Release of Version 0.1.0 of all ontologies and vocabularies.

Structure and Content of the Repository
--------------

The core ontology and the three modularized ontologies (award, custodial_history, and measurement) are each housed in a top-level directory, which contains the OWL ontology files, 
associated original vocabularies, human-readable documentation, and any SHACL validation profiles. 

The core ontology has been split into two OWL files, `core.rdf` and `activity.rdf`, because the issue of whether to adopt the BIBFRAME Contribution model
or the [bibliotek-o](http://bibliotek-o.org) Activity model is still unresolved. As a temporary accommodation, the Activity model is used, but the relevant terms are stored in a separate RDF file
for easy separation.

The [`application_profiles/sources/`](application_profiles/sources/) directory contains ontology and vocabulary fragments referenced in the modeling recommendations and application profiles. 
Two types of vocabularies are included:
* Fragments of existing RDF vocabularies, such as Getty AAT.
* RBMS vocabularies converted from XML to RDF. While in the absence of an RBMS-defined namespace they are namespaced within ARM, ARM does not claim ownership of these vocabularies nor does it publish them.

Some aspects of the directory structure and filenames are accommodations to the publication implementation. Specifically:
* GitHub does not recognize the `.owl` file extension, so we have used `.rdf` instead. Ideally we prefer the use of the `.owl` extension since these are OWL ontologies.
* For simplicity, the RDF files are published directly from the repository directory tree rather than from a separate document root. In order to use versioned namespaces 
(see [Ontology Versioning](#ontology-versioning)), we therefore store every published version of the files in the repository tree, as opposed to the more usual practice 
of identifying versions solely with tags on the repository.

### Directory Structure

* [`modeling_recommendations/`](modeling_recommendations/): Modeling recommendations

* [`core/`](core/): Core art and rare materials ontologies and vocabularies 
  * [`ontology/0.1/core.rdf`](core/ontology/0.1/core.rdf): Primary ontology file
  * [`ontology/0.1/doc/lode/core.html`](core/ontology/0.1/doc/): Human-readable documentation of primary ontology
  * [`ontology/0.1/activity.rdf`](core/ontology/0.1/activity.rdf): Secondary ontology file containing definitions of Activity classes and related predicates
  * [`ontology/0.1/doc/lode/activity.html`](core/ontology/0.1/doc/lode/activity.html): Human-readable documentation of Activity terms
  * [`vocabularies/`](core/vocabularies): Original ARM controlled vocabularies
    * [`vocabularies/arrangement/0.1/arrangement.rdf`](core/vocabularies/arrangement/0.1/arrangement.rdf): Arrangement
    * [`vocabularies/arrangement/0.1/doc/lode/arrangement.html`](core/vocabularies/arrangement/0.1/doc/lode/arrangement.html): Human-readable documentation of Arrangement vocabulary
    * [`vocabularies/handwriting_type/0.1/handwriting_type.rdf`](core/vocabularies/handwriting_type/0.1/handwriting_type.rdf): Handwriting type
    * [`vocabularies/handwriting_type/0.1/doc/lode/handwriting_type.html`](core/vocabularies/handwriting_type/0.1/doc/lode/handwriting_type.html): Human-readable documentation of Handwriting type vocabulary  
    * [`vocabularies/origin/0.1/origin.rdf`](core/vocabularies/origin/0.1/origin.rdf): Origin
    * [`vocabularies/origin/0.1/doc/lode/origin.html`](core/vocabularies/origin/0.1/doc/lode/origin.html): Human-readable documentation of Origin vocabulary
    * [`vocabularies/status/0.1/status.rdf`](core/vocabularies/status/0.1/status.rdf): Status
    * [`vocabularies/status/0.1/doc/lode/status.html`](core/vocabularies/status/0.1/doc/lode/status.html): Human-readable documentation of Status vocabulary
    * [`vocabularies/typeface/0.1/typeface.rdf`](core/vocabularies/typeface/0.1/typeface.rdf): Typeface
    * [`vocabularies/typeface/0.1/doc/lode/typeface.html`](core/vocabularies/typeface/0.1/doc/lode/typeface.html): Human-readable documentation of Typeface vocabulary
  * [`validation/`](core/validation/): SHACL validation files for the core ontology

    
* [`award/`](award/): Award ontology 
  * [`ontology/0.1/award.rdf`](award/ontology/0.1/award.rdf): Ontology file
  * [`ontology/0.1/doc/lode/award.html`](award/ontology/0.1/doc/lode/award.html): Human-readable documentation
  
* [`custodial_history/`](custodial_history/): Custodial history ontology 
  * [`ontology/0.1/custodial_history.rdf`](custodial_history/ontology/0.1/custodial_history.rdf): Ontology file
  * [`ontology/0.1/doc/lode/custodial_history.html`](custodial_history/ontology/0.1/doc/lode/custodial_history.html): Human-readable documentation
  
* [`measurement/`](measurement/): Measurement ontology 
  * [`ontology/0.1/measurement.rdf`](measurement/ontology/0.1/measurement.rdf): Ontology file
  * [`ontology/0.1/doc/lode/measurement.html`](measurement/ontology/0.1/doc/lode/measurement.html): Human-readable documentation
  
* [`application_profiles/`](application_profiles/): Application profiles 
  * [`art/shacl/`](application_profiles/art/shacl/): SHACL application profiles for artworks
  * [`raremat_monograph/shacl/`](application_profiles/raremat_monograph/shacl/): SHACL application profiles for rare materials monographs
  * [`sources/`](application_profiles/sources/): Source ontologies and vocabularies for the application profiles  
  
* [`tools/`](tools/): Tools used in support of the ontology and vocabulary development, such as XSL data conversion scripts or generating human-readable documentation
  
* [`doc/`](doc/): Informational documents


Versioning and Change Management
-----------

To support modularity, each ontology and vocabulary is versioned independently. SHACL validation and application profiles reference specific 
versions of these, but are not themselves versioned via namespace or version number but rather via GitHub.


### <a name="ontology-versioning">Ontology Versioning</a>

The following protocols are used to version the ontologies. 

* The use of OWL versioning predicates follows the [OWL 2 specification](https://www.w3.org/TR/owl2-syntax/#Ontology_IRI_and_Version_IRI).
* `owl:ontologyIRI` identifies the unversioned ontology namespace; e.g., `https://w3id.org/arm/core/ontology/`.
* `owl:versionIRI` identifies a particular version of the ontology; e.g., `https://w3id.org/arm/core/ontology/0.1/`. 
* The `owl:ontologyIRI` redirects to the `owl:versionIRI` of the current version of the ontology.
* Previous versions of the ontology continue to be available at their `owl:versionIRI`.
* By importing or referencing terms from a particular `owl:versionIRI`, users are insulated from non-backward-compatible changes in newer published versions until they decide to upgrade.
* Version numbering (`MAJOR.MINOR.PATCH`). See [discussion below](#numbering) on two possible numbering conventions.
* The `owl:versionIRI` is updated for `MAJOR` and `MINOR` versions, but not `PATCH` versions. It thus includes only the `MAJOR` and `MINOR` version numbers.

<a name="numbering">Two possible version number conventions are shown here.</a> Note that Model A is more rigorously defined than Model B, because the latter uses subjective notions of "sufficiently large" and "sufficiently significant" alongside the
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
* `owl:backwardCompatibleWith` or `owl:incompatibleWith` may also be used to reference previous MAJOR.MINOR versions of the ontology, where applicable.


### Issuance and Modification Datetimes

* `dcterms:issued` is used on each ontology term, and on the ontology as a whole, to indicate datetime of first issuance.
* `dcterms:modified` is used on each ontology term, and on the ontology as a whole, to indicate last modification datetime. 
* Terms not modified since first issuance have the same `dcterms:issued` and `dcterms:modified` values.
* Datetime values are expressed in ISO-8601 format; e.g., "2017-04-22T01:30:00-04:00".
* The `dcterms` values do not include extraneous text, so that they are machine-readable without parsing. Change descriptions are provided by `skos:changeNote` (see following section).

### Change Descriptions
* `skos:changeNote` is used to provide human-readable descriptions of term modifications. 
* One `skos:changeNote` is used per version. That is, if more than one change is made to the same term in the same version, all are recorded in the same change note. If multiple changes are made to the same term in different versions, they are recorded in multiple change notes.
* The change note also records the ontology version, so that modifications to a term can be traced through the affected versions of the ontology. The format used is, e.g., "Fix rdfs:label (v1.0.1)".
* A `skos:changeNote` could be applied to the ontology itself to record major, broad, or high-level changes affecting multiple terms.
* Changes are also recorded in change logs for each ontology, vocabulary, and application profile. 

### Vocabulary Versioning

Several of the predicates used in the ontology versioning protocol are of type `owl:OntologyProperty` and thus cannot be used with our vocabularies, which are typed `void:Dataset` rather than
`owl:Ontology`.  In particular, `owl:ontologyIRI` and `owl:versionIRI` have domain `owl:Ontology`, so only versioned URIs are used for the vocabularies (e.g., `https://w3id.org/arm/core/vocabularies/typeface/0.1/`), using the same schema outlined for ontologies. Versioning is also supported by defining `owl:versionInfo` on the Dataset; 
and following the protocols described above for use of timestamps and change descriptions. 
