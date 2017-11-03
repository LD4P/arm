Fonts, Handwriting Types, and Notations  
=========
RareMat, 2017.11.03

Overview
==============
In rare material cataloging the capture of information about writing systems, font, and handwriting types is critical for describing important traits of resources in library and archive collections. BIBFRAME (BF) provides a foundation for rare material descriptive needs in these areas; the following recommendations for changes and extensions to BIBFRAME are meant to better provision for rare material cataloging.

Summary of recommendations:
==============
- Define classes Font, Typeface, FontStyle, and HandwritingType
- Define predicates writtenIn, hasTypeface, hasFontStyle, and hasHandwritingType
- Eliminate class bf:FontSize and predicate bf:fontSize.
- Define a set of named individuals to represent typefaces, or use an external controlled vocabulary if one exists. This is not a closed set, since new typefaces can be created.
- Define a set of named individuals to represent font styles, or use an external controlled vocabulary if one exists.
- Remove “typescript” from existing notation-related definitions.
- Change “alphabet” in notation-related definitions to “writing system,” since this encompasses non-alphabetic writing systems (syllabaries and logographies).
- Define a set of named individuals to represent handwriting types, or use an external controlled vocabulary if one is suitable. Note: Getty AAT has a portion of their thesaurus devoted to scripts by form. This is not a closed set, since new typefaces can be created or discovered.

Relevant BF terms
----------
**Classes**

**bf:Notation**
> - **rdfs:label**: Notation
> - **Skos:definition**:Information on the alphabet, script, or symbol system used to convey the content of the resource, including specialized scripts, typefaces, tactile notation, movement notation, and musical notation.
notation.
> - **Subclasses:** MovementNotation, MusicNotation, Script, TactileNotation

**bf:MovementNotation**
> - **rdfs:label**: Movement notation used
> - **Skos:definition**: Information on the symbol system used to convey the content of a movement resource.
> - **Superclass**: bf:Notation

**bf:MusicNotation**
> - **rdfs:label**: Music notation used
> - **Skos:definition**: Information on the symbol system used to convey the content of a music resource.
> - **Superclass**: bf:Notation

**bf:Script**
> - **rdfs:label**: Script used
> - **Skos:definition**: Information on the script, or symbol system used to convey the content of a text resource.
> - **Superclass**: bf:Notation

**bf:TactileNotation**
> - **rdfs:label**: Tactile notation used
> - **Skos:definition**:Information on the symbol system used to convey the content of a tactile resource.
> - **Superclass**: bf:Notation

**bf:FontSize**
> - **rdfs:label**: Font size
> - **Skos:definition**: Size of the type used to represent the characters and symbols in a resource.

**Predicates**

**bf:fontSize**
> - **rdfs:label**: Font size
> - **Skos:definition**: Size of the type used to represent the characters and symbols in a resource.
> - **Domain**: Instance
> - **Range**: bf:Notation

**bf:notation**
> - **rdfs:label**: Notation system
> - **Skos:definition**: Alphabet, script, or symbol system used to convey the content of the resource, including specialized scripts, typefaces, tactile notation, movement notation, and musical notation.
> - **Range**: bf:Notation
> - **Used with**: Work or Instance

Discussion
======

**Fonts**
BF is right to separate font from the other types of “notation,” since font refers to the style in which symbols are printed rather than to the symbol systems themselves. However, typeface is semantically related more to font size than to these symbol systems. Further, it is hard to understand why BF models only font size and not the other properties of a font - typeface and style.

Conventional definitions from the publishing world

nerdplusart.com/type-terminology-smackdown/
A typeface is a family of fonts (very often by the same designer). Within a typeface there will be fonts of varying weights or other variations. E.g., light, bold, semi-bold, condensed, italic, etc. Each such variation is a different font.


http://smad.jmu.edu/shen/webtype/facefontfamily.html
A font is the digital representation of a typeface. It is a collection of all the characters of a typeface in one size (12pt/1in) and one style (bold/italic). For example, Arial in 12pt size is a font, Arial in 18pt size is a font, and Arial bold in 24pt is also a font. Adobe's type glossary lists a font as “one weight, width, and style of a typeface.”

**Handwriting Types**

bf:Script is about the symbol system, but there is no way in BF to note a type of writing hand for handwritten manuscripts and other textual materials, e.g. English secretary hand, or Carolingian script.

http://rbms.info/files/dcrm/dcrmmss/DCRMMSS.pdf 
Descriptive Cataloging of Rare Materials (Manuscripts) instructs to capture information about the handwriting type if considered important for describing the resource. Using the term Script, this information is described as, “A type of writing hand; not the same as a writing system or a handwriting style (such as cursive or block letters). Gothic, Secretary, Carolingian minuscule, and Sütterlin are examples of scripts. See also Writing system.”

Proposal
===========

Font
==========
Following the usage described above, we propose a Font class to describe all font properties of a resource (or part of a resource), including typeface (e.g., Courier, Arial), size, and style (e.g., bold, italics). We propose a class Typeface with named individuals from a typeface vocabulary, and a class FontStyle with named individuals from a controlled font style vocabulary. We propose using the Measurement model to describe size as detailed below. 

We propose predicates :writtenIn to relate a bibliographic resource (most likely Instance or Item) to a Font, and predicates hasTypeface, hasStyle to relate a Font instance to its Typeface and FontStyle. Predicates from the Measurement model would be used to model font size.

Diagram
---------
Note that different multiple sample namespaces are shown; some may end up being the same. 
![Font Diagram](/modeling_recommendations/modeling_diagrams/font.png)

RDF Sample
---------

```
:it a :bf:Item ;
  :writtenIn :fnt .

:fnt a ex:Font ;
  :hasTypeface :courier ;
  :hasStyle :bold , :italics ,
  :hasMeasurement :meas .

:meas a ex:Measurement ;
  rdfs:label “11 point” ;
  ex:hasUnit :point ;
  rdf:value “11” .


# Named individuals defined in the ontology or other controlled vocabulary

:courier a owl:NamedIndividual, ex:Typeface .
:bold a owl:NamedIndividual, ex:Style .
:italics a owl:NamedIndividual, ex:Style .
```


Handwriting Type
==============
Because BF seems to currently conceive of instances of bf:Script as reuseable objects outside of a specific work’s use of a bf:Script, the current proposal does not recommend linking handwriting type information directly off from instances of bf:Script as if the individual of bf:Script was a particular use of a script. 

An easier addition to the BF model would be to have a property like :hasHandwritingType directly off the bf:Instance or bf:Item and follow a very similar pattern as the Font pattern described above. The shortcoming of this is that there would be no obvious way of linking the :HandwritingType to the bf:Script, but currently cataloging practice does not aspire to this level of specificity and could be defined as future work if use cases called for it.

We propose reusing the writtenIn predicate to relate a bibliographic resource (most likely Instance or Item) to a particular example of Handwriting. We also recommend the predicate hasHandwritingType to relate a Handwriting instance to its HandwritingType, and dcterms:description to further describe the particular Handwriting and use of a HandwritingType. Note that writtenIn is reused from the Font pattern above. Predicates from the Measurement model could also be used to model handwriting size if deemed important to capture.

Diagram
---------
![Handwriting Type Diagram](/modeling_recommendations/modeling_diagrams/handwriting.png)

RDF Sample
---------
```
:it a :bf:Item ;
  ex:hasNotation :latin ;
  ex:writtenIn :HandWriting1 .

:Handwriting1 :hasHandwritingType :frenchGothicBookhand ;
  dcterms:description “French Gothic bookhand in university style (littera parisiensis)” .

:latin a owl:NamedIndividual, bf:Script .
:frenchGothicBookhand a owl:NamedIndividual, ex:HandwritingType .
:cursive a owl:NamedIndividual, :Style .
```

Classes
---------
**Font**
> - **rdfs:label**: Font
> - **Skos:definition**: A font is the digital representation of a typeface. It is a collection of all the characters of a typeface in one size (12pt/1in) and one style (bold/italic). For example, Arial in 12pt size is a font, Arial in 18pt size is a font, and Arial bold in 24pt is also a font.
> - **Superclass**:

**FontStyle**
> - **rdfs:label**: Font style
> - **Skos:definition**: Style of the font, e.g. bold, italic 
> - **Superclass**:

**Typeface**
> - **rdfs:label**: Typeface
> - **Skos:definition**: A design or “font family” created by a typographer or type designer. It defines specific stylistic features to determine the type display of a writing system.
> - **skos:editorialNote**: BIBFRAME uses bf:Script to refer to writing systems 
> - **Superclass**:

**Handwriting**
> - **rdfs:label**: Handwriting
> - **Skos:definition**: A specific example of a handwriting found in a textual resource. A handwriting can have a particular HandWritingType.
> - **Superclass**:

**HandwritingType**
> - **rdfs:label**: Handwriting type
> - **Skos:definition**: A type of writing hand; not the same as a writing system or a handwriting style (such as cursive or block letters). Examples include Gothic, Secretary, Carolingian minuscule, and Sütterlin. 
> - **Superclass**:


Predicates
---------
**writtenIn**
> - **rdfs:label**: Written in
> - **Skos:definition**: The relationship between a resource containing text and the Font or HandWriting the textual information is displayed in.
> - **skos:editorialNote**: Use with BF Instance or Item

**hasTypeface**
> - **rdfs:label**: Has typeface
> - **Skos:definition**: A relationship between a Font and its design or “font family”
> - **Domain**: Font
> - **Range**: Typeface

**hasFontStyle**
> - **rdfs:label**: Has font style
> - **Skos:definition**: A relationship between a Font and the style of the font used, e.g. bold, italic 
> - **Domain**: Font
> - **Range**: FontStyle

**hasHandwritingType**
> - **rdfs:label**: Has handwriting type
> - **Skos:definition**: A relationship between a resource that includes handwriting and the type of writing hand, e.g. Gothic, Secretary, Carolingian minuscule, and Sütterlin. 
> - **Range**: HandwritingType
> - **skos:editorialNote**: Use on a :Handwriting

Areas for future research - beyond present scope
=================
- Consider the relationship between Writing Systems (bf:Scripts), styles of writing (:Fonts and :HandWritingTypes) and Languages. 
- If the use case arises for the need to know which fonts and handwriting types were used with which bf:Scripts, consider modeling that would reflect these relationships in a particular case.
- Ask community for better label/naming for :writtenIn.
- Other notation subtypes, such as mathematical, chemical, and logical symbol systems.

