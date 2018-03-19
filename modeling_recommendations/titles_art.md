Titles in Art Cataloging
=====================================================
ArtFrame, 2017-10-06, updated 2018-02-05

____________________________________________________________________________________________________________________________
NOTE: the following represents the direction taken by the ArtFrame group in the ontology development process and may not represent the final model. This pattern document was used internally to define a direction and is shared with the intention of contextualizing a pattern found within the ontology; terms specified below may not fully align to the ontology as published.
bibliotek-o properties and classes will be replaced with BIBFRAME terms or defined within the ArtFrame/RareMat ontology.
_____________________________________________________________________________________________________________________________

Table of Contents
> - [Sources](#sources)
> - [Background](#background)
> - [Recommendations for Moving Forward](#recommendations)
> - [Relevant ArtFrame Use Case](#useCase)
> - [Titles in MARC](#MARC)
> - [Titles in BIBFRAME](#BIBFRAME)
> - [Titles in bibliotek-o](#bibliotek-o)
> - [Recommended Classes](#classes)
> - [Recommended Properties](#properties)
> - [Recommended Names Individuals](#individuals)
> - [Diagrams](#diagrams)
> - [RDF Samples](#rdf)


<a name="sources">Sources</a>
--------

> - **bibliotek-o Titles Pattern** [*https://wiki.duraspace.org/display/LD4P/bibliotek-o?preview=/79795231/83237331/bibliotek-o_pattern_titles_201612.pdf*](https://wiki.duraspace.org/display/LD4P/bibliotek-o?preview=/79795231/83237331/bibliotek-o_pattern_titles_201612.pdf)
> - **Performed Music Ontology--Titles in BIBFRAME** [*https://wiki.duraspace.org/display/LD4P/Performed+Music+Ontology?preview=/79795208/83236905/Titles%20in%20BIBFRAME.docx*](https://wiki.duraspace.org/display/LD4P/Performed+Music+Ontology?preview=/79795208/83236905/Titles%20in%20BIBFRAME.docx)
> - **BIBFRAME 2.0 Titles Specifications** [*https://www.loc.gov/bibframe/docs/pdf/bf2-draftspectitles-10-29-2015.pdf*](https://www.loc.gov/bibframe/docs/pdf/bf2-draftspectitles-10-29-2015.pdf)

<a name="background">Background</a>
--------

bibliotek-o, the BIBFRAME extension created by LD4L-Labs and the LD4P Ontology Group, takes a slightly different approach to recording titles than BIBFRAME itself. For example, bibliotek-o distinguishes between title sources and title origins, allows for indicating transcribed versus supplied titles, the ordering of subtitles, and the creation of sort titles by providing the possibility to separate initial articles from the title proper. This document discusses if the bibliotek-o title model covers the use cases identified by the ArtFrame team and the ArtFrame Extension Group related to naming art objects and identifies areas not covered that need to be addressed in the ArtFrame extension.

<a name="recommendations">Recommendation for Moving Forward with ArtFrame</a>
--------

After testing the bibliotek-o title model, the ArtFrame group agreed that it can generally be applied to art objects. The group also investigated specific art cataloging standards (such as CCO, CDWA and DCRM(G)) for other requirements unique to art objects. In particular, the group discussed title types listed in CCO Chapter 1, p. 49-50 ([*http://cco.vrafoundation.org/downloads/PartTwo_1-ObjectNaming.pdf*](http://cco.vrafoundation.org/downloads/PartTwo_1-ObjectNaming.pdf)) as well as CDWA ([*http://www.getty.edu/research/publications/electronic_publications/cdwa/4titles.html*](http://www.getty.edu/research/publications/electronic_publications/cdwa/4titles.html)). Most of these title types (e.g. creator’s title or repository title) are very relevant concepts, but can be expressed in other ways in a linked data environment. Two remaining title types were identified that need to be formally expressed in the ArtFrame ontology: exhibition title and translated title.

> - **Recommendations:**
Exhibition title will be addressed in the Exhibition Event Model. Translated title will be accomodated in the ArtFrame ontology as a named individual to be used with ex:origin. While ex:translated differs from most of the other named individuals in this category, including it follows precedent set by ex:supplied and ex:transcribed.

> - **Title Origin**

Title origins (the place from which a title originates, i.e. container, margin, spine) are less clearly defined for objects different from regular print books. Established owl:NamedIndividuals in bibliotek-o, such as ex:supplied and ex:transcribed should be applied where appropriate, along with the newly proposed ex:translated. No additional art specific named individuals will be defined within the ArtFrame namespace. DCRM(G) 1B2 states: Always make a note on the source of the title proper. The examples given are: Title from lower margin; Title from ink note on book of mount; title from item, etc. This list could potentially be endless. For the sake of consistency, this type of information will be recorded as a title origin using rdf:value.

<a name="useCase">Relevant ArtFrame Use Case</a>
--------
![Title Use Case](/modeling_recommendations/modeling_diagrams/art_titles_1.PNG)

Examples: Les Demoiselles d'Avignon (The Young Ladies of Avignon, and originally titled The Brothel of Avignon) (Wikipedia); Swimming, by Thomas Eakins (formerly The Swimming Hole) (title change based on research)

<a name="MARC">Titles in MARC</a>
--------
In a MARC bibliographic record, many types of titles are recorded in the 20x-24x area [*http://www.loc.gov/marc/bibliographic/bd20x24x.html*](http://www.loc.gov/marc/bibliographic/bd20x24x.html). The instance title is tagged as a 245. A work title is recorded in a 240 or 130. If neither one of these are present, then the 245 can be interpreted as the title of the work as well as the instance title. The 245 allows for sub-fielding of non-sorting characters and subtitles. Variant titles are recorded in a 246, where indicators can be used to show the type or source of the variant tiles. Related titles can occur in the 6xx $t, 7xx $t, 730 or 740.

<a name="BIBFRAME">Titles in BIBFRAME</a>
--------
The classes and properties that are available to express in BIBFRAME are summarized here:
![BIBFRAME Title Model](/modeling_recommendations/modeling_diagrams/art_titles_2.PNG)

[*http://id.loc.gov/ontologies/bibframe-category.html*](http://id.loc.gov/ontologies/bibframe-category.html) accessed on July 31, 2017.
Other properties that can be used in conjunction with title information are bf:source, bf:date, bf:qualifier, and bf:note.
Subclasses of bf:VariantTitle: KeyTitle, AbbreviatedTitle, ParallelTitle, CollectiveTitle

<a name="bibliotek-o">Titles in bibliotek-o</a>
--------
![bibliotek-o title properties](/modeling_recommendations/modeling_diagrams/art_titles_3_bibliotek-o.PNG
)

![bibliotek-o title classes](/modeling_recommendations/modeling_diagrams/art_titles_4_bibliotek-o.PNG)

Named individuals to be used with ex:Origin: binder, caption, container, cover, margin, spine, supplied, transcribed 

<a name="classes">Recommended Classes</a>
--------

**bf:Title**
> - **Label**: Title entity
> - **IRI:** http://id.loc.gov/ontologies/bibframe/Title
> - **Definition:** Title information relating to a resource: work title, preferred title, instance title, transcribed title, translated title, variant form of title, etc.

**bf:Note**
> - **Label**: Note
> - **IRI:** http://id.loc.gov/ontologies/bibframe/Note
> - **Definition:** Information, usually in textual form, on attributes of a resource or some aspect of a resource.

**bf:Source**
> - **Label**: Source
> - **IRI:** http://id.loc.gov/ontologies/bibframe/Source
> - **Definition:** Information, usually in textual form, on attributes of a resource or some aspect of a resource.

**bf:Status**
> - **Label**: Status
> - **IRI:** http://id.loc.gov/ontologies/bibframe/Status
> - **Definition:** Designation of the validity or position of something, e.g., whether something is incorrect or available.

**ex:MainTitleElement**
> - **Label**: Main title element
> - **IRI:** http://example.org/MainTitleElement
> - **Definition:** The main part of a title.
> - **Subclass of:** http://example.org/TitleElement

**ex:NonSortElement**
> - **Label**: Main title element
> - **IRI:** http://example.org/NonSortElement
> - **Definition:** The initial segment of a title that is removed for sorting.
> - **Subclass of:** http://example.org/TitleElement

**ex:Origin**
> - **Label**: Origin
> - **IRI:** http://example.org/Origin
> - **Definition:** The place from which a resource (e.g., a title) originates, such as spine, cover, container, etc.

**ex:PartNameElement**
> - **Label**: Part name element
> - **IRI:** http://example.org/PartNameElement
> - **Definition:** The part of a title that specifies the name of a part of the resource.
> - **Subclass of:** http://example.org/TitleElement

**ex:PartNumberElement**
> - **Label**: Part number element
> - **IRI:** http://example.org/PartNumberElement
> - **Definition:** The part of a title that specifies the number of a part of the resource.
> - **Subclass of:** http://example.org/TitleElement

**ex:SubTitleElement**
> - **Label**: Subtitle element
> - **IRI:** http://example.org/SubtitleElement
> - **Definition:** The subtitle of a title.
> - **Subclass of:** http://example.org/TitleElement

**ex:TitleElement**
> - **Label**: Title element
> - **IRI:** http://example.org/TitleElement
> - **Definition:** A part of a title, such as a subtitle, part number, or part name.

<a name="properties">Recommended Properties</a>
--------

**bf:title** (Object property)
> - **Label:** Title resource
> - **IRI:** http://id.loc.gov/ontologies/bibframe/title
> - **Definition:** Name given to a resource.
> - **Comment:** Used with Work, Instance or Item.
> - **Range:** http://id.loc.gov/ontologies/bibframe/Title

**ex:titleOf** (Object property)
> - **Label:** is title of
> - **IRI:** http://example.org/titleOf
> - **Definition:** Resource that this title belongs to.
> - **Scope note:** Expected value Work, Instance or Item.
> - **Domain:** http://id.loc.gov/ontologies/bibframe/Title
> - **Inverse:** http://id.loc.gov/ontologies/bibframe/title

**bf:note** (Object property)
> - **Label:** Note
> - **IRI:** http://id.loc.gov/ontologies/bibframe/note
> - **Definition:** General textual information relating to a resource, such as Information about a specific copy of a resource or information about a particular attribute of a resource.
> - **Comment:** Used with Unspecified.
> - **Range:** http://id.loc.gov/ontologies/bibframe/Note

**bf:status** (Object property)
> - **Label:** Status
> - **IRI:** http://id.loc.gov/ontologies/bibframe/status
> - **Definition:** Designation of the validity or position of something, such as indication that the classification number is canceled or invalid, circulation availability of an item, indication of whether the identifier is canceled or invalid.
> - **Comment:** Used with Unspecified.
> - **Range:** http://id.loc.gov/ontologies/bibframe/Status

**ex:hasActivity** (Object property)
> - **Label:** has activity
> - **IRI:** http://example.org/hasActivity
> - **Definition:** Relates this resource to an activity or contribution by a single agent that affects or alters its existence or state.
> - **Range:** http://example.org/Activity
> - **Inverse of:** http://example.org/isActivityOf

**ex:isActivityOf** (Object property)
> - **Label:** is activity of
> - **IRI:** http://example.org/isActivityOf
> - **Definition:** Relates an activity to the affected resource.
> - **Domain:** http://example.org/Activity
> - **Inverse of:** http://example.org/hasActivity

**ex:hasOrigin** (Object property)
> - **Label:** has origin
> - **IRI:** http://example.org/hasOrigin
> - **Definition:** Specifies the physical location from which this resource (e.g., a title) originates, such as spine, cover, container, etc.
> - **Scope note:** Distinct from http://example.org/hasSource, which specifies an external organization or scheme from which the resource was obtained.

**ex:hasSource** (Object property)
> - **Label:** has Source
> - **IRI:** http://example.org/hasSource
> - **Definition:** Relates this resource to the source from which it was derived.
> - **Scope note:** Has general applicability to many types of sources and resources.
> - **Inverse of:** http://example.org/isSourceOf

**ex:isSourceOf** (Object property)
> - **Label:** is source of
> - **IRI:** http://example.org/isSourceOf
> - **Definition:** Relates this resource to a resource of which it is the source.
> - **Scope note:** Has general applicability to many types of sources and resources.
> - **Inverse of:** http://example.org/hasSource

**ex:hasPreferredTitle** (Object property)
> - **Label:** has preferred title
> - **IRI:** http://example.org/hasPreferredTitle
> - **Definition:** Specifies the preferred title of this resource.
> - **Scope note:** A resource may have multiple directly linked titles, among which this is the preferred title.
> - **Subproperty of: http://id.loc.gov/ontologies/bibframe/title
> - **Range:** http://id.loc.gov/ontologies/bibframe/Title
> - **Inverse of:** http://example.org/isPreferredTitleOf

**ex:isPreferredTitleOf** (Object property)
> - **Label:** is preferred title of
> - **IRI:** http://example.org/isPreferredTitleOf
> - **Definition:** Specifies the resource for which this is the preferred title.
> - **Scope note:** A resource may have multiple directly linked titles, among which this is the preferred title.
> - **Subproperty of: http://example.org/isTitleOf
> - **Domain:** http://id.loc.gov/ontologies/bibframe/Title
> - **Inverse of:** http://example.org/hasPreferredTitle

**dcterms:hasPart**
> - **Label:** Has Part
> - **IRI:** http://purl.org/dc/terms/hasPart
> - **Comment:** A related resource that is included either physically or logically in the described
resource.

**vivo:rank**
> - **Label:** rank
> - **IRI:** http://vivoweb.org/ontology/core#rank
> - **Comment:** An integer indicating the position of an entity in a list.

<a name="individuals">Recommended Named Individuals</a>
--------

**ex:invalid**
> - **Label:** invalid
> - **IRI:** http://example.org/invalid
> - **Definition:** Applies to an identifier or other resource that is invalid.
> - **Belongs to:** http://id.loc.gov/ontologies/bibframe/Status

**ex:caption**
> - **Label:** caption
> - **IRI:** http://example.org/caption
> - **Definition:** Applies to a resource (e.g., a title) given at the beginning of the first page of the text.
> - **Belongs to:** http://example.org/Origin

**ex:supplied**
> - **Label:** supplied
> - **IRI:** http://example.org/supplied
> - **Definition:** Supplied value, not directly transcribed from the resource itself.
> - **Belongs to:** http://example.org/Origin

**ex:transcribed**
> - **Label:** supplied
> - **IRI:** http://example.org/transcribed
> - **Definition:** Value transcribed directly from the resource.
> - **Belongs to:** http://example.org/Origin

**ex:translated**
> - **Label:** translated
> - **IRI:** TBD
> - **Definition:** Value translated from another language, not transcribed from the resource itself.
> - **Belongs to:** http://example.org/Origin

<a name="diagrams">Diagrams</a>
--------

Transcribed title

![TranscribedTitle](/modeling_recommendations/modeling_diagrams/TranscribedTitle.jpg)

Creator's title

![CreatorsTitle_2](/modeling_recommendations/modeling_diagrams/CreatorsTitle_2.jpg)

Translated title

![translatedTitle](/modeling_recommendations/modeling_diagrams/translatedTitle.jpg)

<a name="rdf">RDF Samples</a>
--------
**Title transcribed from resource**

```
:instance1 a bf:Instance ;
 bf:isInstanceOf :w1 ;
 ex:hasPreferredTitle :t1 .

:t1 a bf:Title ;
 ex:isPreferredTitleOf :instance1 ;
 rdf:value "Burial of Famine Victim,  
 Hengyang, China" ;
 ex:hasOrigin :transcribed ; origin1 ;
 dcterms:hasPart :mainTitleElement1 .

:mainTitleElement1 a ex:MainTitleElement ;
 rdf:value “Burial of Famine Victim,
 Hengyang, China” ;
 dcterms:isPartOf :t2 .

ex:transcribed a owl:NamedIndividual, ex:Origin ;
 rdfs:label "transcribed" .

:origin1 a ex:Origin ;
rdf:value “verso” .

```
**Supplied, transcribed, incorrect title**

```
:w1 a bf:Work ;
 ex:hasPreferredTitle :t1 ;
 bf:hasInstance :instance1, :instance2 .

:t1 a bf:Title ;
 ex:isPreferredTitleOf :w1 ;
 rdf:value "Barracks near Segezha
 Station"@en ;
 dcterms:hasPart :mainTitleElement1 .
 
:mainTitleElement1 a ex:MainTitleElement ;
 rdf:value "Barracks near Segezha
 Station"@en ;
 dcterms:isPartOf :t1.

:instance1 a bf:Instance ;
 bf:isInstanceOf :w1 ;
 ex:hasPreferredTitle :t2 ;
 bf:genreForm :negatives (photographs) ;
 bf:title :t2 .
 
:t2 a bf:Title ;
 ex:isPreferredTitleOf :instance1 ;
 rdf:value "Barracks near Segezha
 Station"@en ;
 ex:origin ex:supplied ;
 ex:hasSource :source1 ;
  bf:note :note1 .
 dcterms:hasPart :mainTitleElement2 .
 
 :mainTitleElement2 a ex:MainTitleElement ;
 rdf:value "Barracks near Segezha
 Station"@en ;
 dcterms:isPartOf :t2 .

 :note1 a bf:Note ;
 rdf:value "Title devised by Library staff."

:source1 a bf:Source ;
rdf:value "http://prokudin-gorsky.org/?lang=en"^^xsd:anyURI .
 
:instance2 a bf:Instance ;
 ex:hasPreferredTitle :t3 ;
 bf:title :t4 ;
 bf:genreForm :photographic prints ;
 bf:isInstanceOf :w1 .

:t3 a bf:Title ;
 ex:isPreferedTitleOf :instance2 ;
 rdf:value "Barracks near Segezha
 Station"@en ;
 ex:origin ex:supplied ;
 ex:hasSource :source1 ;
 bf:note :note1 ;
 dcterms:hasPart :mainTitleElement3 .

:mainTitleElement3 a ex:MainTitleElement ;
 rdf:value "Barracks near Segezha
 Station"@en ;
 dcterms:isPartOf :t3 .

:t4 a bf:Title ;
 ex:isTitleOf :instance2 ;
 rdf:value "Baraki dli︠a︡ voennopi︠e︡nnykh u st.
 Segezh (Prisoner of war barracks near the
 Segezh Station)" ;
 dcterms:hasPart :mainTitleElement4 ;
 ex:origin ex:transcribed, ex:caption ;
 bf:status ex:invalid ;
 bf:note :note2 .
 
 :note2 a bf:Note ;
 rdfs:label "Incorrect caption in album" .

ex:supplied a owl:NamedIndividual , ex:Origin ;
 rdfs:label "supplied" .

ex:transcribed a owl:NamedIndividual , ex:Origin ;
 rdfs:label "transcribed" .

**Example for title change**

:w1 a bf:Work ;
 ex:hasActivity :c1 ;
 ex:hasPreferredTitle :title1 ;
 bf:title :title2, :title3, :title4 .

:c1 a ex:ArtistActivity ;
 ex:hasAgent <http://id.loc.gov/rwo/agents/n80061185> .

:title1 a bf:Title ;
 rdf:value "Swimming" ;
 ex:isPreferredTitleOf :w1 ;
 dcterms:hasPart :MainTitleElement1 ; 
 bf:note :note1 ;
 ex:hasSource <http://worldcat.org/entity/work/id/36654331> , 
<http://id.loc.gov/rwo/agents/n80061185> .

:MainTitleElement1 a ex:MainTitleElement ;
 dcterms:isPartOf :title1 ;
 rdfs:label "Swimming" .

:note1 a bf:Note ;
 rdf:value "Correspondence with Sam Duncan, Asst. Museum Librarian,
 Amon Carter Museum, 4/11/96 (based on new research, "Swimming" has
 been determined to be Eakins' original title and the title under which
 it was first exhibited; wall labels, catalog listings, etc. have been
 changed from "The Swimming hole" to "Swimming" to reflect this new research.)" .

:title2 a bf:Title ;
 bf:isTitleOf :w1 ;
  rdf:value "Swimming hole" ;
 dcterms:hasPart :MainTitleElement2 ;
 ex:hasSource :source2 .

:source2 a bf:Source ;
 ex:isSourceOf :title2 ;
 rdf:value "Britannica Micro., 1995:
 v. 4, p. 315 (Eakins, Thomas; treading water
 next to his setter dog Harry and watching a
 group of students swimming in "The 
 Swimming Hole.")" .

:MainTitleElement2 a ex:MainTitleElement ;
 dcterms:isPartOf :title2 ;
 rdf:value "Swimming hole" .

:title3 a bf:Title ;
 bf:isTitleOf :w1 ;
 rdf:value "Old swimming hole" ;
 dcterms:hasPart :MainTitleElement3 ;
 ex:hasSource <http://worldcat.org/entity/work/id/36654331> .

:MainTitleElement3 a ex:MainTitleElement ;
 dcterms:isPartOf :title3 ;
 rdf:value "Old swimming hole" .

:title4 a bf:Title ;
 bf:isTitleOf :w1 ;
 rdf:value "Swimmers" ;
 dcterms:hasPart :MainTitleElement4 ;
 ex:hasSource <http://worldcat.org/entity/work/id/36654331> .

:MainTitleElement4 a ex:MainTitleElement ;
 dcterms:isPartOf :title4 ;
 rdfs:label "Swimmers" .

```
**Work in multiple languages**
```
:w1 a bf:Work ;
 ex:hasActivity :c1 ;
 ex:hasPreferredTitle :title1 ;
 bf:title :title2, :title3, :title4 .

:c1 a ex:ArtistActivity ;
 ex:hasAgent <http://id.loc.gov/rwo/agents/n78086005> .

:title1 a bf:Title;
 ex:isPreferredTitleOf :w1 ;
 rdf:value "Les Demoiselles d'Avignon"@fr ;
 dcterms:hasPart :mainTitleElement1, :nonSort1 ;
 ex:hasSource <http://id.loc.gov/rwo/agents/n79021281> .

:mainTitleElement1 a ex:MainTitleElement ;
 dcterms:isPartOf :title1 ;
 rdf:value "Demoiselles d'Avignon"@fr .

:nonSort1 a ex:NonSortElement ;
 dcterms:isPartOf :title1 ;
 rdf:value "Les"@fr .

:title2 a bf:Title ;
 bf:isTitleOf :w1 ;
 rdf:value "Young ladies of Avignon"@en ;
 dcterms:hasPart :mainTitleElement2 ;
 ex:hasSource :source1 .

:mainTitleElement2 a ex:MainTitleElement ;
 dcterms:isPartOf :title2 ;
 rdf:value "Young ladies of Avignon"@en .

:source1 a bf:Work ,
 bf:title :title5 .

:title5 a bf:Title ;
 rdf:value "Index to reproductions of    
 European art" .

:title3 a bf:Title ;
 bf:isTitleOf :w1 ;
 rdf:value "Avignon brothel"@en ;
 dcterms:hasPart :mainTitleElement3 ;
 ex:hasSource <http://worldcat.org/entity/work/id/56688045> .

:mainTitleElement3 a ex:MainTitleElement ;
 dcterms:isPartOf :title3 ;
 rdf:value "Avignon brothel"@en .

:title4 a bf:Title ;
 bf:isTitleOf :w1 ;
 rdf:value "Le Bordel"@fr ;
 dcterms:hasPart :mainTitleElement4, :nonSort2 ;
 ex:hasSource <http://worldcat.org/entity/work/id/3901310255> .

:mainTitleElement4 a ex:MainTitleElement ;
 dcterms:isPartOf :title4 ;
 rdf:value "Bordel"@fr .

:nonSort4 a ex:NonSortElement ;
 dcterms:isPartOf :title4 ;
 rdf:value "Le"@fr .
 
```
**Example of title, subtitle and a variant title**

```
:w1 a bf:Work ;
 ex:hasPreferredTitle :title1 ;
 bf:title :title2 ;
 bf:hasInstance :instance1 .

:title1 a bf:Title ;
 ex:isPreferredTitleOf :w1 ;
 rdf:value "I [love] Venice"@en ;
 dcterms:hasPart :mainTitleElement1 .

:mainTitleElement1 a ex:MainTitleElement ;
 dcterms:isPartOf :title1 ;
 rdf:value "I [love] Venice"@en .


:title2 a bfTitle ;
 bf:isTitleOf :w1 ;
 rdf:value "I heart Venice"@en ;
 dcterms:hasPart :mainTitleElement2 .

:mainTitleElement2 a ex:MainTitleElement ;
 dcterms:isPartOf :title2 ;
 rdf:value "I heart Venice"@en .
  :instance1 a bf:Instance
 bf:isInstanceOf :w1 ;
 ex:hasPreferredTitle :title3 ;
 bf:title :title4 .
 
:title3 a bf:Title ;
 ex:isPreferredTitleOf :instance1 ;
 rdf:value "I [love] Venice : portable pocket ashtray"@en ;
 dcterms:hasPart :mainTitleElement3, :subtitle1 ;
 bf:note :note1 .

:mainTitleElement3 a ex:MainTitleElement ;
 dcterms:isPartOf :title3 ;
 rdf:value "I [love] Venice"@en .

:subtitle1 a ex:SubTitleElement ;
 dcterms:isPartOf :title3 ;
 rdf:value "portable pocket ashtray"@en .

:title4 a bf:Title ;
 bf:isTitleOf :instance1 ;
 rdf:value "I heart Venice : portable pocket ashtray"@en ;
 dcterms:hasPart :mainTitleElement4, :subtitle2 .

:mainTitleElement4 a ex:MainTitleElement ;
 dcterms:isPartOf :title2 ;
 rdf:value "I heart Venice"@en .

:subtitle2 a ex:SubTitleElement ;
 dcterms:isPartOf :title2 ;
 rdfs:value "portable pocket ashtray"@en .

:note1 a bf:Note ;
 rdf:value “In title, the word "love" is   
 represented by a heart symbol.” .
 
 ```
 **Example of multiple subtitles**
 
 ```
 :instance1 a bf:Instance
 bf:isInstanceOf :w1 ;
 ex:hasPreferredTitle :title1 .

:title1 a bf:Title ;
 ex:isPreferredTitleOf :instance1 ;
 rdf:value "New York City : Newspaper Row 
 on an Election Night : Announcing the Returns ;
 dcterms:hasPart :mainTitleElement1, :subtitle1, :subtitle2 ;
 ex:origin :transcribed .

:mainTitleElement1 a ex:MainTitleElement ;
 dcterms:isPartOf :title1 ;
 rdf:value "New York City"@en ;
 vivo:rank 1 .

:subtitle1 a ex:SubtitleElement ;
 rdfs:label “Newspaper Row on an Election Night”@en ;
 vivo:rank 2 .    
 
:subtitle2 a ex:SubtitleElement ;
 rdfs:label “Announcing the Returns”@en ;
 vivo:rank 3 .
