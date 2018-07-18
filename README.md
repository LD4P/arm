Art and Rare Materials (ARM) BIBFRAME Ontology Extensions
==========================

Table of Contents
---------

* [Introduction](#intro)
* [News](#news)
* [ARM Ontologies](#ontologies)
* [ARM Vocabularies](#vocabularies)

<a name="intro">Introduction</a>
------------

The ontologies housed in this repository have been developed as extensions of the [BIBFRAME ontology](http://id.loc.gov/ontologies/bibframe/) for generalized bibliographic description to provide specialized modeling in the art and rare materials domains. These were originally conceived of as two separate projects: Columbia University led [ArtFrame](https://wiki.duraspace.org/display/LD4P/ArtFrame), an ontology extension for the description of two-and three-dimensional artworks, in collaboration with the Art Libraries Society of North America's [Cataloging Advisory Committee](https://www.arlisna.org/organization/committees/76-cataloging-advisory-committee) (ARLIS CAC), the Library of Congress Prints and Photographs Division, The Clark Library, and the Morgan Library & Museum. Meanwhile, Cornell University led the [Rare Materials Ontology Extension](https://wiki.duraspace.org/display/LD4P/Rare+Materials+Ontology+Extension) (RareMat) in collaboration with the ACRL Rare Books and Manuscript Section's [Bibliographic Standards Committee](http://rbms.info/committees/bibliographic_standards/) (RBMS-BSC); RareMat was intended to provide modeling for the complexity of rare materials, particularly item-level description not addressed in BIBFRAME. 

As work proceeded, it became apparent that many of the modeling needs of the two groups overlapped: physical description, physical condition and conservation, custodial history, measurements, awards and exhibitions, and so on. It was thus decided to merge the projects and jointly develop a single set of models. 

Meanwhile, select models were considered separable from the core models, amenable to independent implementation by users within and outside the bibliographic domain. These models have been pulled out of the core ontology into three modularized ontologies: awards, custodial history, and measurements.

In addition to the ontologies, the group has generated several other outputs:
- [A set of controlled vocabularies](core/vocabularies/) for arrangement of physical objects (e.g., rolled and unrolled), origin (e.g., of titles), status (e.g., of identifiers), typefaces, and handwriting types. 
- [Detailed documentation of each model](modeling_recommendations). These include use cases; model overviews, with motivation and rationale in reference to the use cases and legacy data; diagrams; RDF samples; term specifications; recommendations for future modifications to BIBFRAME, where applicable; and lists of related topics out-of-scope of the current project but of interest for future research.
- [Application profiles](application_profiles), formalized in SHACL and accompanied by external ontologies and vocabularies, to support form and display interfaces in [VitroLib](https://github.com/ld4l-labs/vitrolib), an RDF cataloging tool under development in the associated [Linked Data for Libraries Labs](https://wiki.duraspace.org/pages/viewpage.action?pageId=77447730) project. Two application profiles are under development: art and rare monographs. Also included are fragments of source ontologies and vocabularies used in the application profiles and modeling recommendations. 
- Experimental: SHACL validation profiles stored with the associated ontologies, which can be used as a basis for application profiles but whose primary purpose is to define expected implementation of the ontologies independent of any application. Some proof-of-concept application profiles are built on the validation SHACL in this way; when the profiles are complete we will evaluate the feasibility and usefulness of refactoring all the application profiles according to this model. Currently available are [core validation](core/validation/shacl/) and [custodial_history](custodial_history/validation/shacl/) SHACL shapes.

The Art and Rare Materials BIBFRAME Ontology Extensions are a product of the Andrew W. Mellon Foundation funded Linked Data for Production (LD4P) project, 2016-2018. See the [LD4P public wiki](https://wiki.duraspace.org/pages/viewpage.action?pageId=74515029) for more information about this project. 

Adoption, maintenance, and use of these ontologies will be determined by RBMS-BSC and ARLIS CAC following initial development and assessment.

<a name="news">News</a>
-------------

* **2018-04-27** Release of Version 0.1.0 of all ontologies and vocabularies.


<a name="ontologies">ARM Ontologies</a>
-------

### Core Ontology

Core ontology used in the description of art and rare materials.

* [Ontology specification](https://w3id.org/arm/core/ontology/0.1/core.rdf)
* [Human-readable documentation](https://w3id.org/arm/core/ontology/0.1/core.html)

### <a name="activity">Activity Ontology</activity>

The issue of whether to adopt the BIBFRAME Contribution model or the [bibliotek-o](http://bibliotek-o.org) Activity model has not yet been resolved. As a temporary accommodation, the Activity model is used, but the terms are stored in a separate ontology file
with a distinct namespace for easy separation. The expectation is that either (1) the Activity model will be adopted, and the terms merged into the ARM Core Ontology, or (2) the BIBFRAME Contribution model will be adopted, the Activity ontology deprecated, and
other associated revisions to the ARM ontologies and vocabularies be implemented. 

* [Ontology specification](https://w3id.org/arm/activity/ontology/0.1/activity.rdf)
* [Human-readable documentation](https://w3id.org/arm/activity/ontology/0.1/activity.html)

### Award Ontology

Specialized ontology for the description of awards received by bibliographic resources or agents; reusable in contexts beyond the bibliographic domain.

* [Ontology specification](https://w3id.org/arm/award/ontology/0.1/award.rdf)
* [Human-readable documentation](https://w3id.org/arm/award/ontology/0.1/award.html)

### Custodial History Ontology

Specialized ontology for the description of an object's custodial history or provenance; reusable in contexts beyond the bibliographic domain.

* [Ontology specification](https://w3id.org/arm/custodial_history/ontology/0.1/custodial_history.rdf)
* [Human-readable documentation](https://w3id.org/arm/custodial_history/ontology/0.1/custodial_history.html)

### Measurement Ontology

Specialized ontology for the description of an object's measurements; reusable in contexts beyond the bibliographic domain.

* [Ontology specification](https://w3id.org/arm/measurement/ontology/0.1/measurement.rdf)
* [Human-readable documentation](https://w3id.org/arm/measurement/ontology/0.1/measurement.html)


<a name="vocabularies">ARM Vocabularies</a>
-----------

All existing vocabularies are part of ARM core. They were designed to address specific descriptive concerns, but some could be used or extended to apply in other contexts.

A task left for future development is the identification of an existing or creation of an original award vocabulary for use in conjunction with the Award Ontology.

### Arrangement

Arrangements of objects (e.g., folded, unfolded, rolled, unrolled). Designed in the context of exhibition displays and measurements.

* [Vocabulary specification](https://w3id.org/arm/core/vocabularies/arrangement/0.1/arrangement.rdf)
* [Human-readable documentation](https://w3id.org/arm/core/vocabularies/arrangement/0.1/arrangement.html)


### Handwriting Type

* [Vocabulary specification](https://w3id.org/arm/core/vocabularies/handwriting_type/0.1/handwriting_type.rdf)
* [Human-readable documentation](https://w3id.org/arm/core/vocabularies/handwriting_type/0.1/handwriting_type.html)


### Origin

Designed to describe title origins (e.g., cover, container).

* [Vocabulary specification](https://w3id.org/arm/core/vocabularies/origin/0.1/origin.rdf)
* [Human-readable documentation](https://w3id.org/arm/core/vocabularies/origin/0.1/origin.html)


### Status

Designed to describe identifier status (e.g., current, deprecated).

* [Vocabulary specification](https://w3id.org/arm/core/vocabularies/status/0.1/status.rdf)
* [Human-readable documentation](https://w3id.org/arm/core/vocabularies/status/0.1/status.html)


### Typeface

* [Vocabulary specification](https://w3id.org/arm/core/vocabularies/typeface/0.1/typeface.rdf)
* [Human-readable documentation](https://w3id.org/arm/core/vocabularies/typeface/0.1/typeface.html)


