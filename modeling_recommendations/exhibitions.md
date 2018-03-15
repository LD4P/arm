Exhibitions 
======================
LD4P ArtFrame/Rare Materials Ontology Extension, 2018-03-15

**Table of Contents**
> - [Overview](#overview)
> - [BIBFRAME Exhibition Model](#bibframe)
> - [Summary of Recommendations to LC for BIBFRAME Modification](#lc_recommendations)
> - [ArtFrame/RareMat Exhibition Model](#exhibition_model)
> - [Diagrams](#diagrams)
> - [Side-by-Side Examples](#examples)
> - [Future Work](#future_work)

<a name="overview">Overview</a>
---------
Recording the exhibition history of an item is an important use case identified by both the ArtFrame and RareMat groups.

In MARC 21 Bibliographic, information about exhibits is recorded as a text string in the [*Exhibition note, 585*](http://www.loc.gov/marc/bibliographic/bd585.html) 
for works that have been part of that exhibition. If a work has been issued to accompany an exhibit, such as a catalog or 
promotional products, information about the exhibition is recorded in a general 500 note. In current library cataloging practice, 
an exhibition, particularly an ongoing one, can be considered a creator of these resources and is coded as 111 (Meeting name). 

The current draft of VRA RDF includes a property placeOfExhibition (for example), allowing the cataloger to link the resource to 
venue or place of exhibition. However, it does not include a class for the exhibition event.

CIDOC-CRM does include a model to describe exhibition information in much detail. However, for consistency, this proposal reuses 
models from the BIBFRAME ontology as well as classes and properties from other ontologies that have been re-used previously in 
the ArtFrame/Rare Materials extension, and defines its own terms where these are lacking in the other two sources. 

The model covers properties of the exhibition event itself, as well as items included in the exhibition event and the event’s 
connection to an exhibition catalog. For clarity we use the term “exhibition event” to refer to the event, since “exhibition” will 
have another meaning, as discussed below.

<a name="bibframe">BIBFRAME Exhibition Model</a>
---------
There are no classes or properties covering exhibitions in BIBFRAME. Exhibition information can be expressed in a note. There is 
currently no controlled source for note types. 

BIBFRAME also defines an Event class, but no subclasses for specific types of Events. The only predicates defined to express 
relationships between bibliographic resources and Events are eventContent and its inverse, eventContentOf, which are relationships
between Events and Works that have the event as their subject. Additional relationships between bibliographic resources and 
events, which is a very rich modeling area and includes modeling of items in exhibitions, are not addressed in BIBFRAME.

------------------------------------
Classes
-----------------------
**ex:MeasurementGroup**
> - **Label**: Measurement Group
> - **IRI:** tbd
> - **Definition:** 
