Limitation Statement Model
====================
RareMat, 2018.01.19

Overview
----------
Limitation statements describe the limited production size and nature of a print run. Limitation statements can be applied to any limited manufacture run of books, recordings, magazines, etc, as well as for documents traditionally produced at a smaller scale (e.g. prints, artists’ books, fine prints, etc.). Limitation statements are often found in modern materials, but can be present in materials as early as the 15th century.

Limitation statements generally give the total number of copies printed, and often describe how copies within the run are enumerated (for example, numerically (e.g., 1-250) or alphabetically (e.g. A-N)), as well as the types of proofs present in the print run (e.g., artist’s proofs, studio copies, not for trade proofs, etc.). Limitation statements can also give further details about more granular ways the print run has been numbered (e.g., 250 copies, 50 of which have been signed by the author).   

Limitation statements usually have two components: the limitation statement relating to the entire instance, and the enumeration of the individual item. Either piece can exist without the other, but when present, both should be represented bibliographically in order to provide the greatest amount of information about the resource. 

Limitation statements are important to researchers because they are a clear indication about the scarcity of an instance, and can give details about the production and distribution of a resource. The copy’s numbering, for its part, can provide specific details about a given item, such as whether it was one of the numbered copies that was issued with an additional print, or whether it was a copy that was distributed among the author’s friends rather than sold. 

Because limitation statements are capturing string values, rather than creating a distinct predicate, the proposal is to create a subclass of bf:Note, http://example.org/LimitationNote.

Term Specifications
-------------------

**Class**

**ex:LimitationNote**
> - **Label:** Limitation note
> - **Definition:** A note relating to the size and nature of a print run limited to a specific quantity of copies produced, or a statement relating to the enumeration and nature of a copy in relation to the larger print run.
> - **Subclass of:** bf:Note

Sample data
-----------
"350 copies of this book have been designed and printed by Sebastian Carter at the Rampant Lions Press ... hand-set in Hunt Roman, and ... Monotype Plantin Light with Monotype Albertus for the title. The paper is Zerkall mould-made wove. 50 have been signed by Ronald Blythe, include an additional set of prints from the five blocks and are specially bound. Both bindings are by the Fine Bindery, Wellingborough"--Colophon.

Library’s copy numbered A.P. II

Limited edition of 100 numbered copies, signed by the author. Library's copy is no. 80.

Varied edition of 40 numbered copies plus 1 legal deposit proof.
Copy 1 numbered : 11/40, signed by the artist under the platemark.
Copy 2 numbered : D.L. I/I, signed by the artist under the platemark. 

Diagrams
----------------
Ex. 1

![Limitation Statement diagram ex1](/modeling_recommendations/modeling_diagrams/limitation_statement_1.png)

Ex. 2

![Limitation Statement diagram ex2](/modeling_recommendations/modeling_diagrams/limitation_statement_2.png)

Ex. 3

![Limitation Statement diagram ex3](/modeling_recommendations/modeling_diagrams/limitation_statement_3.png)

Ex. 4

![Limitation Statement diagram ex4](/modeling_recommendations/modeling_diagrams/limitation_statement_4.png)

RDF sample
------------
Ex. 1
```
:instance1 a bf:Instance ; bf:note :note1 .
:note1 a ex:LimitationNote ; rdf:value “\"350 copies of this book have been designed and printed by Sebastian Carter at the Rampant Lions Press ... hand-set in Hunt Roman, and ... Monotype Plantin Light with Monotype Albertus for the title. The paper is Zerkall mould-made wove. 50 have been signed by Ronald Blythe, include an additional set of prints from the five blocks and are specially bound. Both bindings are by the Fine Bindery, Wellingborough\"--Colophon.” .

```
Ex. 2
```
:item1 a bf:Item ; bf:note :note2 .
:note2 a ex:LimitationNote ; rdf:value “Library’s copy numbered A.P. II” .
```
Ex. 3
```
:instance1 a bf:Instance ; bf:note :note3 .
:note3 a ex:LimitationNote ; rdf:value “Limited edition of 100 numbered copies, signed by the author.”  .
:instance1 bf:hasItem :item1 .

:item1 a bf:Item ; bf:note :note4 .
:note4 a ex:LimitationNote ; rdf:value “Library's copy is no. 80.” .
```
Ex. 4
```
:instance1 a bf:Instance ; bf:note :note5 .
:note5 a ex:LimitationNote ; rdf:value “Varied edition of 40 numbered copies plus 1 legal deposit proof.” .
:instance1 bf:hasItem :item1 , :item2 .

:item1 a bf:Item ; bf:note :note6 .
:note6 a ex:LimitationNote ; rdf:value “Copy 1 numbered : 11/40, signed by the artist under the platemark.” .

:item2 a bf:Item ; bf:note :note7 .
:note7 a ex:LimitationNote ; rdf:value “Copy 2 numbered : D.L. I/I, signed by the artist under the platemark.” .
```
