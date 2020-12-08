Art and Rare Materials (ARM) Repository Contents
==========================

Introduction
------------

This document describes the organization of the ARM repository.


Structure and Content of the Repository
--------------

The core ontology and the three modularized ontologies (award, custodial_history, and measurement) are each housed in a top-level directory, which contains the OWL ontology files, 
associated original vocabularies, human-readable documentation, and any SHACL validation profiles. 

The core ontology has been split into two OWL files, `core.rdf` and `activity.rdf`, because the issue of whether to adopt the BIBFRAME Contribution model
or the [bibliotek-o](http://bibliotek-o.org) Activity model is still unresolved. As a temporary accommodation, the Activity model is used, but the relevant terms are stored in a separate RDF file
for easy separation.

The [`/application_profiles/sources/`](../application_profiles/sources/) directory contains ontology and vocabulary fragments referenced in the modeling recommendations and application profiles. 
Two types of vocabularies are included:
* Fragments of existing RDF vocabularies, such as Getty AAT.
* RBMS vocabularies converted from XML to RDF. While in the absence of an RBMS-defined namespace they are namespaced within ARM, ARM does not claim ownership of these vocabularies nor does it publish them.

Some aspects of the directory structure and filenames are accommodations to the publication implementation. Specifically:
* GitHub does not recognize the `.owl` file extension, so we have used `.rdf` instead. Ideally we prefer the use of the `.owl` extension since these are OWL ontologies.
* For simplicity, the RDF files are published directly from the repository directory tree rather than from a separate document root. In order to use versioned namespaces 
(see [Versioning](versioning.md)), we therefore store every published version of the files in the repository tree, as opposed to the more usual practice 
of identifying versions solely with tags on the repository.
* The top-level `css` and `js` directories are used in the display of the human-readable LODE documentation pages. 

### Directory Structure

All paths are relative to the top level of the repository.

* [`README.md`](../README.md): Project overview

* [`modeling_recommendations`](../modeling_recommendations): Modeling recommendations

* [`core`](../core/): Core art and rare materials ontology and vocabularies 
  * [`ontology/0.1/core.rdf`](../core/ontology/0.1/core.rdf): Ontology file
  * [`ontology/0.1/core.html`](../core/ontology/0.1/core.html): Human-readable documentation of primary ontology
  * [`vocabularies`](../core/vocabularies): Original ARM controlled vocabularies
    * [`vocabularies/arrangement/0.1/arrangement.rdf`](../core/vocabularies/arrangement/0.1/arrangement.rdf): Arrangement
    * [`vocabularies/arrangement/0.1/arrangement.html`](../core/vocabularies/arrangement/0.1/arrangement.html): Human-readable documentation of Arrangement vocabulary
    * [`vocabularies/handwriting_type/0.1/handwriting_type.rdf`](../core/vocabularies/handwriting_type/0.1/handwriting_type.rdf): Handwriting type
    * [`vocabularies/handwriting_type/0.1/handwriting_type.html`](../core/vocabularies/handwriting_type/0.1/handwriting_type.html): Human-readable documentation of Handwriting type vocabulary  
    * [`vocabularies/origin/0.1/origin.rdf`](../core/vocabularies/origin/0.1/origin.rdf): Origin
    * [`vocabularies/origin/0.1/origin.html`](../core/vocabularies/origin/0.1/origin.html): Human-readable documentation of Origin vocabulary
    * [`vocabularies/status/0.1/status.rdf`](../core/vocabularies/status/0.1/status.rdf): Status
    * [`vocabularies/status/0.1/status.html`](../core/vocabularies/status/0.1/status.html): Human-readable documentation of Status vocabulary
    * [`vocabularies/typeface/0.1/typeface.rdf`](../core/vocabularies/typeface/0.1/typeface.rdf): Typeface
    * [`vocabularies/typeface/0.1/typeface.html`](../core/vocabularies/typeface/0.1/typeface.html): Human-readable documentation of Typeface vocabulary
  * [`validation/shacl`](../core/validation/shacl/): SHACL validation files for the core ontology
  
* [`activity`](../activity/): Secondary ontology for definitions of Activity classes and related predicates. See the [`README`](../README.md#activity) discussion on the status of this ontology. 
  * [`ontology/0.1/activity.rdf`](../activity/ontology/0.1/activity.rdf):Ontology file 
  * [`ontology/0.1/activity.html`](../activity/ontology/0.1/activity.html): Human-readable documentation of Activity terms
  * [`validation/shacl`](../activity/validation/shacl/): SHACL validation files for the activity ontology
    
* [`award`](../award): Award ontology 
  * [`ontology/0.1/award.rdf`](../award/ontology/0.1/award.rdf): Ontology file
  * [`ontology/0.1/award.html`](../award/ontology/0.1/award.html): Human-readable documentation
  
* [`custodial_history`](../custodial_history): Custodial history ontology 
  * [`ontology/0.1/custodial_history.rdf`](../custodial_history/ontology/0.1/custodial_history.rdf): Ontology file
  * [`ontology/0.1/custodial_history.html`](../custodial_history/ontology/0.1/custodial_history.html): Human-readable documentation
  * [`validation/shacl`](../custodial_history/validation/shacl/): SHACL validation files for the custodial history ontology
  
* [`measurement`](../measurement): Measurement ontology 
  * [`ontology/0.1/measurement.rdf`](../measurement/ontology/0.1/measurement.rdf): Ontology file
  * [`ontology/0.1/measurement.html`](../measurement/ontology/0.1/measurement.html): Human-readable documentation
  
* [`application_profiles`](../application_profiles): Application profiles 
  * [`art/shacl`](../application_profiles/art/shacl): SHACL application profiles for artworks
  * [`raremat_monograph/shacl`](../application_profiles/raremat_monograph/shacl): SHACL application profiles for rare materials monographs
  * [`sources`](../application_profiles/sources): Source ontology and vocabulary fragments used in the application profiles and modeling recommendations 
  
* [`doc`](.): Informational documents 
  * [`versioning.md`](versioning.md): The ARM versioning protocol for ontologies and vocabularies
  * [`repository_contents.md`](repository_contents.md): This document 
  
* [`tools`](../tools/): Tools used in support of the ontology and vocabulary development, such as XSL data conversion scripts or generating human-readable documentation
  * [`rbms_vocabs`](../tools/rbms_vocabs): Converts RBMS vocabulary XML dumps to RDF
  * [`build-lode-docs.py`](../tools/build-lode-docs.py): Generates ontology and vocabulary LODE documentation with various modifications 
  
* [`css`](../css): CSS files used in the display of the human-readable LODE documentation
* [`js`](../js): JavaScript files used in the display of the human-readable LODE documentation
  

