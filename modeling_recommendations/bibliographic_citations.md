Bibliographic Citations for Rare Materials Cataloging
=====================================================
RareMat, 2018-01-12

Table of Contents
> - [Overview](#overview)
> - [Entities to Be Modeled](#entities)
> - [Summary of Recommendations](#recommendations)
> - [Recommended Classes](#classes)
> - [Recommended Properties](#properties)
> - [Diagrams](#diagrams)


<a name="overview">Overview</a>
--------
Rare materials catalogers often cite reference sources listed in the Standard Citation Forms (SCF) database ([*https://rbms.info/scf/*](https://rbms.info/scf/)) to support the description and identification of particular items or editions. SCF entries can be thought of as authority records for individual reference sources, but they do not currently provide canonical work-level URIs for those sources. Sources are typically cited using a controlled string that identifies the source--for example, "Wing, D.G. Short-title catalogue of books printed in England, Scotland, Ireland, Wales, and British America, and of English books printed in other countries, 1641-1700 (2nd ed. 1994)"--often accompanied by a value that describes the location within the source where the item or edition being cataloged is referenced. Users should be able to query on both the reference source and the specific location of an entry within the source.

Additionally, there is a need to model "negative citations": catalogers will often cite a reference source in order to indicate that the item being cataloged is not listed in standard sources.

In total, there are four use cases to be modeled:
>1.  A citation is found, and the cataloger does not add commentary on the citation.
>2.  A citation is found, and the cataloger adds commentary on the citation.
>3.  A citation is not found, and the cataloger does not add commentary.
>4.  A citation is not found, and the cataloger adds further commentary about the reference source or a related citation.

In addition, there is a need to model dates, identifiers, and other data related to citations. The proposed model will follow the general BIBFRAME modeling practices for dates, identifiers, and any other core data elements.

To address these four use cases, a new class should be created to represent bibliographic citation entities (**ex:Citation**). A citation functions as an intermediate node between a reference source (bf:Work), and a resource of interest to the cataloger (typically a bf:Item or bf:Instance).

A citation is related to a resource of interest by the property **cito:cites** (inverse cito:isCitedBy) and to the citing work by the property **ex:hasSource** (inverse ex:isSourceOf).

A citation may link directly to its source bf:Work, or it may link indirectly to the source through a specific location, modeled as a hierarchical chain proceeding from the most specific location up to the citing work. For example, a citation entity may be listed as a specific **ex:Entry** in a citing source, which may be located (**bf:place**) on a **ex:Page**, which may be part of (**bf:partOf**) a **ex:Volume**, which may be part of (**bf:partOf**) the citing source (bf:Work).

Cataloger comments on citations are constructed using the BIBFRAME notes.

A negative citation is also modeled as an **bf:Note**, with the value "not found."

<a name="entities">Entities to Be Modeled</a>
----------------------
| Entity       | Type         | 
|:-------------|:-------------|
| Resource of interest to cataloger; typically instance or item but may also be a work | bf:Instance, bf:Item, bf:Work |
| Reference source    | bf:Work      |
| Cataloger commentary | bf:Note      |
| Citation | ex:Citation     |

<a name="recommendations">Summary of Recommendations</a>
--------------------------

1.  Create a new class, **ex:Citation**, to represent bibliographic citations.

2.  Optionally, the location within a citing source may also be specified. Create new classes, **ex:Volume**, **ex:Page**, and **ex:Entry**, to record the location of a citation.

3.  Consider other location designators as appropriate.

<a name="classes">Recommended Classes</a>
-------------------

**ex:Citation**
> - **Label:** Citation
> - **URI:** TBD
> - **Subclass of**:
> - **Definition:** A single citation within a bibliographic source.
> - **Comment:**

**ex:Entry**
> - **Label:** Entry
> - **URI:** TBD
> - **Subclass of**:
> - **Definition:** A specific entry that locates a citation within a bibliographic source.
> - **Comment:** Used in parsing out hierarchically structured location designators for citations.

**ex:Page**
> - **Label:** Page
> - **URI:** TBD
> - **Subclass of**:
> - **Definition:** A single page within a resource.
> - **Comment:** Used in any page-level description, as well as in parsing out hierarchically structured location designators for citations.

**ex:Volume**
> - **Label:** Volume
> - **URI:** TBD
> - **Subclass of**:
> - **Definition:** A single bibliographic or physical volume of a resource.
> - **Comment:** Used in any volume-level description, as well as in parsing out hierarchically structured location designators for citations.


<a name="properties">Recommended Properties</a>
----------------------

**bf:place**
> - **Label:** Place
> - **URI:** [*http://id.loc.gov/ontologies/bibframe/place*](http://id.loc.gov/ontologies/bibframe/place)
> - **Domain:** Unspecified
> - **Range:** http://id.loc.gov/ontologies/bibframe/Place
> - **Definition:** Geographic location or place entity associated with a resource or element of description, such as the place associated with the publication, printing, distribution, issue, release or production of a resource, place of an event.

**ex:hasSource**
> - **Label:** has source
> - **URI:** [*http://example.org/hasSource*](http://example.org/hasSource)
> - **Domain:** Unspecified
> - **Range:** Unspecified
> - **Inverse:** ex:isSourceOf
> - **Definition:** Relates this resource to the source from which it was derived.

**cito:cites**
> - **Label:** cites
> - **URI:** [*http://purl.org/spar/cito/cites*](http://purl.org/spar/cito/cites)
> - **Domain:** Unspecified
> - **Range:** Unspecified
> - **Inverse:** cito:isCitedBy
> - **Definition:** The citing entity cites the cited entity, either directly and explicitly (as in the reference list of a journal article), indirectly (e.g. by citing a more recent paper by the same group on the same topic), or implicitly (e.g. as in artistic quotations or parodies, or in cases of plagiarism).

**bf:partOf**
> - **Label:** Is Part Of
> - **URI:** [*http://id.loc.gov/ontologies/bibframe/hasPart*](http://id.loc.gov/ontologies/bibframe/hasPart)
> - **Definition:** Resource that is included either physically or logically in the described resource


<a name="diagrams">Diagrams</a>
--------

### Use case 1: Basic citation.
![Use Case 1](/modeling_recommendations/modeling_diagrams/citations_useCase_1.png)

### Use case 2: Citation located, cataloger adds commentary on citation.
![Use Case 2](/modeling_recommendations/modeling_diagrams/citations_useCase_2.png)

### Use case 3: Negative citation (without comment).
![Use Case 3](/modeling_recommendations/modeling_diagrams/citations_useCase_3.png)

### Use case 4: Negative citation with comment.
![Use Case 4.1](/modeling_recommendations/modeling_diagrams/citations_useCase_4.png)
