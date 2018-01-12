Pagination and Foliation Model
============
RareMat, 2017-12-12

Overview
---------
In descriptive cataloging of rare materials, recording a precise, detailed physical description of pagination and/or foliation is considered important, since providing this type of description supplements the information recorded in extent and often elaborates on anomalies or errors. A detailed pagination and/or foliation information can also help to distinguish one edition from another.

BIBFRAME currently provides bf:extent property to cover this type of information.  This may be sufficient for recording a simple physical description of a unit (e.g., 1 item, 1 item (375 leaves), 11 volumes, etc.).  However, bf:extent provides for use with instance only and is broadly defined as “number and type of units and/or subunits making up a resource.”  This does not fully address the needs of the rare materials cataloging communities (where instructions are provided for describing extent, pagination, and foliation also at the Item level, especially when this information is different from the “ideal” Instance) following the standards of Descriptive Cataloging of Ancient, Medieval, Renaissance, and Early Modern Manuscripts (AMREMM), Descriptive Cataloging of Rare Materials (Manuscripts) (DCRM(MSS)), Descriptive Cataloging of Rare Materials (Books) (DCRM(B)), Descriptive Cataloging of Rare Materials (Cartographic) (DCRM(C)), or Descriptive Cataloging of Rare Materials (Graphics) (DCRM(G)).

Section 5B2 of AMREMM provides that foliation, pagination, or other numeration be recorded in the appropriate part of a note rather than in extent (e.g., 7B7.1(b)).  Sections 7B10.3-7B10.5 of DCRM(MSS) provides that the precise pagination and/or foliation of manuscripts be recorded in a note giving more details to extent if considered important.  Sections 5B7.1 of DCRM(B), 5B8.1 of DCRM(C), and H7.4 of DCRM(G) also provide that the details on the pagination and/or foliation be recorded in notes rather than in extent.

Recommendation
-------------
The Sample Data section below provides numerous pagination and foliation examples that provide fuller details of the extent, which currently cannot be accommodated fully by bf:extent/Extent, bf:unit/Unit, bf:count. The pagination and foliation requires understanding the sequence of various counts of pages, foliation, etc., and while one option is to turn each count into a bf:Unit, there is currently no way to order the various bf:Units and unlikely that it would be sustainable to maintain these a separate resources.

If not using separate bf:Unit resources to capture information (and rather than introducing a new datatype property for pagination and foliation), creating :PagintationFoliation as a subclass of bf:Extent allows the property query path to remain the same as the more general bf:Extent pattern, while still saying this particular extent is speaking specifically to the pagination and foliation of a bibliographic resource.

The Rare Materials Ontology Group recommends using/creating the following Classes and Properties to allow for expansion on the details of pagination and foliation.

Request to LC
--------------
> -	Open up the domain of bf:extent so that extents that may very from the “ideal Instance” can be captured on bf:Items.
> -	Create bf:PaginationFoliation as a subclass of bf:Extent.

Term Specifications
-------------------

Involved Classes
---------------
**bf:Extent**
> - **Label:** Extent
> - **IRI:** http://id.loc.gov/ontologies/bibframe/Extent
> - **Definition:** Number and type of units and/or subunits making up a resource.

**ex:PaginationFoliation**
> - **Label: Pagination foliation
> - **IRI: TBD
> - **Subclass of: http://id.loc.gov/ontologies/bibframe/Extent
> - **Definition: Sequential numbering of individual leaves, plates, pages (numbering on both sides), or columns (used as a sequence of numbering) of a resource.

Involved Properties
------------------
**bf:extent**
> - **Label:** Extent
> - **IRI:** http://id.loc.gov/ontologies/bibframe/extent
> - **Domain:** http://id.loc.gov/ontologies/bibframe/Instance (see requests to LC section about opening this)
> - **Range:** http://id.loc.gov/ontologies/bibframe/Extent 
> - **Definition:** Number and type of units and/or subunits making up a resource.

**dcterms:description**
> - **Label:** Description
> - **IRI:** http://purl.org/dc/terms/description
> - **Definition:** An account of the resource. 
> - **Comment:** Description may include but is not limited to: an abstract, a table of contents, a graphical representation, or a free-text account of the resource.

Sample Data
-----------
[13], CCCI leaves (leaves [1], [12-13] blank)
Errors in foliation: leaves v, x, Cxliiij, Cxlix, CCxlix, CClxxvij misnumbered vij, v, Cxlv, Clxxi, CClxix, CClxxvi respectively.

2 volumes ([20], 907, [29]; [8], 196, [16], 89, [3] pages, 64 leaves, [2], 67-116, [4] pages, 273 columns, [3] pages, [2] folded leaves of plates)
Error in foliation, tome 2: Leaf 2 numbered 3; Errors in pagination, tome 2: Pages 73-74, 79-80, 8th sequence, numbered 72-73, 78-79 respectively.

2 v. in 1 ([2], 217, [1], 110, [12] leaves)
Errors in foliation: first grouping: 12 unnumbered; 61 as 51; 86 as 80; 154 repeated; 157 as 156; 196 as 194; 210 as 201; no leaf numbered 215. Second grouping: 13 as 7; 31 unnumbered; 73 as 74; 95 as 98.

[16], 218, [26], 36, [8], 64 p., [2] leaves of plates
Compilation of three works.
Pagination of first work: [16], 218, [22] pages, [2] leaves of plates. 
Pagination of second work: [4], 36 pages; page 4 (leaf a4 verso) misnumbered 2, pages 13-14 (leaf c1) misnumbered 21-22, pages 19-20 (leaf c4) misnumbered 27-28, page 30 (leaf e1 verso) misnumbered 28, and page 35 (leaf e4 recto) misnumbered 21. 
Pagination of third work: [8], 64 pages.

12 prints in 1 volume
Foliation: [14] leaves.

16 photographs and 21 pages of text in one volume
Irregular pagination: ten pages of text titled Antiquities of Cambodia are printed on pages [7] -16; the descriptions of the photographs bear page numbers: 21; 25; 37; 41; 45; 55; 59; 63; 67; and 71.

Diagram
----------
![Pagination and Foliation Diagram](/modeling_recommendations/modeling_diagrams/pagination_foliation_diagram.png)

Sample RDF
----------
```
# Based on the first example in the sample data above. 

:item1 a bf:Item ; bf:extent :extent1 .

:item1 bf:extent :extent1 .

:extent1 a :PaginationFoliation ; 
    rdf:value “[13], CCCI leaves (leaves [1], [12-13] blank)” ;
    dcterms:description “Errors in foliation: leaves v, x, Cxliiij, Cxlix, CCxlix, CClxxvij
        misnumbered vij, v, Cxlv, Clxxi, CClxix, CClxxvi respectively.” .
```

```
# Based on the second example in the sample data above. 

:item2 a bf:Item ; bf:extent :extent2 , :extent3 .

:extent2 a bf:Extent ; 
    rdf:value  “2 volumes” . 

:extent3 a :PaginationFoliation ;
    rdf:value “[20], 907, [29]; [8], 196, [16], 89, [3] pages,
        64 leaves, [2], 67-116, [4] pages, 273 columns, [3] pages, [2] folded leaves of plates” ;
    dcterms:description “Error in foliation, tome 2: Leaf 2 numbered 3; Errors in pagination, tome
        2: Pages 73-74, 79-80, 8th sequence, numbered 72-73, 78-79 respectively.” .
```
```
# Based on the third example in the sample data above. 

:item3 a bf:Item ; bf:extent :extent4 , :extent5 .

:extent4 a bf:Extent ; 
    rdf:value “2 v. in 1” . 

:extent5 a :PaginationFoliation ;
    rdf:value “[2], 217, [1], 110, [12] leaves” ;
    dcterms:description “Errors in foliation: first grouping: 12 unnumbered; 61 as 51; 86 as 80;
        154 repeated; 157 as 156; 196 as 194; 210 as 201; no leaf numbered 215. Second
        grouping: 13 as 7; 31 unnumbered; 73 as 74; 95 as 98.” .
```

Related BIBFRAME Terms
-----------

**Classes**

**bf:Extent**
> - **Label:** Extent
> - **IRI:** http://id.loc.gov/ontologies/bibframe/Extent
> - **Definition:** Number and type of units and/or subunits making up a resource.

**bf:Unit**
> - **Label:** Unit
> - **IRI:** http://id.loc.gov/ontologies/bibframe/Unit
> - **Definition:** Units in which a value is expressed.

**Object Properties**

**bf:extent**
> - **Label:** Extent
> - **IRI:** http://id.loc.gov/ontologies/bibframe/extent
> - **Domain:** http://id.loc.gov/ontologies/bibframe/Instance (see requests to LC section about opening this)
> - **Range:** http://id.loc.gov/ontologies/bibframe/Extent 
> - **Definition:** Number and type of units and/or subunits making up a resource.

**bf:unit**
> - **Label:** Type of unit
> - **IRI:** http://id.loc.gov/ontologies/bibframe/unit
> - **Domain:**
> - **Range:** http://id.loc.gov/ontologies/bibframe/Unit
> - **Definition:** Units in which a value is expressed, such as the physical or logical constituent of a resource (e.g., a volume, audiocassette, film reel, a map, a digital file).

**Data Properties**

**bf:count**
> - **Range:** rdfs:Literal
> - **skos:definition:** Number associated with a measure of units, such as the number of units and/or subunits making up a resource.
