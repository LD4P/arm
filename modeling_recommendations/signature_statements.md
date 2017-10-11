Signature Statement Model
=============
RareMat, 2017-10-10

Overview
--------
Signature statements in bibliographic records play an important role, as these statements provide a way to compare the book in hand with another for establishing completeness of a particular title and/or edition.  Because books from the hand-press period were printed on large sheets of paper with several pages on each side, which were later folded to make groups of leaves, it was necessary to find a way to identify the correct order when assembling these sheets.  To this end, each sheet on the first page was signed with a letter of the alphabet.  To record these signatures, a statement notating the details of how the book was constructed is utilized according to a standardized formula (see Philip Gaskell’s *A New Introduction to Bibliography*, p. 328-332).
 
Groups of leaves sewn together are known as gatherings, and each gathering consists of one or more pairs of leaves made from one folded sheet, or from several folded sheets tucked inside another (“quire”).  Each gathering is then identified by means of a signature.  A signature may be represented by a letter, numeral, symbol, or a group of such characters, and signatures are printed at the foot of the rectos of the first few leaves of a gathering for the purpose of aiding binders in correctly assembling the gatherings (see *Descriptive Cataloging of Rare Materials (Books)*, p. 201).

The precise form of the signatures varied from time to time and region to region.  However, the most common signatures used 23 letters of the Latin alphabet (A to Z, with the exception of I or J, U or V, and W), a convention derived from the manuscript period.  The alphabets are expressed with superscript numbers to indicate the total of conjugate quired leaves in a gathering, which could also help determine the book format (e.g., folio, quarto, octavo, duodecimo, etc.).  Hence, an ideal copy with a signature statement,

A-Z<sup>4</sup>

means that 23 sheets of paper were each folded twice to make 23 gatherings of four leaves, and each gathering is signed in alphabetical order from A to Z (less I or J, U or V, and W).  Gatherings exceeding 23 letters of the Latin alphabet were expressed with duplicated alphabets (e.g., AA, Aa, aa, BB, Bb, bb, and so on).
 
Some gatherings were signed with arbitrary marks and symbols (especially for preliminary leaves, which sometimes were not signed at all), such as paragraph marks, asterisks, contraction signs, daggers, stars, etc., and such marks and symbols that cannot be duplicated in the statement are expressed in words inside brackets:
> - &<sup>2</sup> [dagger]<sup>2</sup> A-Z<sup>4</sup>

Some gatherings were signed using a pattern other than the conventional 23-letter Latin alphabets (e.g., including the letters I, J, U, V, or W).  The additional letters must be explicitly recorded in the signature statement:
> - A-V<sup>4</sup> W<sup>4</sup> X-Z<sup>4</sup>
> - A-I<sup>8</sup> J<sup>8</sup> K-U<sup>8</sup> V<sup>8</sup> W<sup>8</sup> X-2I<sup>8</sup> 2J<sup>8</sup> 2K-2M<sup>8</sup>

However, signature statements are not usually this straightforward and present various challenges and complexities.  For instance, the convention for recording non-roman signatures varies depending on whether the signatures involve a numeric sequence, alphabetic characters accompanied by parallel numeration using another script, or alphabetic sequence with varying total number of letters.  Some complexities involve mis-signed leaves, signatures not matching the gatherings, concurrent signatures, etc.:
> - ʼ-sh<sup>8</sup>
> - А-Ѵ<sup>2</sup> [=41], 2А-2Ѵ<sup>2</sup> [=41], 3А-3Ѿ<sup>2</sup> [=24]
> - [1]<sup>8</sup> 2-3<sup>8</sup>; volume actually gathered in twelves
> - 1-12<sup>12</sup> and A-S<sup>8</sup>; actual gatherings cannot be determined
> - A-Y<sup>6</sup> 2A-2N<sup>6</sup> 2O-2P<sup>4</sup> AA<sup>6</sup> BB-YY<sup>4</sup> 3A-3H<sup>4</sup> [$4 (+2F5, 2G5, 2H5, 2K5, 2L5, 2M5, 2N5, AA5; -II4) signed]. 2E1 mis-signed E1; 3A4 mis-signed 2A4; 3B2 mis-signed BB2

Other complexities involve insertions and cancellations.  Errors discovered after a sheet had been printed were corrected in various ways.  Most often, the simplest and cheapest way was to cancel and replace individual leaves (recorded with a plus and minus sign), and sometimes a single disjunct leaf may be inserted (recorded with a plus sign), all of which cause abnormal gatherings:
> - A-B<sup>4</sup> C<sup>4</sup>(±C3) D-K<sup>4</sup>
> - A-C<sup>4</sup> (C4 + chi1) D-K<sup>4</sup>
 
In many cases, a signature statement is recorded as part of full collation in order to provide clarity:
 
> - 8vo: A-H<sup>4</sup> ; 32 leaves: p. [1-2] 3-62 [63-64]; $3(−H3) signed. H4 blank
> - 4to: A-Z<sup>4</sup> [$3 signed (+B4, K4; −L2, P3, Y2, 3; A2 signed A3)]
 
The amount of details and technical references to include in the statement varies.  Although signature statements are recorded based on an ideal copy, it is not uncommon for two copies in hand with same title and edition to result in different signature statements due to some of the complexities outlined above, among others.
Recommendation
 
BIBFRAME currently does not have a term for signature statements.  Hence, the Rare Materials Ontology Extension Group recommends creating an object property and class, alongside reusing dcterms:description to allow for expansion about the signature statement.
 
Term Specifications
--------

Involved Properties
--------
**ex:hasSignatureStatement**
> - **Label**: has signature statement
> - **IRI**: TBD
> - **Range**: ex:SignatureStatement
> - **Definition**: Relationship between a Resource and a signature statement.

**dcterms:description**
> - **Label**: Description
> - **IRI**: http://purl.org/dc/terms/description
> - **Definition**: An account of the resource. 
> - **Comment**: Description may include but is not limited to: an abstract, a table of contents, a graphical representation, or a free-text account of the resource.

Involved Classes
--------
**ex:SignatureStatement**
> - **Label**: Signature statement
> - **IRI**: TBD
> - **Definition**: A formulaic statement describing the pattern followed in assembling the sheets of the book, as expressed in its signatures. Signatures are letters, numerals, symbols, or a group of such characters printed at the foot of the rectos of the first few leaves of each gathering (quire) to aid the binder in correctly assembling the sections. 


Diagram
--------
![Signature Statement Diagram](/modeling_recommendations/modeling_diagrams/signature_statement.png)

RDF Sample
--------
```
:instance1 ex:hasSignatureStatement :signatureStatement1 .

:signatureStatement1 a ex:SignatureStatement ;
    rdf:value “1-12¹² and A-S⁸” ;
    dcterms:description “Actual gatherings cannot be determined” .
```

And/or:

```
:item1 ex:hasSignatureStatement :signatureStatement1 .

:signatureStatement1 a ex:SignatureStatement ;
    rdf:value “1-12¹² and A-S⁸” ;
    dcterms:description “Actual gatherings cannot be determined” .
```
