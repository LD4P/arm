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
**bf:Note**
> - **Label**: Note
> - **IRI:** http://id.loc.gov/ontologies/bibframe/Note
> - **Definition:** Information, usually in textual form, on attributes of a resource or some aspect of a resource.

**bf:Event**
> - **Label**: Event
> - **IRI:** http://id.loc.gov/ontologies/bibframe/Event
> - **Definition:** Something that happens at a certain time and location, such as a performance, speech, or athletic event, that is  
                    documented by a resource.

------------------------------------
Properties
-----------------------

**bf:note**
> - **Label**: Note
> - **IRI:** http://id.loc.gov/ontologies/bibframe/note
> - **Comment:** Used with Unspecified
> - **Range:** bf:Note
> - **Definition:** General textual information relating to a resource, such as Information about a specific copy of a resource or 
                    information about a particular attribute of a resource.

**bf:noteType**
> - **Label**: Note type
> - **IRI:** http://id.loc.gov/ontologies/bibframe/noteType
> - **Domain:** bf:Note
> - **Range:** Literal
> - **Definition:** Type of note

<a name="lc_recommendations">Summary of Recommendations to LC for BIBFRAME Modification</a>
---------
**bf:arrangement and bf:Arrangement**

- Current definitions reference only the organization and arrangement of a collection of objects. We recommend the extension of the terms to include individual objects.
  - If this recommendation is not accepted, we will define our own terms hasArrangement and Arrangement.
- Define inverse bf:arrangementOf.
  - If this recommendation is not accepted, we will define our own inverse.
  
**bf:geographicCoverage, bf:GeographicCoverage, bf:temporalCoverage, bf:Temporal**

- The class and predicate pairs are redundant; specifically, a work covers an object, and the type of object does not need to be  
  repeated in the predicate. We recommend a single predicate, bf:covers, and inverse.
- Remove the domain Work, since other types of resources, such as ExhibitionEvents, can have coverage.
- If these recommendations are not accepted, we will define ex:covers and ex:coveredIn.

**bf:date**

- Define subproperties startDate and endDate.
  - If this recommendation is not accepted, we will define our own terms. While there are several candidate external terms, it does not 
    make sense to use these if we are using bf:date. 

**bf:Event**

- The definition of bf:Event is “Something that happens at a certain time and location, such as a performance, speech, or athletic  
  event, that is documented by a resource.” We request removal of the phrase “that is documented by a resource,” allowing events to be 
  modeled in contexts other than as the event content of a work. 
  - If this recommendation is accepted, we will use bf:Event and define a subclass ex:ExhibitionEvent. Otherwise, we will use  
    schema:Event and its subclass schema:ExhibitionEvent. 
- Our ultimate recommendation would be to remove bf:Event and implement or use an Event ontology (so far we have been unable to   
  identify an existing one), but this is likely far in the future.
  
**bf:genreForm and bf:GenreForm**

- Remove range bf:GenreForm to provide for objects that are not typed bf:GenreForm without undesirable entailments. The alternate 
  formulation ‘x bf:genreForm :genreForm1 . :genreForm1 a bf:GenreForm, rdf:value <some-genre-form-uri> .’ rather than ‘x bf:genreForm 
  <some-genre-form-uri>’ simply complicates the graph by inserting an extra node. In case there is no applicable vocabulary term, the 
  object could be a GenreForm resource with an rdf:value literal, but we do not want to require that every object be of type GenreForm.
- Expand definition of bf:GenreForm (we understand it may be a mistake in the OWL file).
- If these recommendations are not accepted, we will nevertheless use bf:genreForm, and bf:GenreForm when needed, judging that the 
  entailment issue is not severe enough to warrant rejection of the term.
  
**bf:part**

- Define as an object property rather than a datatype property.
- Define an inverse bf:partOf.
- If this recommendation is not accepted, we will use dcterms:hasPart / dcterms:isPartOf.

**bf:place and bf:Place**

- Extend definition beyond geographic locations to physical and electronic locations, as well as locators such as entries in a source 
  and cell coordinates in a table. (Not all of these pertain to exhibitions, but electronic locations are relevant to online 
  exhibitions, and it is good practice to define terms broadly for general use.) Subclasses can be defined either in BIBFRAME or 
   extensions for specific types of locations.
- Remove range of bf:place to provide for objects that are not typed bf:Place without undesirable entailments. 
- If these recommendations are implemented, we will use bf:place, bf:placeOf. Otherwise, we will define ex:atLocation and inverse 
  ex:isLocationOf, similar to the bibliotek-o predicates but with no defined range. We will in any case use bf:Place where relevant, but 
  our predicates will not define a domain or range.
  
**bf:precededBy and bf:succeededBy**

- Remove used with and expected value comments (Work or Instance) to refer to events and other resources.
- Remove bf:relatedTo as superproperty, since this also refers to Work, Instance, or Item, or remove the used with and expected value 
  comments.
- If these recommendations are not accepted, we will continue to use seq:precedes and seq:follows.
  Minor recommendation: change from passive to active forms bf:precedes and bf:follows on the grounds that the active forms are easier 
  to comprehend: the subject-object order follow the precedence order rather than the reverse.
  - If this recommendation is not accepted, it will not block use of the BIBFRAME terms. 

**bf:subject**

- Define inverse bf:subjectOf.
- If this recommendation is not accepted, we will define our own inverse.
- Remove used with Work, Instance, or Item recommendation, so that it can apply to ExhibitionEvents, Entries, and other types of 
  resources.
- If this recommendation is not accepted, we will ignore the used with comment since it is not a formal domain. 

**bf:title**

- Remove “Used with Work, Instance, or Item” to allow use with events and other resources. In this recommendation, both ExhibitionEvent 
  and Exhibition resources may have titles. 
  - If this recommendation is not accepted, we will nevertheless use the predicate and ignore the expectation, since it is not stated as 
    a formal domain.
- Define inverse bf:titleOf. 
  - This recommendation has been made and approved in another context, but has not yet been added to the current OWL specification, so 
    we will define our own term until it exists in BIBFRAME.

<a name="exhibition_model">ArtFrame/RareMat Exhibition Model</a>
---------
**Notes**
-----------------
- The remainder of this document proceeds on the assumption that no changes will be made to BIBFRAME. Appropriate modifications will be 
  required for any of the recommendations that are incorporated into LC’s implementation plan, with consideration for when and in which 
  version these changes will be made.
- All bibliotek-o terms have been culled from the recommendation. In their place, we adopt one of three alternatives, on a case-by-case 
  basis: (1) use a BIBFRAME term, (2) use an external term, or (3) define a term in the (as yet to be determined) Raremat/ArtFrame 
  namespace. 
------------------------
**Term Specifications**
--------------------------

*Classes*
-------------
**schema:Event**
> - **Label:** Event
> - **IRI:** http://schema.org/Event
> - **Definition:** An event happening at a certain time and location, such as a concert, lecture, or festival. Ticketing 
                    information may be added via the offers property. Repeated events may be structured as separate Event 
                    objects.
> - **Note:** See recommendation to LC above.

**schema:ExhibitionEvent**
> - **Label:** ExhibitionEvent
> - **IRI:** http://schema.org/ExhibitionEvent
> - **Definition:** Event type: Exhibition event, e.g. at a museum, library, archive, tradeshow.
> - **Note:** See recommendation to LC above.

**ex:Activity**
> - **Label:** Activity
> - **IRI:** TBD
> - **Definition:** An activity or contribution by a single agent that affects or alters the existence or state of a resource.

**ex:CuratorActivity**
> - **Label:** Curator
> - **IRI:** TBD
> - **Definition:** The activity of conceiving, aggregating, and/or organizing an exhibition, collection, or other item.
> - **Subclass of: ex:Activity
> - **Editorial note:** Future work: consider more formal alignment between the class and corresponding MARC relator.
> - **Scope note:** This class is derived from the MARC relator: http://id.loc.gov/vocabulary/relators/cur.

**ex:DirectorActivity**
> - **Label:** Director
> - **IRI:** TBD
> - **Definition:** The activity of general management and supervision of a filmed performance, a radio or television program, 
                    etc.
> - **Subclass of: ex:Activity
> - **Editorial note:** Future work: consider more formal alignment between the class and corresponding MARC relator.
> - **Scope note:** This class is derived from the MARC relator: http://id.loc.gov/vocabulary/relators/drt.
