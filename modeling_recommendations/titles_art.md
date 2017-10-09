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
