Measurements of Whole, Part, and Arrangement 
======================
ArtFrame and RareMat, 2017-08-10

**Table of Contents**
> - [Overview](#overview)
> - [Relevant Documentation](#documentation)
> - [Summary of Recommendations](#recommendations)
> - [BIBFRAME Approach to Measurements](#bibframe)
> - [Recommended Approach to Measurements](#recommended_approach)
> - [Diagrams & Discussion](#diagrams)
> - [Areas for Future Research](#future-research)

<a name="overview">Overview</a>
---------
In current MARC cataloging practice dimensions are recorded in one single subfield (300 \$c) even if the content standard or domain specific cataloging practice direct the cataloger to record the measurements in much more detail. BIBFRAME has carried this forward by defining the datatype property bf:dimensions. However, there are number of domain specific ontologies (such as [*QUDT*](http://qudt.org/doc/2016/DOC_SCHEMA-QUDT-v2.0.html), [*VRA
RDF*](https://s3.amazonaws.com/VRA/ontology.html#) and [*CIDOC CRM*](http://www.cidoc-crm.org/)) that do provide more granularity and in 2015 a discussion paper was submitted to the Committee on Cataloging: Description & Access to expand RDA instructions in this area. Measurements were also identified at the [*In-Person Meeting of ArtFrame and the Rare Materials Ontology
Extension*](https://wiki.duraspace.org/pages/viewpage.action?pageId=83230960) groups as an area in need of more in-depth modeling.

The above mentioned ontologies and the RDA discussion paper were all considered for possible reuse and informed the proposed bibliotek-o pattern. QUDT does not support the ability to specify which part of an object was measured (e.g. visible image or written space) or in which arrangement the object was when it was measured (e.g. rolled or folded). However, the QUDT [*Units Ontology*](http://qudt.org/1.1/vocab/unit) can be re-used to express measurement units such as inches or centimeter.

CIDOC-CRM appears to be a somewhat closed ecosystem that diverse schema and ontologies can map to in a universal way. We therefore recommend that bibliotek-o defines its own measurement pattern that should be aligned with the CIDOC-CRM.

Recommendations were tested on sample data pulled from existing descriptions.

While the measurement model was developed specifically to address the descriptive needs of bibliographic items in the art and rare materials domains, we define it as an independent model with the expectation that it could be useful in the description of a broad range of resources.

<a name="documentation">Relevant Documentation</a>
------------------------
[*Machine-Actionable Data Elements for Measurements, Extent of the Carrier, Pagination and Foliation, Dimensions, Extent of the Content, and Duration – Discussion Paper*](http://www.rda-jsc.org/sites/all/files/6JSC-ALA-Discussion-5.pdf) (2015)

<a name="recommendations">Summary of Recommendations</a>
---------------------------
-   Use of rdfs:label provides a human-readable form of the measurement
-   Use rdf:value for numeric values
-   Use dcterms:description when describing or specifying the part or arrangement being measured when this cannot be identified as a distinct resource and for qualifiers like “approximately”, “or smaller”, etc.
-   Use dcterms:hasPart to express measurements that only apply to a specific part of a resource that can be identified as a distinct resource.
-   Use bf:Unit: Request clarification from LC regarding the intent of this class before considering its use. The definition bf:Unit appears to be inline for this measurement model, but the use of it as the range of bf:unit seems to imply a different intent.

-   Define the following new classes:
> - ex:MeasurementGroup
> - ex:Measurement
> - ex:Arrangement [request that LC broadens the definition of bf:Arrangement to include our use case, the organization and collection of a single item.]

-   Define the following new properties:
> - ex:hasMeasurementGroup
> - ex:isMeasurementGroupOf
> - ex:hasMeasurement
> - ex:isMeasurementOf
> - ex:measures
> - ex:measuredBy
> - ex:hasUnit
> - ex:isUnitOf
> - ex:hasArrangement [request that LC broadens the definition of bf:arrangement to include our use case, the organization and collection of a single item.]

-   Value vocabularies:
> - For units, use NASA QUDT Units Ontology [*http://www.qudt.org/qudt/owl/1.0.0/unit/index.html*](http://www.qudt.org/qudt/owl/1.0.0/unit/index.html)
> - For arrangements, such as rolled, folded, etc. a vocabulary will have to be developed. Since these arrangements cover several domains (for example several types of resources can potentially be folded) it might be best served in bibliotek-o or a distinct measurements “utility” ontology.
> - For dimension types, such as height, width, weight, etc. use
> AAT, Art & Architecture Thesaurus.
> - For parts measured (e.g. container, mount, platemark): Each domain implementing this model will need to define their own classes.

<a name="bibframe">BIBFRAME Approach to Measurements</a>
---------------------------------
**bf:dimensions**
> - **Label:** Dimensions
> - **IRI:** [*http://id.loc.gov/ontologies/bibframe/dimensions*](http://id.loc.gov/ontologies/bibframe/dimensions)
> - **Range:** Literal
> - **Definition:** Measurements of the carrier or carriers and/or the container of a resource.

<a name="recommended_approach">Recommended Approach to Measurements</a>
------------------------------------
### Involved Classes

**ex:MeasurementGroup**
> - **Label**: Measurement Group
> - **IRI:** tbd
> - **Definition:** A set of measurements pertaining to a specific resource, part of a resource, or resource in a particular arrangement. For example, a book may have a specified height, width, length, and/or weight, which are all attached to a MeasurementGroup; the binding may have measurements specified independently, which would constitute another MeasurementGroup. A MeasurementGroup has one or more specific Measurements attached to it.

**ex:Measurement**
> - **Label:** Measurement
> - **IRI:** tbd
> - **Definition:** The measurement of a single aspect of a resource, including value, units, and the aspect measured. For example, a book may have a height (aspect) of 10 (value) centimeters (units). Each such measurement is attached to a MeasurementGroup.

**ex:Arrangement** 
> - **Label:** Arrangement
> - **IRI**: tbd
> - **Definition:** The arrangement, organization, or configuration of a single object or collection of objects. For example, a parchment may be rolled or unrolled; a collection of visual materials has a specific arrangement; computer files are organized and ordered in a specific way.

### Involved Properties

**ex:hasMeasurementGroup** (Object property)
> - **Label:** has measurement group
> - **IRI:** tbd
> - **Definition:** The relationship of a resource to a measurement group, indicating that the measurement group applies to the resource.
> - **Domain:** Unspecified
> - **Range:** ex:MeasurementGroup
> - **Inverse:** ex:isMeasurementGroupOf

**ex:isMeasurementGroupOf** (Object property)
> - **Label:** is measurement group of
> - **IRI:** tbd
> - **Definition:** The relationship of a measurement group to a resource, indicating that the measurement group applies to the resource.
> - **Domain:** ex:MeasurementGroup
> - **Range:** Unspecified
> - **Inverse:** ex:hasMeasurementGroup

**ex:hasMeasurement** (Object property)
> - **Label:** has measurement
> - **IRI:** tbd
> - **Definition:** The relationship of a MeasurementGroup to a Measurement, indicating that the Measurement is one part of the MeasurementGroup.
> - **Domain:** Unspecified
> - **Range:** ex:Measurement
> - **Inverse:** ex:isMeasurementOf

**ex:isMeasurementOf** (Object property)
> - **Label:** is measurement of
> - **IRI:** tbd
> - **Definition:** The relationship of a Measurement to a MeasurementGroup, indicating that the Measurement is one part of the MeasurementGroup.
> - **Domain:** ex:Measurement
> - **Range:** ex:MeasurementGroup
> - **Inverse:** ex:hasMeasurement

**ex:measures** (Object property)
> - **Label:** measures
> - **IRI:** tbd
> - **Definition:** The relationship between a Measurement and the dimension or other aspect of a resource that is measured by this Measurement. For example, a Measurement may specify the length, height, weight, file size, etc. of a resource.
> - **Domain:** ex:Measurement
> - **Range:** Unspecified
> - **Inverse:** ex:measuredBy

**ex:measuredBy** (Object property)
> - **Label:** measured by
> - **IRI:** tbd
> - **Definition:** The relationship between a dimension or other aspect of a resource and the Measurement that measures it. For example, the length, height, weight, file size, etc. of a resource may be the aspect that is measured by a particular Measurement.
> - **Domain:** Unspecified
> - **Range:** ex:Measurement
> - **Inverse:** ex:measures

**ex:hasUnit** (Object property)
> - **Label:** has unit
> - **IRI:** tbd
> - **Definition:** Relationship between the measurement and the unit used to express the measurement.
> - **Domain:** Unspecified
> - **Range:** Unspecified
> - **Inverse:** ex:isUnitOf

**ex:isUnitOf** (Object property)
> - **Label:** is unit of
> - **IRI:** tbd
> - **Definition:** Relationship between the measurement and the unit used to express the measurement.
> - **Domain:** Unspecified
> - **Range:** Unspecified
> - **Inverse:** ex:hasUnit

**ex:hasArrangement** (Object property)
> - **Label:** has arrangement
> - **IRI:** tbd
> - **Definition:** Relationship between the resource and a specified arrangement, organization, or configuration of it.
> - **Domain:** Unspecified
> - **Range:** ex:Arrangement
> - **Inverse**: ex:isArrangementOf

**ex:isArrangementOf**
> - **Label:** is arrangement of
> - **IRI:** tbd
> - **Definition:** Relationship between a specified arrangement, organization, or configuration and a resource.
> - **Domain:** ex:Arrangement
> - **Range:** Unspecified
> - **Inverse**: ex:hasArrangement

**dcterms:hasPart**
> - **Label:** Has Part
> - **IRI:** http://purl.org/dc/terms/hasPart
> - **Definition:** A related resource that is included either physically or logically in the described resource.
> - **Note:** This term is intended to be used with non-literal values as defined in the DCMI Abstract Model (http://dublincore.org/documents/abstract-model/). As of December 2007, the DCMI Usage Board is seeking a way to express this intention with a formal range declaration.
> - **subPropertyOf:** http://purl.org/dc/terms/relation

**dcterms:description**
> - **Label:** Description
> - **IRI:**http://purl.org/dc/elements/1.1/description
> - **Definition:** An account of the resource.
> - **Comment:** Description may include but is not limited to: an abstract, a table of contents, a graphical representation, or a free-text account of the resource.
> - **Note:** A second property with the same name as this property has been declared in the dcterms: namespace (http://purl.org/dc/terms/). See the Introduction to the document "DCMI Metadata Terms" (http://dublincore.org/documents/dcmi-terms/) for an explanation.

<a name="diagrams">Diagrams and Discussion</a>
---------------------
The diagrams illustrate models of measurements of a resource, a part of the resource, and the resource in a particular arrangement.

### Diagram 1: Basic measurement model with optional descriptions

![Measurement diagram 1](/modeling_recommendations/modeling_diagrams/measurement_basic.png)
**Notes**

-   rdfs:label provides a human-readable form of the measurement.

-   The measurement classes and predicates are not subclasses / subproperties of PhysicalCharacteristic and hasPhysicalCharacteristic, in order to allow use for digital and other non-physical measurements (file size, pixels, bytes, etc.).
Whether or not the model is used in this way in our descriptions is an implementation issue.

-   dcterms:description is used to describe or specify the part or arrangement being measured when this cannot be identified as a distinct resource, as in Diagram 3. For example, a resource may be measured in a container which is then thrown away, so it makes no sense to model it as a resource. See other examples in the diagram.

-   Qualifiers will provisionally be expressed using dcterms:description. We will leave the question of using a different predicate with a controlled vocabulary (approximate, or smaller, etc.) as future work.

-   Note that each value of dcterms:description is atomic: there should be one assertion for each literal value, rather than combining values into a composite string.

### Diagram 2: Single resource with multiple measurement group and descriptions

![Measurement diagram 2](/modeling_recommendations/modeling_diagrams/measurement_multiple.png)

### Diagram 3: Measurements of whole and part: part a resource

![Measurement diagram 3](/modeling_recommendations/modeling_diagrams/measurement_whole_part.png)
**Notes**
-   For domain extensions: Identify classes for parts of resources like binding, frame, etc. Should there be a superclass?

### Diagram 4: Measurements of whole and part with additional physical characteristics

![Measurement diagram 4](/modeling_recommendations/modeling_diagrams/measurement_physical_characteristics.png)

**Notes**
-   Demonstrates that when a part of a resource, such as a binding or frame, is recognized as a distinct resource, other assertions can be made about it (color, material, etc.).

### <a name="diagram-5">Diagram 5: Measurements of arrangement: arrangement is a resource</a>

![Measurement diagram 5](/modeling_recommendations/modeling_diagrams/measurement_arrangement.png)

**Notes/TBD**

-   Rationale for a state object is not necessarily that there are other assertions to be made about it, but that a controlled vocabulary of states, rather than literal values, can be used.

-   Examples of resources with arrangements: road maps (folded/unfolded), parchments (rolled/unrolled), book (open/closed).

-   The measurements attached directly to the Work/Instance/Item resource do not specify a particular arrangement, but presumably it is different from the folded arrangement.

-   Find or define controlled vocabulary for physical arrangement.

### <a name="diagram-6">Diagram 6: Measurements of arrangements: multiple arrangement resources</a>

![Measurement diagram 6](/modeling_recommendations/modeling_diagrams/measurement_multiple_arrangements.png)

**Notes/TBD**

-   In this version, two arrangements are expressed as separate resources, without a default or unspecified arrangement. Choice of model 5 vs 6 would be an implementation decision by the cataloger.

<a name="future-research">Areas for Future Research</a>
----------------------

* Measurements of specific arrangements of a resource. As illustrated in Diagrams [5](#diagram-5) and [6](#diagram-6), when a MeasurementGroup applies to a specific arrangement of a resource, the model proposes that it
is attached directly to the Arrangement and only indirectly to the resource itself. This creates an asymmetry between this and other scenarios, where the predicates hasMeasurementGroup/isMeasurementGroupOf link the MeasurementGroup
directly to the Item, Instance, or other resource; this in turn results in non-uniform querying of these scenarios. One might propose an alternative model in which the MeasurementGroup is directly attached to the resource, 
as in other cases, and linked to the Arrangement via some other suitable predicate with the semantics "measures arrangement of."  However, the Arrangement nevertheless _does_ need to attach directly to the resource, since it is a
descriptor of the resource itself independent of any measurements. One could contemplate a triangular model in which each resource attaches directly (but redundantly) to _both_ of the others, as in [Diagram 7](#diagram-7). The larger research
question is whether introducing redundancy into a model for the sake of maintaining uniform querying is preferable to maintaining non-uniform models to avoid redundancy, noting that redundancy creates data maintenance 
problems.

### <a name="diagram-7">Diagram 7: Triangulated Resource, Arrangement, and Measurement</a>

![Measurement diagram 7](/modeling_recommendations/modeling_diagrams/measurement_triangulated_resource_arrangement_and_measurement.png)