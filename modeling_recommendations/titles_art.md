Titles in Art Cataloging
=====================================================
ArtFrame, 2017-10-06

Table of Contents
> - [Sources](#sources)
> - [Background](#background)
> - [Recommendations for Moving Forward](#recommendations)
> - [Relevant ArtFrame Use Case](#useCase)
> - [Titles in MARC](#MARC)
> - [Titles in BIBFRAME](#BIBFRAME)
> - [Titles in bibliotek-o](#bibliotek-o)
> - [Side-by-Side Examples](#examples)


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

After testing the bibliotek-o title model, the ArtFrame group agreed that it can generally be applied to art objects. However, in order to support art cataloging standards (such as CCO, CDWA and DCRM(G)) and other requirements unique to art objects, the group proposes additional title subclasses based on the title types listed in CCO Chapter 1, p. 49-50 ([*http://cco.vrafoundation.org/downloads/PartTwo_1-ObjectNaming.pdf*](http://cco.vrafoundation.org/downloads/PartTwo_1-ObjectNaming.pdf)) as well as CDWA ([*http://www.getty.edu/research/publications/electronic_publications/cdwa/4titles.html*](http://www.getty.edu/research/publications/electronic_publications/cdwa/4titles.html)), for cases when these types cannot be covered by bib:Origin or bf:Source. The ArtFrame group recommends that two additional title types (published and manuscript designation) will be referred to the Rare Materials Group for discussion.

> - **Define the following additional bf:Title subclasses in the ArtFrame namespace:**

> - af:RepositoryTitle
> - af:CreatorsTitle
> - af:DescriptiveTitle
> - af:TranslatedTitle
> - af:OriginalTitle
> - af:ExhibitionTitle
> - af:FormerTitle

> - **Title Origin**

Title origins (the place from which a title originates, i.e. container, margin, spine) are less clearly defined for objects different from regular print books. Established owl:NamedIndividuals in bibliotek-o, such as bib:supplied and bib:transcribed should be applied where appropriate, but no additional art specific named individuals will be defined within the ArtFrame namespace. DCRM(G) 1B2 states: Always make a note on the source of the title proper. The examples given are: Title from lower margin; Title from ink note on book of mount; title from item, etc. This list could potentially be endless. For the sake of consistency, title origins should always be treated as annotations attached to the title resource, following the Notes and Annotations pattern.

> - **Title Source**

Where the source of the title can be clearly identified and adequately represented by a URI, bib:hasSource should be applied. However, use of annotations are more appropriate for more complex and “fuzzy” situations.

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

Named individuals to be used with bib:Origin: binder, caption, container, cover, margin, spine, supplied, transcribed 

<a name="examples">Side-by-Side Examples</a>
--------
> - **Title transcribed from resource -- BIBFRAME**
```
:w1 a bf:Work ;
 bf:title :t1 ;
 bf:hasInstance :instance1 .

:t1 a bf:Title ;
 rdfs:label "Burial of Famine Victim,
 Hengyang, China" ;
 bf:mainTitle “Burial of Famine Victim,
 Hengyang, China" .

:instance1 a bf:Instance ;
 bf:isInstanceOf :w1 ;
 bf:title :t2 .

:t2 a bf:Title ;
 rdfs:label "Burial of Famine Victim,
 Hengyang, China" ;
 bf:note :n1 ;
 bf:mainTitle “Burial of Famine Victim,
 Hengyang, China" .
 
:n1 a bf:Note ;
 noteType “TitleOrigin” ;
 rdfs:label “Title from verso” .

```
> - **Title transcribed from resource -- bibliotek-o/ArtFrame**
```
:w1 a bf:Work ;
 bib:hasPreferredTitle :t1 ;
 bf:hasInstance :instance1 .

:t1 a bf:Title ;
 bib:isPreferredTitleOf :w1 ;
 rdfs:label "Burial of Famine Victim,
 Hengyang, China" ;
 dcterms:hasPart :MainTitleElement1 .

:MainTitleElement1 a bib:MainTitleElement ;
 rdfs:label “Burial of Famine Victim,
 Hengyang, China” ;
 dcterms:isPartOf :t1 .

:instance1 a bf:Instance ;
 bf:isInstanceOf :w1 ;
 bib:hasPreferredTitle :t2 .

:t2 a bf:Title ;
 bib:isPreferredTitleOf :instance1 ;
 rdfs:label "Burial of Famine Victim,  
 Hengyang, China" ;
 bib:origin :transcribed ;
 bib:isTargetOf :n1 ;
 dcterms:hasPart :MainTitleElement2 .

:MainTitleElement2 a bib:MainTitleElement ;
 rdfs:label “Burial of Famine Victim,
 Hengyang, China” ;
 dcterms:isPartOf :t2 .

:transcribed a owl:NamedIndividual ,   
 bib:TitleOrigin ;
 rdfs:label "transcribed" .
 :n1 a oa:Annotation ;
 oa:hasTarget :instance1 ;
 oa:motivatedBy oa:describing ;
 oa:hasBody :b1 .
 :b1 a oa:TextualBody, a bf:Note ;
 rdfs:label “Title from verso.” .

```
> - **Supplied, transcribed, incorrect title -- BIBFRAME**
```
:w1 a bf:Work ;
 bf:title :t1 ;
 bf:hasInstance :instance1, :instance2 .

:t1 a bf:Title ;
 bf:titleOf :w1 ;
 rdfs:label "Barracks near Segezha  
 Station"@en ;
 bf:mainTitle “Barracks near Segezha  
 Station" ;
 bf:note :note1, :note2 .

:note1 a bf:Note ;
 bf:noteType "title source" ;
 rdfs:label "Title devised by Library staff.
(Source: International Research Project
"The Legacy of S.M. Prokudin Gorsky" 2012-2016)" .

:n2 a bf:Note ;
 bf:noteType "title source" ;
 "http://prokudin-gorsky.org/?lang=en"^^xsd:anyURI .

 
:instance1 a bf:Instance ;
 bf:genreForm :negatives (photographs) ;
 bf:isInstanceOf :w1 ;
 bf:title :t2 .

:instance2 a bf:Instance ;
 bf:genreForm :photographic prints ;
 bf:isInstanceOf :w1 ;
 bf:title :t3, :t4 .
 

:t2 a bf:Title ;
 rdfs:label "Barracks near Segezha  
 Station"@en ;
 bf:mainTitle “Barracks near Segezha  
 Station" .


:t3 a bf:Title ;
 rdfs:label "Barracks near Segezha 
 Station"@en ;
 bf:mainTitle “Barracks near Segezha  
 Station" .

:t4 a bf:VariantTitle ;
 rdfs:label "Baraki dli︠a︡ voennopi︠e︡nnykh u st. 
 Segezh (Prisoner of war barracks near the 
 Segezh Station)" ;
 bf:mainTitle “Baraki dli︠a︡ voennopi︠e︡nnykh u 
 St.  Segezh (Prisoner of war barracks near 
 the  Segezh Station)" ;
 bf:note :note3 .

:n3 a bf:Note ;
 bf:noteType "title source" ;
 rdfs:label "Incorrect caption in album LOT 10334" .


```
> - **Supplied, transcribed, incorrect title -- bibliotek-o/ArtFrame**
```
:w1 a bf:Work ;
 bib:hasPreferredTitle :t1 ;
 bf:hasInstance :instance1,  :instance2 .

:t1 a bf:Title ;
 bib:isPreferredTitleOf :w1 ;
 rdfs:label "Barracks near Segezha
 Station"@en ;
 dcterms:hasPart :mainTitleElement1 .
 
:mainTitleElement1 a bib:MainTitleElement ;
 rdfs:label "Barracks near Segezha
 Station"@en ;
 dcterms:isPartOf :t1.

:instance1 a bf:Instance ;
 bf:isInstanceOf :w1 ;
 bib:hasPreferredTitle :t2 ;
 bf:genreForm :negatives (photographs) ;
 bf:title :t2 .
 
:t2 a bf:Title ;
 bib:isPreferredTitleOf :instance1 ;
 rdfs:label "Barracks near Segezha
 Station"@en ;
 bib:origin :supplied ;
 bib:hasSource :source1 ;
 bib:isTargetOf :n1 ;
 dcterms:hasPart :mainTitleElement2 .
 
 :mainTitleElement2 a bib:MainTitleElement ;
 rdfs:label "Barracks near Segezha
 Station"@en ;
 dcterms:isPartOf :t2 .

:n1 a oa:Annotation ;
 oa:hasTarget :t2,  :t3 ;
 dcterms:creator <http://id.loc.gov/rwo/agents/n79055161> ;
 oa:motivatedBy oa:describing ;
 oa:hasBody :b1 .

:b1 a oa:TextualBody ;
 rdfs:label "Title devised by Library staff."

:source1 a bf:Source ;
 rdfs:label
"http://prokudin-gorsky.org/?lang=en"^^xsd:anyURI .
 
:instance2 a bf:Instance ;
 bib:hasPreferredTitle :t3 ;
 bf:title :t4 ;
 bf:genreForm :photographic prints ;
 bf:isInstanceOf :w1 .

:t3 a bf:Title ;
 bib:isPreferedTitleOf :instance2 ;
 rdfs:label "Barracks near Segezha
 Station"@en ;
 bib:origin :supplied ;
 bib:hasSource :source1 ;
 bib:isTargetOf :n1 ;
 dcterms:hasPart :mainTitleElement3 .
:mainTitleElement3 a bib:MainTitleElement ;
 rdfs:label "Barracks near Segezha
 Station"@en ;
 dcterms:isPartOf :t3 .

:t4 a bf:Title ;
 bib:isTitleOf :instance2 ;
 rdfs:label "Baraki dli︠a︡ voennopi︠e︡nnykh u st.
 Segezh (Prisoner of war barracks near the
 Segezh Station)" ;
 dcterms:hasPart :mainTitleElement4 ;
 bib:origin :transcribed :caption ;
 bf:status :invalid ;
 rdfs:comment "Incorrect caption in album" .

:supplied a owl:NamedIndividual ,
 bf:TitleOrigin ;
 rdfs:label "supplied" .

:transcribed a owl:NamedIndividual ,
 bf:TitleOrigin ;
 rdfs:label "transcribed" .

:caption a owl:NamedIndividual , bf:TitleOrigin ;
 rdfs:label "caption" .

:mainTitleElement4 a bib:MainTitleElement ;
 rdfs:label "Baraki dli︠a︡ voennopi︠e︡nnykh u st.
 Segezh (Prisoner of war barracks near the
 Segezh Station)" ;
 dcterms:isPartOf :t4 .

```
> - **Example for title change -- BIBFRAME**
```
:w1 a bf:Work ;
 bf:contribution :contribution1 ;
 bf:title :title1, :title2, :title3, :title4 .

:contribution1 a bf:Contribution ;
 bf:agent <http://id.loc.gov/rwo/agents/n80061185> ;
 bf:role <http://id.loc.gov/vocabulary/relators/art> .
 <http://id.loc.gov/rwo/agents/n80061185> a bfAgent, bf:Person ;
 rdfs:label "Eakins, Thomas, 1844-1916" .

:title1 a bf:Title ;
 rdfs:label "Swimming" ;
 bf:mainTitle "Swimming ;
 bf:note :note 1, :note2 .

:title2 a bf:Title, bf:VariantTitle ;
 rdfs:label "Old swimming hole" ;
 bf:mainTitle "Old swimming hole ;
 bf:note :note1 .

:title3 a bf:Title, bf:VariantTitle ;
 rdfs:label "Swimming hole" ;
 bf:mainTitle "Swimming hole” ;
 bf:note :note1.

:title4 a bf:Title, bf:VariantTitle ;
 rdfs:label "Swimmers" ;
 bf:mainTitle "Swimmers";
 bf:note :note1 .

:note 1 a bf:Note ;
 bf:noteType "Title source" ;
 rdfs:label "Work cat.: 95-45967:
 Thomas Eakins and the swimming picture, 
 c1996:
 CIP pref. (Thomas Eakins' The swimming 
 hole--now known more accurately as   
 Swimming) p. 8 (original title of work, 1885:   
 Swimming; later Swimmers, Swimming hole, 
 or Old swimming hole)" .

:note2 a bf:Note ;
 bf:noteType "Title source" ;
 rdfs:label "Correspondence with
 Sam Duncan, Asst. Museum Librarian, Amon  
 Carter Museum, 4/11/96
 (based on new research, "Swimming" has 
 been determined to be Eakins' original
 title and the title under which it was first 
 exhibited; wall labels,
 catalog listings, etc. have been changed 
 from "The Swimming hole" to
 "Swimming" to reflect this new research.) ;
 bf:date "1996-11-04"^^edtf:edtf .
```
> - **Example for title change -- bibliotek-o/ArtFrame**
```
:w1 a bf:Work ;
 bib:hasActivity :c1 ;
 bib:hasPreferredTitle :title1 ;
 bf:title :title2, :title3, :title4 .

:c1 a bib:ArtistActivity ;
 bf:agent <http://id.loc.gov/rwo/agents/n80061185> .

<http://id.loc.gov/rwo/agents/n80061185> a   
 bf:Person, bfAgent ;
  rdfs:label "Eakins, Thomas, 1844-1916" .

:title1 a bf:Title, ex:CreatorsTitle ;
 rdfs:label "Swimming" ;
 bib:isPreferredTitleOf :w1 ;
 dcterms:hasPart :MainTitleElement1 ;
 bib:hasSource <http://worldcat.org/entity/work/id/36654331> ;
 bib:isTargetOf :n1 .


:MainTitleElement1 a bib:MainTitleElement ;
 dcterms:isPartOf :title1 ;
 rdfs:label "Swimming" .
 

:n1 a oa:Annotation ;
 oa:hasTarget :title1 ;
 oa:motivatedBy oa:replying ;
 oa:hasBody :b1 .

:b1 a oa:TextualBody ;
 rdfs:label "Correspondence with Sam Duncan, Asst. Museum Librarian,
 Amon Carter Museum, 4/11/96 (based on new research, "Swimming" has
 been determined to be Eakins' original title and the title under which
 it was first exhibited; wall labels, catalog listings, etc. have been
 changed from "The Swimming hole" to "Swimming" to reflect this new research.)" ;
 dcterms:created "1996-04-11"^^edtf:edtf .

:title2 a bf:Title ;
 bf:isTitleOf :w1 ;
 rdfs:label "Swimming hole" ;
 dcterms:hasPart :MainTitleElement2 ;
 bib:hasSource :source2 .

:source2 a bf:Source ;
 bib:isSourceOf :title2 ;
 rdfs:label "Britannica Micro., 1995:
 v. 4, p. 315 (Eakins, Thomas; treading water
 next to his setter dog Harry and watching a
 group of students swimming in "The 
 Swimming Hole.")" .

:MainTitleElement2 a bib:MainTitleElement ;
 dcterms:isPartOf :title2 ;
 rdfs:label "Swimming hole" .

:title3 a bf:Title ;
 bf:isTitleOf :w1 ;
 rdfs:label "Old swimming hole" ;
 dcterms:hasPart :MainTitleElement3 ;
 bib:hasSource <http://worldcat.org/entity/work/id/36654331> .

:MainTitleElement3 a bib:MainTitleElement ;
 dcterms:isPartOf :title3 ;
 rdfs:label "Old swimming hole" .

<http://worldcat.org/entity/work/id/36654331> a bf:Source ;
 bib:isSourceOf :title3, title2, title1 ;
 rdf:value "Work cat.: 95-45967: Thomas Eakins and the swimming picture, c1996:
 CIP pref. (Thomas Eakins' The swimming hole--now known more accurately as Swimming)
 p. 8 (original title of work, 1885: Swimming; later Swimmers, Swimming hole, or Old
 swimming hole)" .

:title4 a bf:Title ;
 bf:isTitleOf :w1 ;
 rdfs:label "Swimmers" ;
 dcterms:hasPart :MainTitleElement4 ;
 bib:hasSource <http://worldcat.org/entity/work/id/36654331> .

:MainTitleElement4 a bib:MainTitleElement ;
 dcterms:isPartOf :title4 ;
 rdfs:label "Swimmers" .

```
> - **Work title in multiple languages -- BIBFRAME**
```
:w1 a bf:Work ;
 bf:contribution :contribution1 ;
 bf:title :title1, :title2, :title3, :title4 ;
 owl:sameAs <http://viaf.org/viaf/181566483>, <http://dbpedia.org/page/Les_Demoiselles_d'Avignon> .

:contribution1 a bf:Contribution ;
 bf:agent <http://id.loc.gov/rwo/agents/n78086005> ;
 bf:role <http://id.loc.gov/vocabulary/relators/art> .

:title1 a bf:Title ;
 rdfs:label "Les Demoiselles d'Avignon"@fr ;
 bf:mainTitle "Les Demoiselles d'Avignon"@fr ;
 bf:note :note 1, :note2, :note3, :note4 .

:title2 a bf:Title, bf:VariantTitle ;
 rdfs:label "Young ladies of Avignon"@en ;
 bf:mainTitle "Young ladies of Avignon"@en ;
 bf:note :note4 .

:title3 a bf:Title, bf:VariantTitle ;
 rdfs:label "Avignon brothel"@en ;
 bf:mainTitle "Avignon brothel"@en ;
 bf:note :note1 .

:title4 a bf:Title, bf:VariantTitle ;
 rdfs:label "Le Bordel"@fr ;
 bf:mainTitle "Le Bordel"@fr ;
 bf:note :note3 .

:note1 a bf:Note ;
 bf:noteType "title source" ;
 rdfs:label "Picasso's brothel, 2001: CIP 
 galleys (according to Picasso, the original 
 title of Les demoiselles d'Avignon was: The 
 Avignon brothel)" .

:note2 a bf:Note ;
 bf:noteType "title source" ;
 rdfs:label "Grove Dict. of art online, Mar. 18, 
 2002 (under Picasso: Les Demoiselles 
 d'Avignon (1907; New York, MOMA))" .

:note3 a bf:Note ;
 bf:noteType "title source" ;
 rdfs:label "Daix, P. Picasso, life and art, 
 c1993:
 p. 65 (painting le Bordel, whose name was 
 later changed to Demoiselles d'Avignon)" .

:note4 a bf:Note ;
 bf:noteType "title source" ;
 rdfs:label "Index to reproductions of  
 European art
 (Demoiselles d'Avignon see Young ladies of Avignon)" .

```
> - **Work title in multiple languages -- bibliotek-o/ArtFrame**
```
:w1 a bf:Work ;
 bib:hasActivity :c1 ;
 bib:hasPreferredTitle :title1 ;
 bf:title :title2, :title3, :title4, :title5 ;
 owl:sameAs <http://viaf.org/viaf/181566483>, <http://dbpedia.org/page/Les_Demoiselles_d'Avignon> .

:c1 a bib:ArtistActivity ;
 bib:hasAgent <http://id.loc.gov/rwo/agents/n78086005> .

:title1 a bf:Title, ex:RepositoryTitle ;
 bib:isPreferredTitleOf :w1 ;
 rdfs:label "Les Demoiselles d'Avignon"@fr ;
 dcterms:hasPart :mainTitleElement1, :nonSort1 ;
 bib:hasSource <http://id.loc.gov/rwo/agents/n79021281> .

:mainTitleElement1 a bib:MainTitleElement ;
 dcterms:isPartOf :title1 ;
 rdfs:label "Demoiselles d'Avignon"@fr .

:nonSort1 a bib:NonSortElement ;
 dcterms:isPartOf :title1 ;
 rdfs:label "Les"@fr .


:title2 a bf:Title ;
 bf:isTitleOf :w1 ;
 rdfs:label "Young ladies of Avignon"@en ;
 dcterms:hasPart :mainTitleElement2 ;
 bib:hasSource :source1 .

:mainTitleElement2 a bib:MainTitleElement ;
 dcterms:isPartOf :title2 ;
 rdfs:label "Young ladies of Avignon"@en .

:source1 a bf:Work ,
 bf:title :title6 .

:title6 a bf:Title ;
 rdfs:label "Index to reproductions of    
 European art" .

:title3 a bf:Title ;
 bf:isTitleOf :w1 ;
 rdfs:label "Avignon brothel"@en ;
 dcterms:hasPart :mainTitleElement3 ;
 bib:hasSource <http://worldcat.org/entity/work/id/56688045> .

:mainTitleElement3 a bib:MainTitleElement ;
 dcterms:isPartOf :title3 ;
 rdfs:label "Avignon brothel"@en .

:title4 a bf:Title ;
 bf:isTitleOf :w1 ;
 rdfs:label "Le Bordel"@fr ;
 dcterms:hasPart :mainTitleElement4, :nonSort2 ;
 bib:hasSource <http://worldcat.org/entity/work/id/3901310255> .

:mainTitleElement4 a bib:MainTitleElement ;
 dcterms:isPartOf :title4 ;
 rdfs:label "Bordel"@fr .

:nonSort4 a bib:NonSortElement ;
 dcterms:isPartOf :title4 ;
 rdfs:label "Le"@fr .

```
> - **Example of title, subtitle and a variant title -- BIBFRAME**
```

:w1 a bf:Work ;
 bf:title :title1, :title2 ;
 bf:hasInstance :Instance1 .


:title1 a bf:Title ;
 rdfs:label "I [love] Venice"@en ;
 bf:mainTitle "I [love] Venice"@en .

:title2 a bf:Title, bf:VariantTitle ;
 rdfs:label "I heart Venice"@en ;
 bf:mainTitle "I heart Venice"@en ;

:instance1 a bf:Instance ;
 bf:IsInstanceOf :w1 ;
 bf:title :title3, title4 .


:title3 a bf:Title ;
 rdfs:label "I [love] Venice : portable pocket ashtray"@en ;
 bf:mainTitle "I [love] Venice"@en ;
 bf:subtitle "portable pocket ashtray"@en ;
 bf:note :note1 .

:title4 a bf:Title, bf:VariantTitle ;
 rdfs:label "I heart Venice : portable pocket ashtray"@en ;
 bf:mainTitle "I heart Venice"@en ;
 bf:subtitle "portable pocket ashtray"@en .

:note1 a bf:note ;
 bf:noteType "title note" ;
 rdfs:label "In title, the word "love" is represented by a heart symbol."

```
> - **Example of title, subtitle and a variant title -- bibliotek-o/ArtFrame**
```

:w1 a bf:Work ;
 bib:hasPreferredTitle :title1 ;
 bf:title :title2 ;
 bf:hasInstance :instance1 .

:title1 a bf:Title ;
 bib:isPreferredTitleOf :w1 ;
 rdfs:label "I [love] Venice"@en ;
 dcterms:hasPart :mainTitleElement1 .


:mainTitleElement1 a bib:MainTitleElement ;
 dcterms:isPartOf :title1 ;
 rdfs:label "I [love] Venice"@en .


:title2 a bfTitle ;
 bf:isTitleOf :w1 ;
 rdfs:label "I heart Venice"@en ;
 dcterms:hasPart :mainTitleElement2 .

:mainTitleElement2 a bib:MainTitleElement ;
 dcterms:isPartOf :title2 ;
 rdfs:label "I heart Venice"@en .

 :instance1 a bf:Instance
 bf:isInstanceOf :w1 ;
 bib:hasPreferredTitle :title3 ;
 bf:title :title4 .
 
:title3 a bf:Title ;
 bib:isPreferredTitleOf :instance1 ;
 rdfs:label "I [love] Venice : portable pocket ashtray"@en ;
 dcterms:hasPart :mainTitleElement3, :subtitle1 ;
 bib:origin :transcribed ;
 bib:isTargetOf :n1 .


:mainTitleElement3 a bib:MainTitleElement ;
 dcterms:isPartOf :title3 ;
 rdfs:label "I [love] Venice"@en .

:subtitle1 a bib:SubTitleElement ;
 dcterms:isPartOf :title3 ;
 rdfs:label "portable pocket ashtray"@en .


:title4 a bf:Title ;
bf:isTitleOf :instance1 ;
 rdfs:label "I heart Venice : portable pocket ashtray"@en ;
 dcterms:hasPart :mainTitleElement4, :subtitle2 .

:mainTitleElement4 a bib:MainTitleElement ;
 dcterms:isPartOf :title2 ;
 rdfs:label "I heart Venice"@en .

:subtitle2 a bib:SubTitleElement ;
 dcterms:isPartOf :title2 ;
 rdfs:label "portable pocket ashtray"@en .

:n1 a oa:Annotation ;
 oa:hasTarget :title3 ;
 oa:motivatedBy oa:describing ;
 oa:hasBody :body1 .

:body1 a oa:TextualBody, a bf:Note ;
 rdfs:label “In title, the word "love" is   
 represented by a heart symbol.” .

> - **Example of multiple subtitles -- BIBFRAME**
```
:w1 a bf:Work ;
 bf:title :title1 ;
 bf:hasInstance :Instance1 .

:title1 a bf:Title ;
 rdfs:label "New York City"@en ;
 bf:mainTitle "New York City"@en .

:instance1 a bf:Instance ;
 bf:IsInstanceOf :w1 ;
 bf:title :title2.

:title2 a bf:Title ;
 rdfs:label "New York City : Newspaper Row on an Election Night : Announcing the Returns"@en ;
 bf:mainTitle "New York City"@en ;
 bf:subtitle "Newspaper Row on an Election  
 Night"@en ; “Announcing the Returns"@en .

```
> - **Example of multiple subtitles -- bibliotek-o/ArtFrame**
```
:w1 a bf:Work ;
 bib:hasPreferredTitle :title1 ;
 bf:hasInstance :instance .

:title1 a bf:Title ;
 bib:isPreferredTitleOf:w1 ;
 rdfs:label "New York City"@en  ;
 dcterms:hasPart:mainTitleElement1 .

:mainTitleElement1 a bib:MainTitleElement ;
 dcterms:isPartOf :title1 ;
 rdfs:label ""New York City"@en .

:instance1 a bf:Instance
 bf:isInstanceOf :w1 ;
 bib:hasPreferredTitle :title2 .

:title2 a bf:Title ;
 bib:isPreferredTitleOf :instance1 ;
 rdfs:label "New York City : Newspaper Row 
 on an Election Night : Announcing the 
 Returns ;
 dcterms:hasPart :mainTitleElement2, :subtitle1, :subtitle2 ;
 bib:origin :transcribed .

:mainTitleElement2 a bib:MainTitleElement ;
 dcterms:isPartOf :title2 ;
 rdfs:label "New York City"@en ;
 vivo:rank 1 .

:subtitle1 a bib:SubtitleElement ;
 rdfs:label “Newspaper Row on an Election Night”@en ;
 vivo:rank 2 .    
 
:subtitle2 a bib:SubtitleElement ;
 rdfs:label “Announcing the Returns”@en ;
 vivo:rank 3 .

```
