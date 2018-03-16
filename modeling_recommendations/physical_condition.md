Activities Related to Physical Condition
===============
ArtFrame and RareMat, 2017-08-10

**Table of Contents**
- [Overview](#overview)
- [Summary](#summary)
- [RareMat Approach to Activities Related to Physical Condition](#raremat)
	- [Involved Classes](#classes)
	- 	[Involved Properties](#properties)
- [Diagrams and Sample RDF](#diagrams)

<a name="overview">Overview: </a>
-----------
Several LD4P domain-specific ontology extension groups identified the need to describe the physical condition of an item, along with related condition assessment and conservation activities. Extension group members also described the use case of relating a specific condition assessment with the conservator activity that is triggered by the assessment. Further, it should be possible to relate this to a new physical condition that may be the result of the conservation activity. A high level of flexibility should be maintained since a condition assessment may take place without causing a conservator activity or a conservator activity may d take place without a prior formal condition assessment. None of these concepts are currently covered in BIBFRAME.

[*CIDOC CRM*](http://www.cidoc-crm.org/), the [*Web Annotation Model*](https://www.w3.org/TR/annotation-model/) and [*PROV-O*](https://www.w3.org/TR/prov-o/) were consulted for possible re-use. It was determined that the Web Annotation Model would not support the requirements outlined above and the reuse of desired PROV-O properties is limited by domain and range restrictions. CIDOC-CRM does possibly include the needed classes and properties; however future work is to evaluated whether reusing CIDOC would meet the desired semantics.

<a name="summary">Summary of recommendations:</a>
---------------------------
-   Use  [**ex:ConservatorActivity**](http://example.org/ConservatorActivity)

-   Recommend use of [**seq:follows**](http://www.ontologydesignpatterns.org/cp/owl/sequence.owl#follows) and [**seq:precedes**](http://www.ontologydesignpatterns.org/cp/owl/sequence.owl#precedes) predicates and drop [**vivo:rank**](http://www.essepuntato.it/lode/owlapi/http://vivoweb.org/ontology/core#d4e7099).

-   Recommend use of [**frapo:hasOutput**](http://purl.org/cerif/frapo/hasOutput) and [**frapo:isOutputOf**](http://purl.org/cerif/frapo/isOutputOf)

-   Remove **"documenting"** from the definition of [**ex:ConservatorActivity**](http://example.org/ConservatorActivity)

-   Define the following new classes:
> - ex:ConditionAssessmentActivity
> - ex:ConditionAssessment
> - ex:PhysicalCondition

One condition assessment can describe one or more physical conditions as an overall assessment of the resource. However, each physical condition can describe only one aspect of the overall condition, resulting in potentially more than one physical condition statement. Each of these conditions can be acted on by one or more conservator activities.

-   Define the following new properties:
> - ex:hasPhysicalCondition/isPhysicalConditionOf
> - ex:isInputTo/hasInput - domain/range open
> - ex:describes/describedBy - domain/range open

-   New classes and properties should be included in a core ontology and not in separate domain-extension ontologies since at least three domain extensions identified use cases.

<a name="raremat">RareMat Approach to Activities Related to Physical Condition</a>
----------------------------------------------------------------

<a name="classes">**Involved Classes**</a>

**ex:Activity**
> - **Label:** Activity
> - **IRI:** [http://example.org/Activity](http://example.org/Activity)
> - **Definition:** An activity or contribution by a single agent that affects or alters the existence or state of a resource.

**ex:ConditionAssessmentActivity** (new)
> - **Label:** Condition Assessment Activity
> - **IRI:** tbd
> - **Has super-class:** ex:Activity
> - **Definition:** The activity of assessing and documenting the physical condition of an item, including damage, material vulnerabilities, special storage requirements, etc. This activity outputs a ConditionAssessment.

**ex:ConditionAssessment** (new)
> - **Label:** Condition Assessment
> - **IRI:** tbd
> - **Definition:** Assessment and/or documentation of the physical condition of an item, including damage, material vulnerabilities, special storage requirements, etc. The assessment is generally the output of a condition assessment activity, and may or may not result in a conservator activity.

**ex:PhysicalCondition** (new)
> - **Label:** Physical Condition
> - **IRI**: tbd
> - **Definition:** One specific aspect of the condition of an object or part of an object, including perceptible or measurable characteristics such as physical appearance, level of damage, quality, or completeness.

**ex:ConservatorActivity**
> - **Label:** Conservator
> - **IRI:** [http://example.org/ConservatorActivity](http://example.org/ConservatorActivity)
> - **Definition:** The activity of preserving or treating printed or manuscript material, works of art, artifacts, or other objects.

**<a name="properties">Involved Properties</a>**

**ex:describes** (Object property)
> - **Label:** describes (new)
> - **IRI:** tbd
> - **Definition:** This resource provides a description of another, for example a ConditionAssessment describes a PhysicalCondition.
> - **Comment:** Used with Unspecified
> - **Inverse:** ex:describedBy

**ex:describedBy** (Object property)
> - **Label:** described by (new)
> - **IRI:** tbd
> - **Definition:** This resource is described by another, for example a PhysicalCondition is described by a ConditionAssessment
> - **Comment:** Used with Unspecified
> - **Inverse:** ex:describes

**ex:hasInput** (Object property)
> - **Label:** has input (new)
> - **IRI:** tbd
> - **Definition:** One resource has another resource as input, for example when one resource is informed or acted on by another. A ConservatorActivity has input from a ConditionAssessment.
> - **Comment:** Used with Unspecified
> - **Inverse:** ex:isInputTo

**ex:isInputTo** (Object property)
> - **Label:** is input to (new)
> - **IRI:** tbd
> - **Definition:** One resource provides input to another. For example, a ConditionAssessment provides input to a ConservatorActivity.
> - **Comment:** Used with Unspecified
> - **Inverse:** ex:hasInput

**ex:hasPhysicalCondition** (Object property)
> - **Label:** has physical condition (new)
> - **IRI:** tbd
> - **Definition:** Relates an object or part of an object to a specific aspect of its physical condition.
> - **Range:** ex:PhysicalCondition
> - **Inverse:** ex:isPhysicalConditionOf

**ex:isPhysicalConditionOf** (Object property)
> - **Label:** is physical condition of (new)
> - **IRI:** tbd
> - **Definition:** Relates a specific physical condition to an object or part of an object.
> - **Domain:** ex:PhysicalCondition
> - **Inverse:** ex:hasPhysicalCondition

**bf:place** 
> - **Label**: Place
> - **URI**: http://id.loc.gov/ontologies/bibframe/place
> - **Domain**: unspecified
> - **Range**: http://id.loc.gov/ontologies/bibframe/Place
> - **Inverse**: unspecified
> - **Definition**: Geographic location or place entity associated with a resource or element of description, such as the place associated with the publication, printing, distribution, issue, release or production of a resource, place of an event.

**bf:date** 
> - **Label**: Date
> - **URI**: http://id.loc.gov/ontologies/bibframe/date
> - **Domain**: unspecified 
> - **Range**: unspecified
> - **Definition**: Date designation associated with a resource or element of description, such as date of title variation; year a degree was awarded; date associated with the publication, printing, distribution, issue, release or production of a resource. May be date typed.
> - **Comment**: Date may be used to express temporal information at any level of granularity.

**ex:hasActivity** (Object property)
> - **Label:** has Activity
> - **IRI:** [http://example.org/hasActivity](http://example.org/hasActivity)
> - **Description:** Relates this resource to an activity or contribution by a single agent that affects or alters its existence or state.
> - **Inverse:** ex:isActivityOf

**ex:isActivityOf** (Object property)
> - **Label:** has Activity
> - **IRI:** [http://example.org/isActivityOf](http://example.org/isActivityOf)
> - **Description:** Relates an activity to the affected resource.
> - **Inverse:** ex:hasActivity

**ex:isAgentOf** (Object property)
> - **Label:** Agent for
> - **IRI:** [http://example.org/isAgentOf](http://example.org/isAgentOf)
> - **Description:** Relates an agent to the activity it participated in.
> - **Domain:** ex:Activity
> - **Range:** ex:Agent
> - **Inverse:** ex:hasAgent

**ex:hasAgent** (Object property)
> - **Label:** has agent
> - **IRI:** [http://example.org/hasAgent](http://example.org/hasAgent)
> - **Description:** Relates an activity to its agent.
> - **Domain:** ex:Activity
> - **Range:** ex:Agent
> - **Inverse**: ex:isAgentOf

**frapo:hasOutput** (Object property)
> - **Label:** has output
> - **IRI:** [http://purl.org/cerif/frapo/hasOutput](http://purl.org/cerif/frapo/hasOutput)
> - **Description:** An object property linking an activity such as a project or endeavour to something that is created or produced as a result of that activity. Examples include a building created as a result of a building project, and a journal article published to describe the results of a research investigation.
> - **Comment:** Domain and range constraints have been removed from this object property to permit it to be used in unforeseen ways.
> - **Inverse:** frapo:isOutPutOf

**frapo:isOutputOf** (Object property)
> - **Label:** is output of
> - **IRI:** [http://purl.org/cerif/frapo/isOutputOf](http://purl.org/cerif/frapo/isOutputOf)
> - **Description:** An object property linking something that is created or produced to the activity that created or produced it.
> - **Comment:** Domain and range constraints have been removed from this object property to permit it to be used in unforeseen ways.
> - **Inverse:** frapo:hasOutput

**seq:follows** (Object property)
> - **Label:** follows
> - **IRI:** [http://www.ontologydesignpatterns.org/cp/owl/sequence.owl#follows](http://www.ontologydesignpatterns.org/cp/owl/sequence.owl#follows)
> - **Description:** A relation between entities, expressing a 'sequence' schema. E.g. 'year 2000 follows 1999', 'preparing coffee' follows 'deciding what coffee to use', 'II World War follows I World War', etc. It can be used between tasks, processes or time intervals, and subproperties would fit best in order to distinguish the different uses.
> - **Domain:** owl:Thing
> - **Range:** owl:Thing
> - **Inverse:** seq:precedes

**seq:precedes** (Object property)
> - **Label:** precedes
> - **IRI:** [http://www.ontologydesignpatterns.org/cp/owl/sequence.owl\#precedes](http://www.ontologydesignpatterns.org/cp/owl/sequence.owl#precedes)
> - **Description:** A relation between entities, expressing a 'sequence' schema. E.g. 'year 1999 precedes 2000', 'deciding what coffee to use' precedes 'preparing coffee', 'World War II follows World War I', 'in the Milan to Rome autoroute, Bologna precedes Florence', etc.
> - It can then be used between tasks, processes, time intervals, spatially locate objects, situations, etc. Subproperties can be defined in order to distinguish the different uses.
> - **Domain:** owl:Thing
> - **Range:** owl:Things
> - **Inverse:** seq:follows

<a name="diagrams">Diagrams and Sample RDF</a>
--------
--------
**Diagram 1: A condition assessment takes place, but does not result in a conservator activity.**
![Physical Condition diagram 1](/modeling_recommendations/modeling_diagrams/physical_condition_1.png)
```
:Item1 a bf:Item ;
    ex:hasActivity :activity1 ;
    ex:hasPhysicalCondition :physicalCondition1 .
    
:activity1 a ex:ConditionAssessmentActivity ;
    ex:isActivity of :item1 ;
    frapo:hasOutput :assessment1 .

:asessment1 a ex:ConditionAssessment ;
    frapo:isOutputOf :activity1 ;
    ex:describes :physicalCondition1 .
    
:physicalCondition1 a ex:PhysicalCondition ;
    ex:describedBy :assessment 1 ;
    rdf:value "Page 5 missing" ;
    ex:isPhysicalConditionOf :item 1.
```
--------
**Diagram 2: Conservator activity that is not the result of a condition assessment.**
![Physical Condition diagram 2](/modeling_recommendations/modeling_diagrams/physical_condition_2.png)
```
:Item2 a bf:Item ;
    ex:hasActivity :activity2 ;
    ex:hasPhysicalCondition :physicalCondition2 .

:activity2 a ex:ConservatorActivity ;
    rdfs:label "preventive conservation" ;
    ex:isActivity of :item2 ;
    frapo:hasOutput :physicalCondition2 .

:physicalCondition2 a ex:PhysicalCondition ;
    frapo:isOutputOf :activity2 ;
    ex:isPhysicalConditionOf :item 2 ;
    rdf:value "good" .
```
---------
**Diagram 3: One condition assessment describing one physical condition leading to one conservator activity resulting in a new physical condition.**
![Physical Condition diagram 3](/modeling_recommendations/modeling_diagrams/physical_condition_3.png)
```
:Item3 a bf:Item ;
    ex:hasActivity :activity1 ;
    ex:hasActivity :activity2 ;
    ex:hasPhysicalCondition :condition1 ;
    ex:hasPhysicalCondition :condition2 .

activity1 a ex:ConditionAssessmentActivity ;
    ex:isActivityOf :item3 ;
    frapo:hasOutput :assessment1 .

assessment1 a ex:ConditionAssessment ;
    ex:isOutputOf :activity1 ;
    ex:describes :condition1 .

activity2 a ex:ConservatorActivity ;
    ex:isActivityOf :item3 ;
    ex:hasInput :condition1 ;
    ex:hasOutput :condition2 .

:condition1 a ex:PhysicalCondition ;
    ex:isPhysicalConditionOf :item3 ;
    ex:describedBy :assessment1 ;
    ex:isInputTo :activity2 ;
    seq:precedes :condition2 ;
    rdf:value "Page 10 ripped" .

:condition2 a ex:PhysicalCondition ;
    ex:isPhysicalConditionOf :item3 ;
    ex:isOutputOf :activity2 ;
    seq:follows :condition1 ;
    rdf:value "Page 10 mended" .
```
---------
**Diagram 4: Condition assessment with two physical conditions, one leads to a conservator activity which results in a changed physical condition.**
![Physical Condition diagram 4](/modeling_recommendations/modeling_diagrams/physical_condition_4.png)
```
:Item4 a bf:Item ;
    ex:hasActivity :activity1, activity2 ;
    ex:hasPhysicalCondition :condition1, :condition2, :condition3 .

activity1 a ex:ConditionAssessmentActivity ;
    ex:isActivityOf :item4 ;
    frapo:hasOutput :assessment1 .

assessment1 a ex:ConditionAssessment ;
    frapo:isOutputOf :activity1 ;
    ex:describes :condition1 ;
    ex:describes :condition2 .

:activity2 a ex:ConservatorActivity ;
    ex:isActivityOf :item4 ;
    ex:hasInput :condition2 ;
    frapo:hasOutput :condition3 .

:condition1 a ex:PhysicalCondition ;
    ex:isPhysicalConditionOf :item4 ;
    ex:isDescribedBy :assessment1 ;
    rdf:value "Page 5 missing" .
```
--------
**Diagram 5: Two separate assessments identifying two different physical conditions. Each results in a conservator activity leading to a changed physical condition.**
![Physical Condition diagram 5](/modeling_recommendations/modeling_diagrams/physical_condition_5.png)
```
:Item5 a bf:Item ;
    ex:hasActivity :activity1, activity2, activity3, activity4 ;
    ex:hasPhysicalCondition :condition1, :condition2, :condition3, :condition4 .

:activity1 a ex:ConditionAssessmentActivity ;
    ex:isActivityOf :item5 ;
    bf:date "2010-12-01" ;
    frapo:hasOutput :assessment1 .

:activity2 a ex:ConditionAssessmentActivity ;
    ex:isActivityOf :item5 ;
    bf:date "2017-05-31" ;
    frapo:hasOutput :assessment2 .

:assessment1 a ex:ConditionAssessment ;
    frapo:isOutputOf :activity1 ;
    ex:describes :condition1 .

:assessment2 a ex:ConditionAssessment ;
    frapo:isOutputOf :activity2 ;
    ex:describes :condition1 .

:activity3 a ex:ConservatorActivity ;
    ex:isActivityOf :item5 ;
    ex:hasInput :assessment1 ;
    ex:hasInput :condition1 ;
    frapo:hasOutput :condition2 .

:activity4 a ex:ConservatorActivity ;
    ex:isActivityOf :item5 ;
    ex:hasInput :assessment2 ;
    ex:hasInput :condition3 ;
    frapo:hasOutput :condition4 .

:condition1 a ex:PhysicalCondition ;
    ex:isPhysicalConditionOf :item5 ;
    ex:describedBy :assessment1 ;
    ex:isInputTo :activity3 ;
    seq:precedes :condition2 ;
    rdf:value "Page 10 ripped" .

:condition2 a ex:PhysicalCondition ;
    ex:isPhysicalConditionOf :item5 ;
    frapo:isOutputOf :activity3 ;
    seq:follows :condition1 ;
    rdf:value "Page 10 mended" .

:condition3 a ex:PhysicalCondition ;
    ex:isPhysicalConditionOf :item5 ;
    ex:describedBy :assessment2 ;
    ex:isInputTo :activity4 ;
    seq:precedes :condition4 ;
    rdf:value: "Water damage, condition poor" .

:condition4 a ex:PhysicalCondition ;
    ex:isPhysicalConditionOf :item5 ;
    frapo:IsOutputOf :activity3 ;
    seq:follows :condition3 ;
    rdf:value: "Dried. Condition good" .
```
