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
![Title Use Case](/modeling_recommendations/modeling_diagrams/title_use_case.png)

Examples: Les Demoiselles d'Avignon (The Young Ladies of Avignon, and originally titled The Brothel of Avignon) (Wikipedia); Swimming, by Thomas Eakins (formerly The Swimming Hole) (title change based on research)

<a name="MARC">Titles in MARC</a>
--------
In a MARC bibliographic record, many types of titles are recorded in the 20x-24x area [*http://www.loc.gov/marc/bibliographic/bd20x24x.html*](http://www.loc.gov/marc/bibliographic/bd20x24x.html). The instance title is tagged as a 245. A work title is recorded in a 240 or 130. If neither one of these are present, then the 245 can be interpreted as the title of the work as well as the instance title. The 245 allows for sub-fielding of non-sorting characters and subtitles. Variant titles are recorded in a 246, where indicators can be used to show the type or source of the variant tiles. Related titles can occur in the 6xx $t, 7xx $t, 730 or 740.

<a name="BIBFRAME">Titles in BIBFRAME</a>
--------
The classes and properties that are available to express in BIBFRAME are summarized here:

![BIBFRAME Title Model](/modeling_recommendations/modeling_diagrams/title_bibframe.png)

[*http://id.loc.gov/ontologies/bibframe-category.html*](http://id.loc.gov/ontologies/bibframe-category.html) accessed on July 31, 2017.

Other properties that can be used in conjunction with title information are bf:source, bf:date, bf:qualifier, and bf:note.

Subclasses of bf:VariantTitle: KeyTitle, AbbreviatedTitle, ParallelTitle, CollectiveTitle.

<a name="bibliotek-o">Titles in bibliotek-o</a>
--------
![bibliotek-o title properties](/modeling_recommendations/modeling_diagrams/title_bibliotek-o_classes.png
)

![bibliotek-o title classes](/modeling_recommendations/modeling_diagrams/title_bibliotek-o_properties.png)

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

**ex:Origin**
> - **Label**: Origin
> - **IRI:** http://example.org/Origin
> - **Definition:** The place from which a resource (e.g., a title) originates, such as spine, cover, container, etc.

<a name="properties">Recommended Properties</a>
--------

**bf:title** (object property)
> - **Label:** Title resource
> - **IRI:** http://id.loc.gov/ontologies/bibframe/title
> - **Definition:** Name given to a resource.
> - **Comment:** Used with Work, Instance or Item.
> - **Range:** http://id.loc.gov/ontologies/bibframe/Title

**ex:titleOf** (object property)
> - **Label:** title of
> - **IRI:** http://example.org/titleOf
> - **Definition:** Resource that this title belongs to.
> - **Domain:** http://id.loc.gov/ontologies/bibframe/Title
> - **Inverse:** http://id.loc.gov/ontologies/bibframe/title

**bf:mainTitle** (datatype property)
> - **Label:** Main title
> - **IRI:** http://id.loc.gov/ontologies/bibframe/mainTitle
> - **Comment:** Title being addressed. Possible title component.
> - **Domain:** http://id.loc.gov/ontologies/bibframe/Title
> - **Range:** Literal

**bf:subtitle** (datatype property)
> - **Label:** Subtitle
> - **IRI:** http://id.loc.gov/ontologies/bibframe/subtitle
> - **Comment:** Word, character, or group of words and/or characters that contains the remainder of the title after the main title. Possible title component.
> - **Domain:** http://id.loc.gov/ontologies/bibframe/Title
> - **Range:** Literal

**bf:partName** (datatype property)
> - **Label:** Part title
> - **IRI:** http://id.loc.gov/ontologies/bibframe/partName
> - **Comment:** Part or section name of a title. Possible title component.
> - **Domain:** http://id.loc.gov/ontologies/bibframe/Title
> - **Range:** Literal

**bf:partNumber** (datatype property)
> - **Label:** Part number
> - **IRI:** http://id.loc.gov/ontologies/bibframe/partNumber
> - **Comment:** Part or section enumeration of a title. Possible title component.
> - **Domain:** http://id.loc.gov/ontologies/bibframe/Title
> - **Range:** Literal

**bf:mainTitle** (datatype property)
> - **Label:** Title resource
> - **IRI:** http://id.loc.gov/ontologies/bibframe/title
> - **Comment:** Title being addressed. Possible title component.
> - **Domain:** http://id.loc.gov/ontologies/bibframe/Title
> - **Range:** Literal

**bf:note** (object property)
> - **Label:** Note
> - **IRI:** http://id.loc.gov/ontologies/bibframe/note
> - **Definition:** General textual information relating to a resource, such as Information about a specific copy of a resource or information about a particular attribute of a resource.
> - **Comment:** Used with Unspecified.
> - **Range:** http://id.loc.gov/ontologies/bibframe/Note

**bf:status** (object property)
> - **Label:** Status
> - **IRI:** http://id.loc.gov/ontologies/bibframe/status
> - **Definition:** Designation of the validity or position of something, such as indication that the classification number is canceled or invalid, circulation availability of an item, indication of whether the identifier is canceled or invalid.
> - **Comment:** Used with Unspecified.
> - **Range:** http://id.loc.gov/ontologies/bibframe/Status

**ex:hasActivity** (object property)
> - **Label:** has activity
> - **IRI:** http://example.org/hasActivity
> - **Definition:** Relates this resource to an activity or contribution by a single agent that affects or alters its existence or state.
> - **Range:** http://example.org/Activity
> - **Inverse of:** http://example.org/isActivityOf

**ex:isActivityOf** (object property)
> - **Label:** is activity of
> - **IRI:** http://example.org/isActivityOf
> - **Definition:** Relates an activity to the affected resource.
> - **Domain:** http://example.org/Activity
> - **Inverse of:** http://example.org/hasActivity

**ex:hasOrigin** (object property)
> - **Label:** has origin
> - **IRI:** http://example.org/hasOrigin
> - **Definition:** Specifies the physical location from which this resource (e.g., a title) originates, such as spine, cover, container, etc.
> - **Scope note:** Distinct from http://example.org/hasSource, which specifies an external organization or scheme from which the resource was obtained.

**ex:hasSource** (object property)
> - **Label:** has Source
> - **IRI:** http://example.org/hasSource
> - **Definition:** Relates this resource to the source from which it was derived.
> - **Scope note:** Has general applicability to many types of sources and resources.
> - **Inverse of:** http://example.org/isSourceOf

**ex:isSourceOf** (object property)
> - **Label:** is source of
> - **IRI:** http://example.org/isSourceOf
> - **Definition:** Relates this resource to a resource of which it is the source.
> - **Scope note:** Has general applicability to many types of sources and resources.
> - **Inverse of:** http://example.org/hasSource

**ex:hasPreferredTitle** (object property)
> - **Label:** has preferred title
> - **IRI:** http://example.org/hasPreferredTitle
> - **Definition:** Specifies the preferred title of this resource.
> - **Scope note:** A resource may have multiple directly linked titles, among which this is the preferred title.
> - **Subproperty of: http://id.loc.gov/ontologies/bibframe/title
> - **Range:** http://id.loc.gov/ontologies/bibframe/Title
> - **Inverse of:** http://example.org/isPreferredTitleOf

**ex:isPreferredTitleOf** (object property)
> - **Label:** is preferred title of
> - **IRI:** http://example.org/isPreferredTitleOf
> - **Definition:** Specifies the resource for which this is the preferred title.
> - **Scope note:** A resource may have multiple directly linked titles, among which this is the preferred title.
> - **Subproperty of: http://example.org/titleOf
> - **Domain:** http://id.loc.gov/ontologies/bibframe/Title
> - **Inverse of:** http://example.org/hasPreferredTitle

**dcterms:hasPart**
> - **Label:** Has Part
> - **IRI:** http://purl.org/dc/terms/hasPart
> - **Comment:** A related resource that is included either physically or logically in the described
resource.

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
> - **Label:** transcribed
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

**Note: diagrams need revision due to change of model from title element resources to BIBFRAME title part datatype properties. The [RDF samples below](#rdf) are up-to-date.**

Transcribed title

![TranscribedTitle](/modeling_recommendations/modeling_diagrams/title_transcribed.jpg)

Creator's title

![CreatorsTitle_2](/modeling_recommendations/modeling_diagrams/title_creators.jpg)

Translated title

![translatedTitle](/modeling_recommendations/modeling_diagrams/title_translated.jpg)

<a name="rdf">RDF Samples</a>
--------
**Title transcribed from resource**

```
:instance a bf:Instance ;
     bf:isInstanceOf :work ;
     ex:hasPreferredTitle :title .

:title a bf:Title ;
     ex:isPreferredTitleOf :instance ;
     rdf:value "Burial of Famine Victim, Hengyang, China" ;
     ex:hasOrigin :transcribed ; :origin .

:origin a ex:Origin ;
    rdf:value “verso” .

```
**Supplied, transcribed, incorrect title**

```
:work1 a bf:Work ;
    ex:hasPreferredTitle :title1 ;
    bf:hasInstance :instance1, :instance2 .

:title1 a bf:Title ;
    ex:isPreferredTitleOf :work1 ;
    rdf:value "Barracks near Segezha Station"@en .
 
:instance1 a bf:Instance ;
    bf:isInstanceOf :work1 ;
    ex:hasPreferredTitle :title2 ;
    bf:genreForm :negatives_photographs .
 
:title2 a bf:Title ;
    ex:isPreferredTitleOf :instance1 ;
    rdf:value "Barracks near Segezha Station"@en ;
    ex:origin ex:supplied ;
    ex:hasSource <http://prokudin-gorsky.org/?lang=en> ;
    bf:note :note1 .

:note1 a bf:Note ;
    rdf:value "Title devised by Library staff."
   
:instance2 a bf:Instance ;
    ex:hasPreferredTitle :title3 ;
    bf:title :title4 ;
    bf:genreForm :photographic_prints ;
    bf:isInstanceOf :work1 .

:title3 a bf:Title ;
    ex:isPreferedTitleOf :instance2 ;
    rdf:value "Barracks near Segezha Station"@en ;
    ex:origin ex:supplied ;
    ex:hasSource <http://prokudin-gorsky.org/?lang=en> ;
    bf:note :note2 .
        
:note2 a bf:Note ;
    rdf:value "Title devised by Library staff."

:title4 a bf:Title ;
    ex:titleOf :instance2 ;
    rdf:value "Baraki dli︠a︡ voennopi︠e︡nnykh u st. Segezh (Prisoner of war 
        barracks near the Segezh Station)" ;
    ex:origin ex:transcribed, ex:caption ;
    bf:status ex:invalid ;
    bf:note :note3 .

:note3 a bf:Note ;
    rdf:value "Incorrect caption in album" .
```

**Title change**

```
:work1 a bf:Work ;
    ex:hasActivity :activity1 ;
    ex:hasPreferredTitle :title1 ;
    bf:title :title2 , :title3 , :title4 .

:activity1 a ex:ArtistActivity ;
    bf:agent <http://id.loc.gov/rwo/agents/n80061185> .

:title1 a bf:Title ;
    rdf:value "Swimming" ;
    ex:isPreferredTitleOf :work1 ; 
    bf:note :note1 ;
    ex:hasSource <http://worldcat.org/entity/work/id/36654331> , 
        <http://id.loc.gov/rwo/agents/n80061185> .

:note1 a bf:Note ;
    rdf:value "Correspondence with Sam Duncan, Asst. Museum Librarian,
        Amon Carter Museum, 4/11/96 (based on new research, \"Swimming\" has
        been determined to be Eakins' original title and the title under which
        it was first exhibited; wall labels, catalog listings, etc. have been
        changed from \"The Swimming Hole\" to \"Swimming\" to reflect this new research.)" .

:title2 a bf:Title ;
    ex:titleOf :work1 ;
    rdf:value "The Swimming Hole" ;
    ex:hasSource :source2 .

:source2 a bf:Source ;
    ex:isSourceOf :title2 ;
    rdf:value "Britannica Micro., 1995: v. 4, p. 315 (Eakins, Thomas; treading water
        next to his setter dog Harry and watching a group of students swimming in \"The 
        Swimming Hole\")" .

:title3 a bf:Title ;
    ex:titleOf :work1 ;
    rdf:value "The Old Swimming Hole" ;
    ex:hasSource <http://worldcat.org/entity/work/id/36654331> .

:title4 a bf:Title ;
    ex:titleOf :work1 ;
    rdf:value "Swimmers" ;
    ex:hasSource <http://worldcat.org/entity/work/id/36654331> .

```
**Title in multiple languages**
```
:work1 a bf:Work ;
    ex:hasActivity :activity1 ;
    ex:hasPreferredTitle :title1 ;
    bf:title :title2 , :title3 , :title4 .

:activty1 a ex:ArtistActivity ;
    ex:hasAgent <http://id.loc.gov/rwo/agents/n78086005> .

:title1 a bf:Title;
    ex:isPreferredTitleOf :work1 ;
    rdf:value "Les Demoiselles d'Avignon"@fr ;
    bf:mainTitle "Demoiselles d'Avignon"@fr ;
    ex:hasSource <http://id.loc.gov/rwo/agents/n79021281> .

:title2 a bf:Title ;
    ex:titleOf :work1 ;
    rdf:value "Young ladies of Avignon"@en ;
    ex:hasSource :work2 .

:work2 a bf:Work ,
    bf:title :title5 .

:title5 a bf:Title ;
    rdf:value "Index to reproductions of European art" .

:title3 a bf:Title ;
     ex:titleOf :work1 ;
     rdf:value "Avignon brothel"@en ;
     ex:hasSource <http://worldcat.org/entity/work/id/56688045> .

:title4 a bf:Title ;
    ex:titleOf :work1 ;
    rdf:value "Le Bordel"@fr ;
    bf:mainTitle "Bordel"@fr ;
    ex:hasSource <http://worldcat.org/entity/work/id/3901310255> .
 
```

**Title, subtitle, and variant title**

```
:work1 a bf:Work ;
    ex:hasPreferredTitle :title1 ;
    bf:title :title2 ;
    bf:hasInstance :instance1 .

:title1 a bf:Title ;
    ex:isPreferredTitleOf :work1 ;
    rdf:value "I [love] Venice"@en .

:title2 a bf:Title ;
    ex:titleOf :work1 ;
    rdf:value "I heart Venice"@en .
    
:instance1 a bf:Instance
    bf:isInstanceOf :work1 ;
    ex:hasPreferredTitle :title3 ;
    bf:title :title4 .
 
:title3 a bf:Title ;
    ex:isPreferredTitleOf :instance1 ;
    rdf:value "I [love] Venice : portable pocket ashtray"@en ;
    bf:mainTitle "I [love] Venice"@en ;
    bf:subtitle "portable pocket ashtray"@en ;
    bf:note :note1 .

:title4 a bf:Title ;
    ex:titleOf :instance1 ;
    rdf:value "I heart Venice : portable pocket ashtray"@en ;
    bf:mainTitle "I heart Venice"@en ;
    bf:subtitle "portable pocket ashtray"@en .

:note1 a bf:Note ;
    rdf:value “In title, the word \"love\" is represented by a heart symbol.” .
 
 ```
 