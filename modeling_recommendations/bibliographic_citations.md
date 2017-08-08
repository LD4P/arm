Bibliographic Citations for Rare Materials Cataloging
=====================================================
2017-08-08

Table of Contents
> - [Overview](#overview)
> - [Entities to Be Modeled](#entities)
> - [Summary of Recommendations](#recommendations)
> - [Recommended Classes](#classes)
> - [Recommended Properties](#properties)
> - [Recommended Named Individuals](#individuals)
> - [Diagrams](#diagrams)


<a name="overview">Overview</a>
--------
Rare materials catalogers often cite reference sources listed in the Standard Citation Forms (SCF) database ([*https://rbms.info/scf/*](https://rbms.info/scf/)) to support the description and identification of particular items or editions. SCF entries can be thought of as authority records for individual reference sources, but they do not currently provide canonical work-level URIs for those sources. Sources are typically cited using a controlled string that identifies the source--for example, "Wing, D.G. Short-title catalogue of books printed in England, Scotland, Ireland, Wales, and British America, and of English books printed in other countries, 1641-1700 (2nd ed. 1994)"--often accompanied by a value that describes the location within the source where the item or edition being cataloged is referenced. Users should be able to query on both the reference source and the specific location of an entry within the source.

Additionally, there is a need to model "negative citations": catalogers will often cite a reference source in order to indicate that the item being cataloged is not listed in standard sources.

In total, there are four use cases to be modeled:
>1.  A citation is found, and the cataloger does not add commentary on the citation.
>2.  A citation is found, and the cataloger adds commentary on the citation.
>3.  A citation is not found, and the cataloger does not add commentary.
>4.  A citation is not found, but the cataloger adds commentary about the reference source or a related citation.

In addition, there is a need to model dates, identifiers, and other data related to citations. The proposed model will follow the general bibliotek-o modeling practices for dates, identifiers, and any other core data elements.

To address these four use cases, a new class should be created to represent bibliographic citation entities (**bib:Citation**). A citation functions as an intermediate node between a reference source (bf:Work), and a resource of interest to the cataloger (typically a bf:Item or bf:Instance).

A citation is related to a resource of interest by the property **cito:cites** (inverse cito:isCitedBy) and to the citing work by the property **bib:hasSource** (inverse bib:isSourceOf).

A citation may link directly to its source bf:Work, or it may link indirectly to the source through a specific location, modeled as a hierarchical chain proceeding from the most specific location up to the citing work. For example, a citation entity may be listed as a specific **bib:Entry** in a citing source, which may be located (**bib:atLocation**) on a **bib:Page**, which may be part of (**dcterms:isPartOf**) a **bib:Volume**, which may be part of (**dcterms:isPartOf**) the citing source (bf:Work).

Cataloger comments on citations are constructed using the Web Annotation model, with the citation resource as the target of the annotation.

A negative citation is also modeled as an **oa:Annotation**, with the motivation **bib:assertingCitationNotFound** provided as the object of the property **oa:hasPurpose**, on the annotation body.

Comments may also be added to negative citations using the Web Annotation model. A simple textual comment may be added as a second annotation body. If the cataloger wishes to include a related citation (for example, to a variant edition of a resource), a separate citation resource may be created (see diagram 4.2, below).

<a name="entities">Entities to Be Modeled</a>
----------------------
> - Resource of interest to cataloger; typically instance or item but may also be a work => bf:Instance, bf:Item, bf:Work
> - Reference source => bf:Work
> - Cataloger commentary => oa:Annotation
> - Citation => bib:Citation

<a name="recommendations">Summary of Recommendations</a>
--------------------------

1.  Mint additional annotation motivations:  **bib:asserting**, **bib:assertingSourceDataNotFound**, and **bib:assertingCitationNotFound** (listed in order from broadest to narrowest) to represent negative citations.

2.  Create a new class, **bib:Citation**, to represent bibliographic citations.

3.  Optionally, the location within a citing source may also be specified. Create new classes, **bib:Volume**, **bib:Page**, and **bib:Entry**, to record the location of a citation.

4.  Consider other location designators as appropriate.

<a name="classes">Recommended Classes</a>
-------------------

**bib:Citation**
> - **Label:** Citation
> - **URI:** TBD
> - **Subclass of**:
> - **Definition:** A single citation within a bibliographic source.
> - **Comment:**


**bib:Entry**
> - **Label:** Entry
> - **URI:** TBD
> - **Subclass of**:
> - **Definition:** A specific entry that locates a citation within a bibliographic source.
> - **Comment:** Used in parsing out hierarchically structured location designators for citations.


**bib:Page**
> - **Label:** Page
> - **URI:** TBD
> - **Subclass of**:
> - **Definition:** A single page within a resource.
> - **Comment:** Used in any page-level description, as well as in parsing out hierarchically structured location designators for citations.


**bib:Volume**
> - **Label:** Volume
> - **URI:** TBD
> - **Subclass of**:
> - **Definition:** A single bibliographic or physical volume of a resource.
> - **Comment:** Used in any volume-level description, as well as in parsing out hierarchically structured location designators for citations.

**oa:Annotation**
> - **Label:** Annotation
> - **URI:** [*http://www.w3.org/ns/oa/#Annotation*](http://www.w3.org/ns/oa#Annotation)
> - **Definition:** The class for Web Annotations.
> - **Comment:** NA

**oa:Motivation**
> - **Label:** Motivation
> - **URI:** [*http://www.w3.org/ns/oa/#Motivation*](http://www.w3.org/ns/oa#Motivation)
> - **Definition:** The Motivation class is used to record the user's intent or motivation for the creation of the Annotation, or the inclusion of the body or target, that it is associated with.
> - **Comment:** NA

**oa:SpecificResource**
> - **Label:** Specific resource
> - **URI:** [*http://www.w3.org/ns/oa/#SpecificResource*](http://www.w3.org/ns/oa#SpecificResource)
> - **Definition:** Instances of the SpecificResource class identify part of another resource (referenced with oa:hasSource), a particular representation of a resource, a resource with styling hints for renders, or any combination of these, as used within an Annotation.
> - **Comment:** NA

**oa:TextualBody**
> - **Label:** Textual body
> - **URI:** [*http://www.w3.org/ns/oa/#TextualBody*](http://www.w3.org/ns/oa#TextualBody)
> - **Definition:** NA
> - **Comment:** NA


<a name="properties">Recommended Properties</a>
----------------------

**bib:atLocation**
> - **Label:** at location
> - **URI:** [*http://bibliotek-o.org/1.1/ontology/atLocation*](http://bibliotek-o.org/1.1/ontology/atLocation)
> - **Domain:** Unspecified
> - **Range:** prov:Location
> - **Definition:** The resource being described is at the specified location.

**bib:hasSource**
> - **Label:** has source
> - **URI:** [*http://bibliotek-o.org/1.1/ontology/hasSource*](http://bibliotek-o.org/1.1/ontology/hasSource)
> - **Domain:** Unspecified
> - **Range:** Unspecified
> - **Inverse:** bib:isSourceOf
> - **Definition:** Relates this resource to the source from which it was derived.

**cito:cites**
> - **Label:** cites
> - **URI:** [*http://purl.org/spar/cito/cites*](http://purl.org/spar/cito/cites)
> - **Domain:** Unspecified
> - **Range:** Unspecified
> - **Inverse:** cito:isCitedBy
> - **Definition:** The citing entity cites the cited entity, either directly and explicitly (as in the reference list of a journal article), indirectly (e.g. by citing a more recent paper by the same group on the same topic), or implicitly (e.g. as in artistic quotations or parodies, or in cases of plagiarism).

**oa:hasBody**
> - **Label:** has body
> - **URI:** [*http://www.w3.org/ns/oa/#hasBody*](http://www.w3.org/ns/oa#hasBody)
> - **Domain:** oa:Annotation
> - **Definition:** The object of the relationship is a resource that is a body of the Annotation.

**oa:motivatedBy**
> - **Label:** motivated by
> - **URI:** [*http://www.w3.org/ns/oa/#motivatedBy*](http://www.w3.org/ns/oa#motivatedBy)
> - **Domain:** oa:Annotation
> - **Range:** oa:Motivation
> - **Definition:** The relationship between an Annotation and a Motivation that describes the reason for the Annotation's creation.

**oa:hasPurpose**
> - **Label:** has purpose
> - **URI:** [*http://www.w3.org/ns/oa/#hasPurpose*](http://www.w3.org/ns/oa#hasPurpose)
> - **Range:** oa:Motivation
> - **Definition:** The purpose served by the resource in the Annotation.

**oa:hasSource**
> - **Label:** at location
> - **URI:** [*http://www.w3.org/ns/oa/#hasSource*](http://www.w3.org/ns/oa#hasSource)
> - **Definition:** The resource that the ResourceSelection, or its subclass SpecificResource, is refined from, or more specific than.

**oa:hasTarget**
> - **Label:** has target
> - **URI:** [*http://www.w3.org/ns/oa/#hasTarget*](http://www.w3.org/ns/oa#hasTarget)
> - **Domain:** oa:Annotation
> - **Definition:** The relationship between an Annotation and its Target.

**dcterms:isPartOf**
> - **Label:** Is Part Of
> - **URI:** [*http://purl.org/dc/terms/isPartOf*](http://purl.org/dc/terms/isPartOf)
> - **Definition:** A related resource in which the described resource is physically or logically included.


<a name="individuals">Recommended Named Individuals</a>
-----------------------------
**bib:asserting**
> - **Label:** asserting
> - **URI:** TBD
> - **Named individual of**: oa:Motivation
> - **Narrower of**: NA
> - **Definition:** The motivation for when the user intends to make a claim or assertion.
> - **Comment**: NA

**bib:assertingSourceDataNotFound**
> - **Label:** asserting source data not found
> - **URI:** TBD
> - **Named individual of**: oa:Motivation
> - **Narrower of**: bib:asserting
> - **Definition:** The motivation for when the user intends to state that no data was found to support an assertion.
> - **Comment**: skos:narrower of the oa:Motivation named individual bib:asserting.

**bib:assertingCitationNotFound**
> - **Label:** asserting citation not found
> - **URI:** TBD
> - **Named individual of**: oa:Motivation
> - **Narrower of**: bib:assertingSourceDataNotFound
> - **Definition:** The motivation for when the user intends to state that no citation was found in a source.
> - **Comment**: skos:narrower of the oa:Motivation named individual bib:assertingSourceDataNotFound.

**oa:commenting**
> - **Label:** commenting
> - **URI:** http://www.w3.org/ns/oa/#commenting
> - **Named individual of**: oa:Motivation
> - **Definition:** The motivation for when the user intends to comment about the Target.
> - **Comment**:

**oa:identifying**
> - **Label:** identifying
> - **URI:**[*http://www.w3.org/ns/oa/#identifying*](http://www.w3.org/ns/oa#identifying)
> - **Named individual of**: oa:Motivation
> - **Definition:** The motivation for when the user intends to assign an identity to the Target or identify what is being depicted or described in the Target.
> - **Comment**:


<a name="diagrams">Diagrams</a>
--------

### Use case 1: Basic citation.
![Use Case 1](/modeling_recommendations/modeling_diagrams/citations_useCase_1.png)

### Use case 2: Citation located, cataloger adds commentary on citation.
![Use Case 2](/modeling_recommendations/modeling_diagrams/citations_useCase_2.png)

### Use case 3: Negative citation (without comment).
![Use Case 3](/modeling_recommendations/modeling_diagrams/citations_useCase_3.png)

### Use case 4.1: Negative citation with comment.
![Use Case 4.1](/modeling_recommendations/modeling_diagrams/citations_useCase_4_1.png)

### Use case 4.2: Negative citation plus additional citation.
![Use Case 4.2](/modeling_recommendations/modeling_diagrams/citations_useCase_4_2.png)
