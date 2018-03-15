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
- Our ultimate recommendation would be to remove bf:Event and implement or use an Event ontology (so far we have not identified   
  a suitable existing one), but this is a complex project and likely far in the future.
  
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
> - **Subclass of:** ex:Activity
> - **Editorial note:** Future work: consider more formal alignment between the class and corresponding MARC relator.
> - **Scope note:** This class is derived from the MARC relator: http://id.loc.gov/vocabulary/relators/cur.

**ex:DirectorActivity**
> - **Label:** Director
> - **IRI:** TBD
> - **Definition:** The activity of general management and supervision of a filmed performance, a radio or television program, 
                    etc.
> - **Subclass of:** ex:Activity
> - **Editorial note:** Future work: consider more formal alignment between the class and corresponding MARC relator.
> - **Scope note:** This class is derived from the MARC relator: http://id.loc.gov/vocabulary/relators/drt.

**ex:DonorActivity**
> - **Label:** Donor
> - **IRI:** TBD
> - **Definition:** An activity or contribution by a single agent that affects or alters the existence or state of a resource.
> - **Subclass of:** ex:Activity
> - **Editorial note:** Future work: consider more formal alignment between the class and corresponding MARC relator.
> - **Scope note:** This class is derived from the MARC relator: http://id.loc.gov/vocabulary/relators/dst.

**ex:OrganizerActivity**
> - **Label:** Organizer
> - **IRI:** TBD
> - **Definition:** The activity of organizing the exhibit, event, conference, etc.
> - **Subclass of:** ex:Activity
> - **Editorial note:** Future work: consider more formal alignment between the class and corresponding MARC relator.
> - **Scope note:** This class is derived from the MARC relator: http://id.loc.gov/vocabulary/relators/orm.

**ex:SponsorActivity**
> - **Label:** Sponsor
> - **IRI:** TBD
> - **Definition:** The activity of sponsoring some aspect of a resource, e.g., funding research, sponsoring an event.
> - **Subclass of:** ex:Activity
> - **Editorial note:** Future work: consider more formal alignment between the class and corresponding MARC relator.
> - **Scope note:** This class is derived from the MARC relator: http://id.loc.gov/vocabulary/relators/spn.

**ex:Arrangement**
> - **Label:** Arrangement
> - **IRI:** TBD
> - **Definition:** Information about the organization and arrangement of a collection of items or a single item.
> - **Scope note:** An Arrangement may be a NamedIndividual, a term from a controlled vocabulary, or an unnamed resource with an 
                    rdf:value.
> - **Example:** For computer files, organization and arrangement information may be the file structure and sort sequence of a 
                 file.
> - **Example:** For visual materials, this information may be how a collection is arranged.
> - **Example:** For an individual book on display in an exhibition, the arrangement may be the page to which the book is opened 
                 for display.
> - **Example:** For a scroll, the arrangement may be rolled or unrolled.
> - **Note:** See recommendation to LC above.

**ex:DescriptiveNote**
> - **Label:** Descriptive note
> - **IRI:** TBD
> - **Definition:** A note that describes the resource.
> - **Subclass of:** bf:Note

**ex:Entry**
> - **Label:** Entry
> - **IRI:** TBD
> - **Definition:** A specific entry within a bibliographic resource.
> - **Example (skos:example):** An entry locating a citation within a bibliographic source.
> - **Example (skos:example):** An exhibition catalog entry describing a specific item in the exhibition.

**ex:Exhibition**
> - **Label:** Exhibition
> - **IRI:** TBD
> - **Definition:** The relationship between an ExhibitionEvent and an Item in that event.
> - **Scope note:** Used to attach information to this relationship, such as title, dates, activities such as curatorship, 
                    exhibit number, physical arrangement, etc. which does not properly attach to the Item in and of itself.

*Properties*
-------------

**bf:genreForm (object property)**
> - **Label:** Genre/form
> - **IRI:** http://id.loc.gov/ontologies/bibframe/genreForm
> - **Definition:** Form category or genre to which a resource belongs.
> - **Comment** Used with Work, Instance or Item.
> - **Note:** See recommendation to LC above.

**bf:note (object property)**
> - **Label:** Note
> - **IRI:** http://id.loc.gov/ontologies/bibframe/note
> - **Definition:** General textual information relating to a resource, such as Information about a specific copy of a resource 
                    or information about a particular attribute of a resource.
> - **Comment** Used with Work, Instance or Item.
> - **Range:** bf:Note

**bf:title (object property)**
> - **Label:** Title resource
> - **IRI:** http://id.loc.gov/ontologies/bibframe/title
> - **Definition:** Name given to a resource.
> - **Comment** Used with Work, Instance or Item.
> - **Note:** See recommendation to LC above.

**ex:titleOf (object property)**
> - **Label:** title of
> - **IRI:** TBD
> - **Definition:** Name given to a resource.
> - **Comment** Used with Work, Instance or Item.
> - **Inverse:** bf:title
> - **Note:** See recommendation to LC above.

**dcterms:hasPart (property)**
> - **Label:** Has Part
> - **IRI:** http://purl.org/dc/terms/hasPart
> - **Comment** A related resource that is included either physically or logically in the described resource.
> - **Note:** This term is intended to be used with non-literal values as defined in the DCMI Abstract Model   
              (http://dublincore.org/documents/abstract-model/).  As of December 2007, the DCMI Usage Board is seeking a way to 
              express this intention with a formal range declaration.
> - **Subproperty of:** dcterms:relation

**dcterms:isPartOf (property)**
> - **Label:** Is Part Of
> - **IRI:** http://purl.org/dc/terms/isPartOf
> - **Comment** A related resource in which the described resource is physically or logically included.
> - **Note:** This term is intended to be used with non-literal values as defined in the DCMI Abstract Model   
              (http://dublincore.org/documents/abstract-model/).  As of December 2007, the DCMI Usage Board is seeking a way to 
              express this intention with a formal range declaration.
> - **Subproperty of:** dcterms:relation

**bf:subject (object property)**
> - **Label:** Subject
> - **IRI:** http://id.loc.gov/ontologies/bibframe/subject
> - **Definition:** Subject term(s) describing a resource.

**ex:subjectOf (object property)**
> - **Label:** subject of
> - **IRI:** TBD
> - **Definition:** The relationship between a resource and another resource of which it is the subject.
> - **Inverse:** bf:subject
> - **Note:** See recommendation to LC above.

**seq:follows (object property)**
> - **Label:** follows
> - **IRI:** http://www.ontologydesignpatterns.org/cp/owl/sequence.owl#follows
> - **Comment:** A relation between entities, expressing a 'sequence' schema. E.g. 'year 2000 follows 1999', 'preparing coffee' 
                 follows 'deciding what coffee to use', 'II World War follows I World War', etc. It can be used between tasks, 
                 processes or time intervals, and subproperties would fit best in order to distinguish the different uses.
> - **Domain:** Owl:Thing
> - **Range:** Owl:Thing
> - **Inverse:** seq:precedes

**seq:precedes (object property)**
> - **Label:** precedes
> - **IRI:** http://www.ontologydesignpatterns.org/cp/owl/sequence.owl#precedes
> - **Comment:** A relation between entities, expressing a 'sequence' schema. E.g. 'year 1999 precedes 2000', 'deciding what 
                 coffee to use' precedes 'preparing coffee', 'World War II follows World War I', 'in the Milan to Rome 
                 autoroute, Bologna precedes Florence', etc.
> - **Comment:** It can then be used between tasks, processes, time intervals, spatially locate objects, situations, etc. 
                 Subproperties can be defined in order to distinguish the different uses.
> - **Domain:** Owl:Thing
> - **Range:** Owl:Thing
> - **Inverse:** seq:follows

**ex:atLocation (object property)**
> - **Label:** at location
> - **IRI:** TBD
> - **Definition:** The resource being described is at the specified location.
> - **Domain:** Unspecified
> - **Range:* Unspecified
> - **Inverse:** ex:isLocationOf
> - **Note:** See recommendation to LC above.

**ex:isLocationOf (object property)**
> - **Label:** is location of
> - **IRI:** TBD
> - **Definition:** The specified resource is at the location being described.
> - **Domain:** Unspecified
> - **Range:* Unspecified
> - **Inverse:** ex:atLocation
> - **Note:** See recommendation to LC above.

**ex:covers (object property)**
> - **Label:** covers
> - **IRI:** TBD
> - **Definition:** Specifies a time period or location covered in the content of this resource.
> - **Domain:** Unspecified
> - **Range:* Unspecified
> - **Inverse:** ex:coveredIn
> - **Note:** See recommendation to LC above.

**ex:coveredIn (object property)**
> - **Label:** covered in
> - **IRI:** TBD
> - **Definition:** Specifies a resource the content of which covers this time period or location.
> - **Domain:** Unspecified
> - **Range:* Unspecified
> - **Inverse:** ex:covers
> - **Scope note:** Contrasts with ex:isSubjectOf: e.g., a book written by a French author may be set in France without France 
                    being the subject of the work. Not all cases are expected to be unambiguous.
> - **Note:** See recommendation to LC above.

**ex:hasActivity (object property)**
> - **Label:** has activity
> - **IRI:** TBD
> - **Definition:** Relates this resource to an activity or contribution by a single agent that affects or alters its existence 
                    or state.
> - **Range:* ex:Activity
> - **Inverse:** ex:isActivityOf

**ex:isActivityOf (object property)**
> - **Label:** is activity of
> - **IRI:** TBD
> - **Definition:** Relates an activity to the affected resource.
> - **Domain:* ex:Activity
> - **Inverse:** ex:hasActivity

**ex:hasArrangement (object property)**
> - **Label:** has arrangement
> - **IRI:** TBD
> - **Definition:** Relates an object or collection of objects to information about its organization or arrangement.
> - **Domain:** Unspecified
> - **Range:* ex:Arrangement
> - **Inverse:** ex:isArrangementOf
> - **Example:** For computer files, organization and arrangement information may be the file structure and sort sequence of a 
                 file.
> - **Example:** For visual materials, this information may be how a collection is arranged.
> - **Example:** For an individual book in an exhibition, the arrangement may be the page to which the book is opened for 
                 display.
> - **Example:** For a scroll, the arrangement may be rolled or unrolled.
> - **Note:** See recommendation to LC above.

**ex:isArrangementOf (object property)**
> - **Label:** is arrangement of
> - **IRI:** TBD
> - **Definition:** Relates information about the organization or arrangement of an object or collection of objects to that 
                    object or collection.
> - **Domain:** ex:Arrangement
> - **Range:* Unspecified
> - **Inverse:** ex:hasArrangement
> - **Example:** For computer files, organization and arrangement information may be the file structure and sort sequence of a 
                 file.
> - **Example:** For visual materials, this information may be how a collection is arranged.
> - **Example:** For an individual book in an exhibition, the arrangement may be the page to which the book is opened for 
                 display.
> - **Example:** For a scroll, the arrangement may be rolled or unrolled.
> - **Note:** See recommendation to LC above.

**ex:hasExhibition (object property)**
> - **Label:** has exhibition
> - **IRI:** TBD
> - **Definition:** Relates an Item to the Exhibition resource representing the relationship between the Item and an 
                    ExhibitionEvent.
> - **Domain:** Unspecified
> - **Range:* ex:Exhibition
> - **Inverse:** ex:isExhibitionOf

**ex:isExhibitionOf (object property)**
> - **Label:** is exhibition of
> - **IRI:** TBD
> - **Definition:** Relates an Exhibition resource representing the relationship between an Item and an ExhibitionEvent to the 
                    Item.
> - **Domain:** ex:Exhibition
> - **Range:* Unspecified
> - **Inverse:** ex:hasExhibition

**ex:startDate (datatype property)**
> - **Label:** start date
> - **IRI:** TBD
> - **Definition:** The start date and time of the resource, such as an event.
> - **Note:** See recommendation to LC above.

**ex:endDate (datatype property)**
> - **Label:** end date
> - **IRI:** TBD
> - **Definition:** The end date and time of the resource, such as an event.
> - **Note:** See recommendation to LC above.

<a name="diagrams">Diagrams</a>
---------
**Diagram 1. Exhibition Event**
![Exhibition Event Diagram 1](/modeling_recommendations/modeling_diagrams/exhibition_event.png)
**Notes**
- Description, coverage, and subject are different options for describing the topic of the Exhibition Event.

**Diagram 2. Items in an Exhibition Event**
![Items_in_an_Exhibition_Event_2](/modeling_recommendations/modeling_diagrams/items_exhibitions_events.png)
**Notes**
- While it is the Item which is directly related to the ExhibitionEvent (via the Exhibition node), by following the links to 
  Instance and Work, these are by extrapolation also “in” the ExhibitionEvent.
 
 **Diagram 3. Item Description the the Context of an Exhibition**
![Item_Description_in_the_Context_of_an_Exhibition_3](/modeling_recommendations/modeling_diagrams/Item_description_exhibition.png)
**Notes**
- The Exhibition context node provides for description of the Item in relation to the ExhibitionEvent that do not pertain to the 
  Item in and of itself:
  - Item title in the context of the ExhibitionEvent may differ from the Item title.
  - Item may have its own dates and activities in relation to the ExhibitionEvent.
  - Arrangement shows the particular arrangement of the Item in the ExhibitionEvent.
  - Identifier is the identifier of the Item within the ExhibitionEvent. No specific subclass is needed; the linkage to the 
    Exhibition is sufficient.
  - Dates of exhibition of the Item may be different from the dates of the ExhibitionEvent itself.
  - The Item may have particular activities attached to it in relation to the ExhibitionEvent, that are not activities of the 
    ExhibitionEvent itself.
  - Perhaps other features not illustrated here.

**Diagram 4. Exhibition catalog**
![Exhibition_Catalog 4](/modeling_recommendations/modeling_diagrams/exhibition_catalog.png)
**Notes**
- A catalog entry may describe the item, instance, work, or item in the context of the exhibition; thus the multiple 
  dcterms:subject relationships.
- Other publications associated with an ExhibitionEvent may include flyers, audio guides, etc. These will generally follow the 
  model provided here for catalogs, with different genreForms.

**Digram 5. Multi-Site Exhibition**
![Multi_Site_Exhibitions_5](/modeling_recommendations/modeling_diagrams/multi_site_exhibitions.png)
**Notes**
- Each exhibition site has its own location, and may have the same, overlapping, or different start and end dates from other 
  sites.
- Each site, as well as the exhibition as a whole, may have particular relationships and features such as:
  - Activities
  - Titles (not illustrated)
  - Catalog (not illustrated)
  - Perhaps others not illustrated here
- [*“Bestandsaufnahme Gurlitt”*](https://www.tagesspiegel.de/kultur/doppel-ausstellung-in-bern-und-bonn-bestandsaufnahme-
  gurlitt-jetzt-kommen-die-bilder-zu-wort/20534814.html) is a good example of a multi-site exhibition where each sub-location 
  has a distinct title, location, and start and end dates, and items on display, and the exhibition as a whole has a title as 
  well. Only the entire exhibition has a catalog (though this is not a requirement).
  
**Diagram 6. Traveling Exhibition**
![Traveling_Exhibitions_6](/modeling_recommendations/modeling_diagrams/traveling_exhibition.png)
**Notes**
- There are three differences between the Multi-Site and Traveling ExhibitionEvent:
  - Definitionally, a traveling exhibition moves items from one site to another, whereas the multi-site exhibition has different 
    items at different sites.
  - We do not distinguish these types by subclassing; rather, the properties listed below distinguish the two. An advantage of 
    this is in some cases the boundaries between the two may be fuzzy, with some properties of one type and some properties of 
    another.
  - The start and end dates of the sites in a multi-site exhibition may be the same or overlapping. The start and end dates of 
    sites in a traveling exhibition are non-overlapping.
  - A traveling exhibition may use precedes and follows predicates between exhibition parts, but this is optional and generally 
    redundant, because we expect to have start and end dates. 
  - An Item may be displayed in more than one sub-exhibition of a traveling exhibition, but generally not of a multi-site 
    exhibition.

<a name="examples">Side-by-Side Examples</a>
---------
**BIBFRAME**
```
:item1 a bf:Item ;
    bf:note :note1 .

:note1 a bf:Note ;
    rdf:value “Exhibited: ‘Groundbreakers: Great American Gardens and the Women Who 
    Designed Them’ at the LuEsther T. Mertz Library, New York Botanical Gardens,
    New York, N.Y., May - October 2014.” ; 
    bf:noteType “exhibition” .
```

**ArtFrame / RareMat (non-exhaustive)**
```
:item1 a bf:Item ;
    ex:hasExhibition :exhibition1 ;
    bf:title :title1 ;
    bf:itemOf :instance1.

:title1 a bf:Title ;
    rdf:value “The Mill on the Floss” .

:instance1 a bf:Instance ;
    bf:instanceOf :work1 .

:work1 a bf:Work .

:exhibition1 a ex:Exhibition ;
    dcterms:isPartOf :exhibitionEvent1 ;
    ex:startDate “2018-02-01”^^edtf:EDTF ;
    ex:endDate “2018-04-30”^^edtf:EDTF ;
    bf:title :title2 ;    
    ex:hasArrangement ex:arrangement1 ; 
    bf:identifiedBy :identifier1 .

:title2 a bf:Title ;
    rdf:value “Black-and-white Illustrations in The Mill on the Floss by George Eliot, first edition” .

:identifier1 a bf:Identifier ;
    rdf:value “MFGEed1” .

:arrangement1 a ex:Arrangement ;
    rdf:value “Open to plate 10” .

:exhibitionEvent1 a schema:ExhibitionEvent ;
    ex:startDate “2018-01-01”^^edtf:EDTF ;
    ex:endDate “2018-06-30”^^edtf:EDTF ;
    dcterms:subject <http://id.loc.gov/authorities/subjects/sh88007062> ;
    bf:title “Victorian Era Illustrations” .

:catalog1 a bf:Work ;
    bf:genreForm <http://id.loc.gov/authorities/genreForms/gf2014026098> ;
    dcterms:subject :exhibitionEvent1 ;
    dcterms:hasPart :entry1 .

:entry1 a ex:Entry ;
    dcterms:subject :item1 , :instance1 , :work1 , :exhibition1 .

```
<a name="future_work">Future Work</a>

- Other potential use cases are performance-based events and virtual (online) exhibitions. The group has not yet explored how 
  the proposed model can be applied to these types of events.
- Modeling of the full set of relationships that may obtain between bibliographic resources and events is well beyond the scope 
  of the RareMat/ArtFrame ontology, but is needed for general bibliographic modeling. This could be based on an existing event 
  ontology, if a suitable one exists, but may need extension for the specific relationships that hold in the bibliographic 
  context.
