Carriers and Bound-Withs
=======================
RareMat and ArtFrame, 2018.03.16

Table of Contents
- [Introduction](#intro)
- [Summary of Recommendations](#summary)
- [Sample Data](#sampledata)
- [Part I. The Bound-With Model](#boundWith)
- [Part II. The Carrier Model](#carrier)

<a name="intro">Introduction</a>
--------
In current library systems, describing individual items that share a carrier – and therefore share a call number or other identifier – poses a variety of challenges. In the case of “bound-withs” (also called “composite volumes” or “Sammelbands”/”Sammelbände”), each individual publication that has been bound into the single physical unit is described separately, while information related to the volume as a whole is included in the description of the first item. The RareMaterials/ArtFrame Ontology Extension Group identified the need to describe such resources both individually and as a whole. 

An individual resource in a bound-with may have its own particular custodial history, distinct from the other resources, while the fully bound volume may also have a custodial history that should be noted. Statements about the volume itself, such as binding information and table of contents, should not be attached to a single unit from the volume but to the volume itself. The proposed model allows for such description. This model can be used with resources beyond bound-withs: it can apply to any type of resource that comprises items created or produced separately but later unified into a single physical object, such as scrapbooks or photograph albums.  For published resources, only items that have been bound together subsequent to publication, rather than issued or reissued together by the publisher (omnibus volumes and nonce collections), are covered in this model.  

Not all carriers are considered collections in the way bound-withs are, however. In the case of two paintings on a single sheet, for example, one may wish to describe the individual paintings, but the sheet would not constitute a “collection” and likely does not need its own description.

BIBFRAME bf:carrier/bf:Carrier cannot be applied to our use cases because they are used for instance- rather than item-level description. In addition, bf:carrier indicates the type of carrier (“Categorization reflecting the format of the storage medium and housing of a carrier”), not a relationship between resources on a carrier and the carrier. 

Note that the relationships among the parts of a bound-with or items that share a carrier can be derived from the relationships of the parts to the whole, and it would therefore be redundant to define predicates for the part-part relationships. 


<a name="summary">Summary of Recommendations</a>
-----------
- Use dcterms:isPartOf/dcterms:hasPart to aggregate bound withs and similar collections on a single carrier
- Use seq:follows and seq:precedes predicates to indicate order for bound-withs or other shared-carrier collections in which order is important
- Define the following new properties:
> - ex:isOnCarrier/ex:carries
- Define the following new class:
> - ex:BoundCollection 
- Connect to other recommended models, such as the Marking model, Binding model, and Custodial History model, through both the BoundCollection class and the Items.
- Use P2_hasType from CIDOC-CRM to point to a term from a controlled vocabulary (such as RDA Carriers Scheme) to specify carrier types
- Use bf:tableOfContents and bf:TableOfContents to describe a table of contents included for the volume as a whole, but recommend to LC that the comment on bf:tableOfContents “Used with Work or Instance” be modified so that it is also appropriate for use with bound collections.

<a name="sampledata">Sample Data</a>
--------------
“Bound (3rd) with 5 other titles. Bound with 1st in vol. 10560349 (parent record's identifier).”

“Painting 1 pasted on sheet with painting 2.”

“Later sketch on verso.”

<a name="boundWith">Part I. The Bound-With Model</a>
==================

Summary
-------
Most of the proposed Bound-With model is derived from terms from other ontologies: BIBFRAME, dcterms, and other RareMat/ArtFrame models. The only RareMat-specific terms relate to the BoundCollection class itself and the class hierarchy in which it is positioned.

Areas covered by other ontologies:  
- BIBFRAME: items, identifiers, titles, tables of contents 
> - bf:tableOfContents specifies “Used with Work or Instance.” We use it here with a BoundCollection, which is an Item, and recommend to LC the inclusion of Items in this comment. If LC does not agree with this recommendation, we should find or define other terms.
- dcterms predicates for part/whole relationships.
- Other RareMat / ARTFrame models:
> - <a href="https://github.com/LD4P/ArtFrame-RareMat/blob/master/modeling_recommendations/markings.md">Markings</a>
> - <a href="https://github.com/LD4P/ArtFrame-RareMat/blob/master/modeling_recommendations/bindings.md">Bindings</a>
> - <a href="https://github.com/LD4P/ArtFrame-RareMat/blob/master/modeling_recommendations/custodial_history.md">Custodial history</a>
> - Materials
> - Etc.

Diagram
-------

![Bound-withs diagram](/modeling_recommendations/modeling_diagrams/bound_with.png)

Term Specifications
----------

Classes
-----------
**ex:BoundCollection**
> - **URI:** TBD
> - **Label:** Bound collection
> - **Definition:** An artificial gathering of two or more items physically into or on a single carrier, whether bound, affixed, or otherwise brought together into a single bound unit, and lacking a collective title. Includes only collections gathered subsequent to publication, rather than issued or reissued together by the publisher.

**bf:Item**
> - **URI:** http://id.loc.gov/ontologies/bibframe/Item
> - **Label:** Item
> - **Definition:** Single example of an Instance.

**bf:Instance**
> - **URI:** http://id.loc.gov/ontologies/bibframe/Instance
> - **Label:** Instance
> - **Definition:** Resource reflecting an individual, material embodiment of a Work.

**bf:Identifier**
> - **URI:** http://id.loc.gov/ontologies/bibframe/Identifier
> - **Label:** Identifier
> - **Definition:** Token or name that is associated with a resource, such as a URI or an ISBN.

**bf:Title**
> - **URI:** http://id.loc.gov/ontologies/bibframe/Title
> - **Label:** Title entity
> - **Definition:** Title information relating to a resource: work title, preferred title, instance title, transcribed title, translated title, variant form of title, etc.


Properties
-----------
**dcterms:hasPart**
> - **URI:** http://purl.org/dc/terms/hasPart
> - **Label:** Has Part
> - **Comment:** A related resource that is included either physically or logically in the described resource.
> - **Domain:** unspecified
> - **Range:** unspecified
> - **Inverse:** dcterms:isPartOf

**dcterms:isPartOf**
> - **URI:** http://purl.org/dc/terms/isPartOf
> - **Label:** Is Part Of
> - **Comment:** A related resource in which the described resource is physically or logically included.
> - **Domain:** unspecified
> - **Range:** unspecified
> - **Inverse:** dcterms:hasPart

**seq:precedes**
> - **URI:** http://www.ontologydesignpatterns.org/cp/owl/sequence.owl#precedes
> - **Label:** precedes
> - **Domain:** owl:Thing
> - **Range:** owl:Thing
> - **Comment:** A relation between entities, expressing a 'sequence' schema. E.g. 'year 1999 precedes 2000', 'deciding what coffee to use' precedes 'preparing coffee', 'World War II follows World War I', 'in the Milan to Rome autoroute, Bologna precedes Florence', etc. It can then be used between tasks, processes, time intervals, spatially locate objects, situations, etc. Subproperties can be defined in order to distinguish the different uses.
> - **Inverse:** seq:follows

**seq:directlyPrecedes**
> - **URI:** http://www.ontologydesignpatterns.org/cp/owl/sequence.owl#directlyPrecedes
> - **Label:** directly precedes
> - **Domain:** owl:Thing
> - **Range:** owl:Thing
> - **Comment:** The intransitive precedes relation. For example, Monday directly precedes Tuesday. Directness of precedence depends on the designer conceptualization.
> - **Inverse:** seq:directlyFollows

**seq:follows**
> - **URI:** http://www.ontologydesignpatterns.org/cp/owl/sequence.owl#follows
> - **Label:** follows
> - **Domain:** owl:Thing
> - **Range:** owl:Thing
> - **Comment:** A relation between entities, expressing a 'sequence' schema. E.g. 'year 2000 follows 1999', 'preparing coffee' follows 'deciding what coffee to use', 'II World War follows I World War', etc. It can be used between tasks, processes or time intervals, and subproperties would fit best in order to distinguish the different uses.
> - **Inverse:** seq:precedes

**seq:directlyFollows**
> - **URI:** http://www.ontologydesignpatterns.org/cp/owl/sequence.owl#directlyFollows
> - **Label:** directly follows
> - **Domain:** owl:Thing
> - **Range:** owl:Thing
> - **Comment:** The intransitive follows relation. For example, Wednesday directly precedes Thursday. Directness of precedence depends on the designer conceptualization.
> - **Inverse:** seq:directlyPrecedes

Sample RDF
-----------

**Bound-withs**
```
:item1 a bf:Item ; 
    dcterms:isPartOf :boundCollection . 

:item2 a bf:Item ; 
    dcterms:isPartOf :boundCollection ;
    seq:follows :item1 .

:boundCollection a ex:BoundCollection , bf:Item ;
    dcterms:hasPart :binding ;
    ex:hasCustodialHistory :custodial_history .
```

Areas for Future Research
--------------
- While description of nonce collections is outside the scope of this recommendation, it may be of future interest to determine to what extent the proposed model can be extended to such collections, and how the differences might be surfaced in the model.


<a name="carrier">Part II. The Carrier Model</a>
==================
Summary
-------
The carrier model proposes linking items directly to their carriers, and deriving relationships between the individual items via their shared relationship to the same carrier. To prevent the unnecessary proliferation of carrier classes, we recommend using P2_hasType to specify a specific carrier from a controlled vocabulary, such as the RDA carrier terms.

Areas covered by other ontologies:  
- BIBFRAME: Item
- CIDOC-CRM: P2_hasType

Diagram
-------

![Carriers diagram](/modeling_recommendations/modeling_diagrams/carrier.png)

Term Specifications
--------
Classes
----
**bf:Item**
> - **URI:** http://id.loc.gov/ontologies/bibframe/Item
> - **Label:** Item
> - **Definition:** Single example of an Instance.

Properties
--------
**ex:isOnCarrier** (Object Property)
> - **URI:** TBD
> - **Label:** is on carrier
> - **Definition:** The item being described is on or contained in a particular physical form, such as a volume, a sheet of paper, or a computer disk.
> - **Domain:** Unspecified
> - **Range:** Unspecified
> - **Inverse:** ex:carries

**ex:carries** (Object Property)
> - **URI:** TBD
> - **Label:** carries
> - **Definition:** A particular physical form, such as a volume, a sheet of paper, or a computer disk, contains or has on it the item being described.
> - **Domain:** Unspecified
> - **Range:** Unspecified
> - **Inverse:** ex:isOnCarrier

Sample RDF
---------

**Artworks on a sheet**
```
:artwork1 a bf:Item ;
    bf:itemOf :instance1 ;
    ex:isOnCarrier :carrier1 .

:artwork2 a bf:Item ;
    bf:itemOf :instance2 ;
    ex:isOnCarrier :carrier1 .

:carrier1 crm:P2_hasType <http://vocab.getty.edu/aat/300014671> .
```

Areas for Future Research
----------
- There may be a desire to specify HOW a particular resource is affixed to its carrier (pasted, stapled, taped, etc.), but that may be a broader concern.
- In this model we propose the use of existing vocabularies, such as Getty or RDA, to describe the specific types of carriers. In general, a principled basis for determining when to use subclassing and when to use existing taxonomies to subtype broader classes needs to be articulated.


