Notes in Art Cataloging 
======================
LD4P ArtFrame, 2018-03-27

**Table of Contents**
> - [Sources and Related Pattern Documents](#sources)
> - [Background](#background)
> - [Notes in BIBFRAME](#bibframe)
> - [Recommendations for Moving Forward with ArtFrame](#recommendations)
> - [Recommended Classes](#classes)
> - [Recommended Properties](#properties)
> - [Diagrams](#diagrams)
> - [RDF Samples](#samples)

<a name="sources">Sources and Related Pattern Documents</a>
---------

- [*bibliotek-o Notes & Annotations Pattern*](https://wiki.duraspace.org/display/LD4P/bibliotek-o?preview=/79795231/83237329/bibliotek-o_pattern_notes_annotations_201612.pdf
)
- [*BIBFRAME 2.0 Specifications: Notes*](https://www.loc.gov/bibframe/docs/pdf/bf2-notes-june2016.pdf)
- [*RareMat Limitation Statement Model*](https://github.com/LD4P/ArtFrame-RareMat/blob/master/modeling_recommendations/limitation_statements.md)
- [*RareMat Bindings Model*](https://github.com/LD4P/ArtFrame-RareMat/blob/master/modeling_recommendations/bindings.md#rdf)

<a name="background">Background</a>
---------

Notes are ubiquitous in traditional cataloging. Art cataloging is no exception. Existing content standards direct the cataloger to record a wide array of information in free text notes, structured notes, or note-like elements. Much of that practice will need to be reviewed going forward and converted as much as possible into more linked-data friendly practices. Structured listings, such as performer notes, are a case in point. However, there will always be some information that cannot be recorded in any other way than using a note.
CCO--Cataloging Cultural Objects states “Some institutions may require additional element-specific free-text notes to explain or qualify information in a number of particular elements throughout the Work Record—a Subject Note, Date Note, or Title Note, for example. These are useful because they can contain the nuances of language necessary to convey
uncertainty and ambiguity that cannot otherwise easily be captured in controlled
fields within any single element.” This use case will remain in a linked data environment.

The LD4P Team involved in the development of [*bibliotek-o*](https://bibliotek-o.org/1.1/ontology.html), an ontology developed to show some alternative modeling of BIBFRAME concepts, experimented by using the [*Web Annotation model*](https://www.w3.org/TR/annotation-model/) to record note and note-like information in one consistent format. Inspired by [*Princeton’s Derrida Archive Project*](https://wiki.duraspace.org/display/LD4P/Princeton+-+Project+Updates), where the Web Annotation model was used to encode physical inscriptions on the items, the bibliotek-o developers suggested that cataloger supplied notes could be interpreted as annotations in line with the Web Annotation model. However, this approach was eventually abandoned in favor of interoperability with BIBFRAME as developed by the Library of Congress.

<a name="bibframe">Notes in BIBFRAME</a>
---------

The paper [*BIBFRAME 2.0 Specifications: Notes*](https://www.loc.gov/bibframe/docs/pdf/bf2-notes-june2016.pdf) (issued June 2016) outlines very succinctly the way that notes are handled in BIBFRAME. BIBFRAME includes a number of properties that are used to record note-like information, such as bf:credits, bf:awards, bf:contentAccessibility, or  bf:natureOfContent just to name a few. These are referred to as informal notes. Formal notes are expressed though the class bf:Note and the object property bf:note. If a specific type of note needs to be expressed, then this can be done through a literal using the datatype property bf:noteType or through an external class. However, since no formal domain or range is declared for bf:note, this property can be used with any relevant node, thus the type of note can be inferred from its context making the use of bf:noteType unnecessary in these instances.

<a name="recommendations">Recommendations for Moving Forward with ArtFrame</a>
---------

The ArtFrame group analyzed a number of content standards used in the library and art domains, such as RDA, CCO,  or DCRM(G) to identify commonly used notes in art cataloging. The group went through this list of notes and found that many of them were available as “informal note” properties in BIBFRAME. Many other art related concept have now been modeled within the ArtFrame/RareMat extension ontology thus the note can be attached to the appropriate node and the note type is therefore implied. Only a handful of additional notes were left where the group felt that a different note type would need be specifically expressed. Rather than using the datatype property bf:noteType, the ArtFrame group decided to provide a level of standardization by modeling them as external subclasses of bf:Note. The proposed subclasses of bf:Note may also be used in the context of specific nodes to provide more precision.
- PreferredCitation
- [DescriptiveNote](https://github.com/LD4P/ArtFrame-RareMat/blob/master/modeling_recommendations/bindings.md#rdf) (see Bindings model)
- [LimitationNote](https://github.com/LD4P/ArtFrame-RareMat/blob/master/modeling_recommendations/limitation_statements.md) (see Limitation Statement Model)
- InaccuracyNote
- CaptionNote
- RelatedMaterialNote
- SubjectNote

<a name="classes">Recommended Classes</a>
---------

**bf:Note**
> - **Label:** Note
> - **IRI:** [*http://id.loc.gov/ontologies/bibframe/Note*](http://id.loc.gov/ontologies/bibframe/Note)
> - **Definition:** Information, usually in textual form, on attributes of a resource or some aspect of a resource.

**ex:CaptionNote**
> - **Label:** Caption note
> - **IRI:** TBD
> - **Definition:** A distinctive caption independent of the resource title, including mottos and headings.
> - **Comment:** Use separate notes for multiple captions.
> - **Subclass of:** bf:Note

**ex:LimitationNote**
> - **Label:** Limitation note
> - **IRI:** TBD
> - **Definition:** A note relating to the size and nature of a print run limited to a specific quantity of copies produced, or a statement relating to the enumeration and nature of a copy in relation to the larger print run.
> - **Subclass of:** bf:Note

**ex:InaccuracyNote**
> - **Label:** Inaccuracy note
> - **IRI:** TBD
> - **Definition:** A note explaining an unintentional or intentional inaccuracy, misspelling, or misprint relating to a specific resource. 
> - **Comment:** For multiple inaccuracies use separate notes.
> - **Subclass of:** bf:Note

**ex:PreferredCitation**
> - **Label:** Preferred citation
> - **IRI:** TBD
> - **Definition:** DA note providing a specific citation format for citing the resource.
> - **Subclass of:** bf:Note

**ex:RelatedMaterialNote**
> - **Label:** Related material note
> - **IRI:** TBD
> - **Definition:** A note providing information on materials (e.g. archival materials or publications) related to the described resource.
> - **Scope note:** Use if information describing the related material cannot be parsed into the appropriate relationship.
> - **Subclass of:** bf:Note

**ex:SubjectNote**
> - **Label:** Subject note
> - **IRI:** TBD
> - **Definition:** Textual information describing the subject or iconographic details of a resource.
> - **Scope note:** Use for textual notes only, not for subject terms from a controlled value vocabulary.
> - **Subclass of:** bf:Note

<a name="properties">Recommended Properties</a>
---------

**bf:note** (Object property)
> - **Label:** Note
> - **IRI:** [*http://id.loc.gov/ontologies/bibframe/note*](http://id.loc.gov/ontologies/bibframe/note)
> - **Definition:** General textual information relating to a resource, such as Information about a specific copy of a resource or information about a particular attribute of a resource.
> - **Range:** bf:Note
> - *Comment:** Used with Unspecified

<a name="diagrams">Diagrams</a>
---------


![subject notes](/modeling_recommendations/modeling_diagrams/note_subject.png)
**Descriptive note**
![descriptive notes](/modeling_recommendations/modeling_diagrams/note_descriptive.png)


<a name="samples">RDF Samples</a>
---------
**Descriptive note specifying information about the label**
```
:item a bf:Item ;
    ex:markedBy :marking .

:marking a ex:Label ;
     bf:note :note1 .

:note1 a ex:DescriptiveNote ;
     rdf:value "Two labels that were once affixed to the back and have now fallen off. One is 
     an identifying label and the other is a xerox copy of a 1947 Boston Post news article
     about the life and work of Norman Ritchie."
```

**Subject note**
```
:work a bf:Work ;
    bf:note :note1 .

:note1 a ex:SubjectNote ;
    rdf:value "Two head-and-shoulder portraits in separate ornamental oval frames, one frame 
    held by eagle. "

```
