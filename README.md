Art and Rare Materials (ARM) BIBFRAME Ontology Extensions
==========================

*NOTE*: this work is continued/forked from work hosted on: https://github.com/LD4P/arm


The ontology housed in this repository is being developed as an extension of the [BIBFRAME ontology](http://id.loc.gov/ontologies/bibframe/) for generalized bibliographic description to provide specialized modeling in the archives, art and rare materials domains. This work was originally created under the LD4P 2016-2018 project; those ontologies are located on the [LD4P project's GitHub repository](https://github.com/LD4P/arm). 

Work in this repository replaces work posted in the grant-funded LD4P repository: [https://github.com/LD4P/arm](https://github.com/LD4P/arm)

Work on ARM is under the auspices of the Art Libraries Society of North America's Cataloging Advisory Committee, the Association of College and Research Library's Rare Books and Manuscript Section's Bibliographic Committee and the Society of American Archivists' Standards Committee.

Members
-------

Robin Desmeules, McGill University  
Christine DeZelar-Tiedman, University of Minnesota  
Marie-Chantal L'Écuyer-Coelho, Bibliothèque et Archives nationales du Québec (ARLIS lead)  
Meredith Hale, University of Tennessee Knoxville  
Regine Heberlein, Princeton University  
Linda Isaac, Harvard University  
Jason Kovari, Cornell University (ACRL-RBMS lead)  
Jonathan Lill, Museum of Modern Art  
Mark Matienzo, Stanford University  
Danijela Matkovic, Yale University  
Jennifer Page, National Museum of Women in the Arts  
Elizabeth Russey Roke, Emory University (SAA lead)  
Timothy Thompson, Yale University  
Ruth Kitchin Tillman, Pennsylvania State University  
Melanie Wacker, Columbia University  
Jessica Zieman, Library of Congress  



<a name="news">News, copied from previous repository:</a>
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


