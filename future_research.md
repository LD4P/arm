# Areas for Future Research and Development in the Art and Rare Materials BIBFRAME Ontology Extension

- [Introduction](#intro)
- [General Design Issues](#design)
- [Activities](#activities)
- [Attributions](#attributions)
- [Awards](#awards)
- [Bibliographic Citations](#citations)
- [Bindings and Other Enclosures](#bindings)
- [Bound-withs](#boundwiths)
- [Carriers](#carriers)
- [Custodial History](#custodial_history)
- [Exhibitions](#exhibitions)
- [Fonts, Handwriting, and Notations](#fonts)
- [Genre/Form](#genre)
- [Markings](#markings)
- [Materials](#materials)
- [Measurements](#measurements)
- [Physical Condition and Conservation](#physcondition)
- [Style/Period](#style_period)


<a name="intro">Introduction</a>
==============

During the course of our modeling work in the domain of Art and Rare Materials (ARM), we identified a number of areas for future research and development that time constraints prevented us from addressing within the LD4P project period and are the subject of this document.  Also included are broad issues of overall ontology design that apply to a range of models within the ARM domain, the broader domain of bibliographic description, and beyond.

The issues discussed in this section relate to larger issues of ontology and vocabulary design, and thus may be relevant to several of the ARM recommendations as well as to ontologies beyond the ARM and bibliographic domains.

Readers may refer to the ARM GitHub repository for details on the models discussed here.

<a name="design">General Design Issues</a>
=================

Use of controlled vocabularies
----------

Typing via class hierarchies vs controlled vocabularies
-----------------
A recurrent design issue we confronted is whether to achieve granular typing of resources via subclassing or controlled vocabularies, and to date we have not been consistent across our models in the selection of one or the other device. The former approaches uses the predicate rdf:type to assert the type of a resource, the latter the predicate <a href="http://www.cidoc-crm.org/Property/P2-has-type/Version-6.2">crm:P2_has_type</a>.

There are three possible approaches:

> 1. Typing through classes alone
> 2. Typing through controlled vocabularies alone
> 3. A hybrid approach, using classes to define high-level types and vocabularies for more granular typing within classes

We have used both approaches 1 and 3 in our models.  ARM types that rely wholly on subclassing include: Activity, AwardReceipt, CustodialEvent, Marking, 
Types using a hybrid approach include: Binding, Carrier, HandwritingType, Material, StylePeriod, Typeface, as well as bf:GenreForm and bf:Note. Note: Since the utility of the StylePeriod class is also an open question, if it were deprecated then the StylePeriod model would exemplify approach 2.

We assume that it is most sensible to determine the best approach on a case-by-case basis, rather than attempting a blanket recommendation based solely on high-level design considerations or bias towards either ontology or taxonomy modeling. Issues that will come into play when evaluating individual cases include at least:

> - The prior existence of a deep, well-established taxonomy for a knowledge domain, such as LCSH genre/form terms, RBMS binding types, RDA and AAT materials, MARC relators (for roles), and so on. In such a case it is both pointless and unmaintainable to attempt to recreate a taxonomy in a class hierarchy. This approach was attempted in the bibliotek-o Activity model (now provisionally adopted into ARM for further consideration), which defines an extensive set of Activity subclasses that shadow MARC relators, and this has been identified as a weakness of that model. On the other hand, the AwardReceipt types are likely quite limited, and there is to our knowledge no existing vocabulary for these types.
> - The descriptive need to instantiate a resource to sit between the resource being described and the vocabulary term. See the section on Profiling with controlled vocabularies for more detailed discussion. 
> - The value and utility of defining a high-level class such as StylePeriod at all (i.e., approach 2).  

Profiling with controlled vocabularies
-------------
ARM profiles use taxonomy terms in two distinct ways. Consider the contrasting implementations of the ARM arrangement and status vocabularies:

<b>Arrangement</b>: an arm:Arrangement resource is instantiated and linked to the bibliographic resource it describes via the predicate arm:isArrangementOf (inverse arm:hasArrangement) and possibly to a set of measurements (arm:MeasurementGroup) via the predicate arm:hasMeasurementGroup. This Arrangement resource is needed to attach the measurements to. The vocabulary terms are typed skos:Concept, whereas the individual resources are typed arm:Arrangement.

```
:item arm:hasArrangement :arrangement .

:arrangement a arm:Arrangement ;
    arm:hasMeasurementGroup :measurementGroup ;
    crm:P2_has_type arm:folded .

# Defined in the arrangement vocabulary:
arm:folded a skos:Concept .
```

<b>Materials</b> provide another <a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/materials.md#sample-rdf">example of this pattern</a>: because the material resource may have a color as well as a type, and other attributes that have not yet been covered, a resource is instantiated and linked to both the material and color vocabulary terms using crm:P2_has_type and rdau:P60558, respectively; it is also assigned rdf:type crm:E57_Material. 

<b>Status</b>: An identifier links directly to a status term, e.g., arm:deprecated via the predicate bf:status. It is not necessary to instantiate a bf:Status resource with crm:P2_has_type arm:deprecated, because there would be no further assertions to be made of such a resource. The vocabulary terms themselves are typed bf:Status.
```
:identifier a bf:Identifier ;
    bf:status arm:deprecated .

# Defined in the status vocabulary:
arm:deprecated a bf:Status .
```

The modeling is less straightforward when data is imperfect and there is thus no complete alignment to a vocabulary term, as in the example of some style/period descriptions, where it is necessary to resort to string values due to uncertainty. We can instantiate a StylePeriod resource, assign it a string value (via rdf:value, rdfs:label, dcterms:description, etc.), and align it to existing vocabulary terms via an appropriate SKOS predicate (e.g, broader, narrower, related, etc.); this is essentially the Arrangement pattern, but uses a SKOS predicate rather than crm:P2_has_type to align to the vocabulary terms. But in the general case we use arm:hasStylePeriod to link directly to a style/period vocabulary term, like the status example, thus creating asymmetry in the modeling of style/period. 

While variable graph patterns can be accommodated in discovery using more complex SPARQL queries, there is a more fundamental issue raised by the use of distinct graph patterns to represent conceptually parallel data. In order to keep the graph patterns uniform, we could always instantiate a StylePeriod resource, even when not needed. This points to an even broader design issue of redundancy vs asymmetry.

The StylePeriod patterns are discussed in greater detail, with RDF examples, in <a href="https://github.com/LD4P/arm/issues/56#issuecomment-398498567">LD4P-ARM's GitHub Issue #56</a>. 

Formal specification of controlled vocabularies
---------------

The ARM controlled vocabularies are expressed as sets of OWL NamedIndividuals. Consider rewriting as SKOS vocabularies using skos:Concept and skos:ConceptScheme; possibly type as both owl:NamedIndividual and skos:Concept. What are the pros and cons of each approach?

General vs specific predicates
-------------
In several instances below we note that a general predicate might be used instead of a more specific one, or vice versa. E.g., for bindings and enclosures we suggest possible use of a new predicate arm:encloses/enclosedBy rather than bf:partOf/hasPart; conversely for physical condition we suggest use of the activity predicates rather than the more specific input/output predicates. The part-whole relation is of particular interest, since it raises the question of when one resource is a part of another? For example, we have decided that a binding is part of an Item but a marking is not; is there a principled basis for this distinction? There may be general design criteria that can be brought to bear on the question of when and where to use general vs specific predicates. 


Confidence level
-------------
Confidence levels are applicable to at least the Attribution and Custodial History models. Attribution may be more straightforward, in that the confidence level could be attached directly to the Attribution node. In the case of custodial history, a confidence level is logically attached to an assertion, but reification is a distasteful approach. This topic merits further exploration, and likely has much broader applicability.

Simplicity of model vs simplicity of graph

The tension between simplicity of models/patterns and simplicity of graph data (eliminating redundant nodes in the instance graph) arises with respect to several of the models; see, e.g., Profiling with controlled vocabularies and Unary events. As a general principle, is it preferable to simplify the model at the cost of redundant nodes in the instance graph, or to reduce complexity in the instance graph by eliminating redundant nodes at the cost of asymmetric modeling patterns? Can a general principle be articulated, or is it a case-by-case issue?

Simplicity vs semantic explicitness
-----------
The Physical Condition model proposes complex subgraphs, essentially modeling a workflow, which results in multiple connections between resources, either directly or via other nodes. For
example, in Diagram 2, the output PhysicalCondition resource is linked to an Item both directly, via arm:isPhysicalCondition, and indirectly, through the ConservatorActivity; the other diagrams illustrate even more complex networks of connections. Another example is discussed below in the context of measurements and arrangements. Direct connections between two nodes are redundant if they are connected through a series of links, add complexity to both the model and instance graphs, and create maintenance problems; on the other hand, the direct links provide semantic clarity and explicitness. 


Ontology axioms vs SHACL constraints
--------
Inferencing over instance data, particularly with the rich set of axioms provided by OWL, is used both to create new assertions and to identify contradictory (i.e., validate) data. Some examples of contradictory data:

```
P rdf:range xsd:integer . 
r P “3.5”^^xsd:decimal .
```
```
P a owl:IrreflexiveObjectProperty .
r P r .
```
```
P1 a owl:FunctionalProperty .
r1 P1 r2. 
```
```
P2 a owl:IrreflexiveProperty .
r1 P2 r2 .
```



However, an ontology alone may underspecify a model; other formalizations, such as SHACL constraints, which are also used to validate implementing instance data, may express aspects of the model that OWL cannot, or express them more concisely, simply, or clearly. Which modeling patterns should be expressed as axioms in the ontology, and which as SHACL (or ShEx, etc.) constraints? What are principled criteria for making this decision? Is there a clear line between model and recommended implementation (note that our <a href="https://github.com/LD4P/arm/tree/master/modeling_recommendations">modeling recommendations</a> are a combination of both)? How much complexity in terms of OWL axioms do we want to introduce into our ontologies, considering that complex axioms may constrain implementation of the ontology to an unacceptable degree? What is the balancing point between precision and unwieldiness? What does it mean to implement the model? - is it a matter of using the ontology, or following proposed usage of its authors (both narratively and in SHACL shapes)? 

<a name="activities">Activities</a>
=========

ARM Activity model vs BIBFRAME Contribution model
----------------------------
Both the <a href="https://wiki.duraspace.org/display/LD4P/bibliotek-o?preview=/79795231/83237322/bibliotek-o_pattern_activities_201612.pdf">bibliotek-o Activity model</a> and the <a href="https://www.loc.gov/bibframe/docs/pdf/bf2-roles-march2017.pdf">bf:Contribution</a> model describe agent roles in relation to other resources. Due to time constraints, a decision to use one or the other was postponed; because use of the Activity model was already underway, it was adopted into the ARM namespace on a provisional basis, but this does not signal a preference for that model. In fact, we are inclined to adopt the BIBFRAME model in order to maximize alignment with BIBFRAME; the Contribution model is also preferable because it makes use of existing role vocabularies rather than reproducing them as subclasses of Activity (see Typing via class hierarchies vs controlled vocabularies). 

The Contribution model introduces a design pattern not otherwise used in ARM: the use of predicates in the object position of an RDF triple. It is worth considering the pros and cons of adopting such a pattern. 

If the Contribution model is adopted, it will be necessary to identify vocabulary terms to replace all ARM Activity subclasses. We assume the use of MARC relators, with extension by other external or original vocabularies. Many of our models, e.g. the Custodial History model, will require the definition of new terms.

Note that questions in subsequent sections related to activities can be reframed in terms of contributions, so the activity vs contribution issue does not impact these issues. E.g., the question of a deeper activity class hierarchy can be reframed in terms of SKOS broader/narrower relationships.

Using events to correlate activities
----------------------------

We note in the [Custodial History](#custodial_history) section that events can be used to correlate related activities - e.g., a Sale event correlates Buyer and Seller Activities that would otherwise be unrelated other than acting on the same Item. In the case of multiple sales of a single object, the latter is clearly untenable. This seems to be a useful pattern and it is worth exploring broader applicability.

Activity class hierarchy
---------------------
Create a deeper Activity class hierarchy (e.g., ComposerActivity and AuthorActivity should be subclasses of CreatorActivity; all should be subclasses of ContributorActivity).

If the Contribution model is adopted, these relationships can be modeled with skos:broader/narrower for concept vocabularies, and rdfs:subPropertyOf assertions in the case of properties such as the MARC relators.

<a name="attributions">Attributions</a>
============
<a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/attributions.md">Modeling recommendation</a>

The current Attribution model describes the attribution of an activity, such as creator, to a resource, such as a work. This model could be extended to deal with a wider variety of use cases, as in the work begun by the bibliotek-o ontology group on Identity and Attribution, including cases of pseudonyms, name changes, deliberate misattribution, and so on. A final write-up of this work is forthcoming.
Possible modeling of confidence level of an attribution.

<a name="awards">Awards</a>
============
<a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/awards.md">Modeling recommendation</a>

<b>Awards Vocabulary</b>

An existing awards vocabulary should be located and/or an original one developed. In the absence of an awards vocabulary, award resources must be identified by rdfs:label or rdf:value strings, which, as free text, do not promote the goals of linked data. (However, this pattern can be a fallback for awards not defined in any vocabulary.)

<a name="citations">Bibliographic Citations</a>
==============
<a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/bibliographic_citations.md#future">Modeling recommendation</a>

<b>Integration with external ontologies</b>

The final recommendation proposes original terms to model a citation resource and its relationship to the cited resource. Earlier versions of this recommendation attempted differing levels of integration with the Citation Typing Ontology ([CiTO](http://www.sparontologies.net/ontologies/cito)), a [SPAR](http://www.sparontologies.net/) ontology focused on modeling citations. A second SPAR ontology, the Bibliographic Reference Ontology ([BiRO](http://www.sparontologies.net/ontologies/biro)), is also relevant to the bibliographic citations use case in RareMat. However, the precise relationship, if any, among RareMat citations, CiTO citations, and BiRO bibliographic references, and the potential for reuse or alignment, is an area that requires further research and clarification.

<a name="bindings">Bindings and Other Enclosures</a>
=====================
<a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/bindings.md">Modeling recommendation</a>

<b>Class hierarchy</b>
> - Bindings, unlike the other Enclosure subtypes, are not ordinarily removable (that is, by ordinary users as opposed to professionals in the process of conservation or other institutional activity), but we have as yet seen no use cases that require making such a distinction within the ontology. If such use cases arise, one can imagine partitioning Enclosure into Binding and RemovableEnclosure, with DustJacket, SlipCase, WrapAroundBand, and Wrapper as subclasses of the latter.
> - Define other types of Enclosures as the need arises.

<b>Enclosure-to-resource relationships</b>

Consider the possibility of defining new predicates enclosedBy/encloses rather than using bf:hasPart/bf:partOf for the relationship of a resource to its enclosure. Some of the enclosures, in particular the removable ones, are not intuitively “part” of the book - WrapAroundBand is a good example - but this is a semantically fuzzy area. Would there be any concrete gains to defining more specific predicates?

<b>Additional activities/roles</b>

The recommendation identifies a preliminary set of activities/roles related to bindings and enclosures. Consider others (e.g., GilderActivity), either specific to the enclosure domain or of broader applicability.

<b>Many-to-many item-to-binding relationships and the BinderActivity</b>

As discussed in the recommendation, the relationship of an Item to a Binding (or other Enclosure) is potentially many-to-many: (i) an Item can have multiple Bindings over its lifetime, and (b) a Binding, such as a treasure binding, can be removed from the original Item and transferred to another. While <a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/bindings.md#many-to-many-item-to-binding-relationships">the model provides for this</a>, it does not provide a way to specify the time period and/or sequencing of these relationships. Two descriptive options are:

> - Create a context node to model the relationship of Item to Enclosure, and attach dates and activities to it.
> - Apply a date to the BinderActivity. However, this only expresses the date on which the Binding was attached to the Item, not the time period during which they were attached, if that is important. One could also create a RemovalActivity, whose date, alongside the date of the BinderActivity, would indicate the interval of attachment. So a related question is whether there is independent need to record the removal of a Binding from an Item. 

Consider further the implications of the modeling of the BinderActivity (activity of attaching a Binding to an Item), in which the Activity is attached to two resources (the Binding and the Item) rather than one, as we have seen in all other ARM and bibliotek-o modeling. This is semantically more accurate than a single attachment to either the Binding or the Item alone, and is also required given the many-to-many relationships possible between Bindings and Items: a BinderActivity attached to a Binding (Item) must also specify which of possibly multiple Items (Bindings) was involved. 

On the other hand, if we define a context node, as above, then the BinderActivity can attach directly to the context node, with no need for a double connection to both Item and Binding.

Regardless of this decision, the dual connection pattern might be fruitful in other cases, both within and beyond the ARM domain. For example, the modeling of condition assessment and conservator activities in the <a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/physical_condition.md">Physical Condition recommendation</a> could be simplified by linking a ConditionAssessmentActivity to both an Item and a ConditionAssessment via the hasActivity/isActivity predicates; similarly for the relationship between ConservatorActivity, Item, and PhysicalCondition. This obviates the need for the specialized input and output relationships proposed in the recommendation.While the hasActivity/isActivityOf relationship is less specific than input and output, the precise semantics can be determined from the types of resources involved, as in many other instances. That is, as we have advocated in many contexts, predicates whose meaning incorporates the domain or range are redundant. E.g., a single predicate arm:covers can point to either a place or time, without the need to differentiate predicates for geographic or temporal coverage; the precise semantics of an assertion is derived from the type of its object. However, it is an open question when it is appropriate to define or use more specialized predicates and when to use more general predicates and rely on usage context to provide more nuanced semantics.

<a name="boundwiths">Bound-withs</a>
=============
<a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/carriers_and_bound_withs.md">Modeling recommendation</a>

The current recommendation applies only to bound-withs at the Item level, i.e., post-issuance. Consider extension or relationship to omnibus volumes and nonce collections (resources issued or re-issued together by the publisher).

<a name="carriers">Carriers</a>
=============
<a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/carriers_and_bound_withs.md">Modeling recommendation</a>

Consider modeling how a particular resource is affixed to its carrier (pasted, stapled, etc.). This is possibly an instrumentation/technique relationship on an affixation Activity (even if no other information is known about the Activity; note that such an Activity would be subject to the same considerations as BinderActivity), or it could be described as a direct relationship between the Item and its Enclosure. This may be a more general concern.

<a name="custodial_history">Custodial History</a>
=================
<a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/custodial_history.md">Modeling recommendation</a>

<b>CustodialHistory class</b>

How strong is the case for the CustodialHistory class? It is essentially a container for the various CustodialEvent pertaining to a resource. However, there may be assertions on the history as a whole that do not apply to a specific event, such as a note. A CustodialHistory node can also be used to store legacy custodial history data that has not been parsed into distinct CustodialEvents. We expect this question to be addressed by implementation of and experimentation with the model, and leave open the possibility of future deprecation.

In the particular case of <a href="https://github.com/ld4l-labs/vitrolib">VitroLib implementation</a>, it was observed that the CustodialHistory node caused some implementation difficulties which also highlighted a probably lack of utility. Since there is a 1-1, immutable relationship between Item and CustodialHistory, there is no point to it unless other attributes may be assigned. (This is not to suggest that the model should be constructed to fit particular applications, but is perhaps suggestive of unnecessary complexity in the model.)

<b>Public vs private data</b>

The current model leaves this as an implementation issue: implementers must determine how to handle sensitive data in their applications. This issue is not specific to provenance data but extends into other library and non-library data, and it may be part of a broader question of access privileges generally. Consider whether this information should be moved out of application logic into the data model.

<b>Concurrent and overlapping CustodialEvents</b>

The current model provides for dating and/or sequencing non-overlapping events. The need to model concurrent and overlapping events will arise in, for example the lending use case. Dates cannot be relied on for such modeling because they may not be known.

<b>Causality</b>

Consider use of a predicate such as frapo:hasOutput (as in the <a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/physical_condition.md">PhysicalCondition model</a>) to express a causal relationship to another event or state (e.g., a sale results in an ownership). This cannot always be determined from dating and sequencing, since (i) there can be gaps in the sequence, and (ii) contiguous sequencing does not necessarily involve causality: e.g., an ownership event may precede, but does not cause, a theft.

<b>Correlated activities</b>

The device of correlating interrelated Activities by linking them to Events rather than directly to the bibliographic resource itself certainly has broader applicability to other contexts, both within and beyond the bibilographic domain. bibliotek-o left unresolved the question of how to relate, say, a BuyerActivity and SellerActivity; gathering them under a single Event is a solution to this problem. The <a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/exhibitions.md">Exhibition model</a> provides other examples.

<b>Unary events</b>

The discussion of correlated events raises a question about the modeling of unary Events (i.e., Events with only a single Activity). The current model proposes that Activities always be linked directly to an Event, not to the Item or other resource. For Events that may have multiple attached Activities but only one is known, the current model is most appropriate; otherwise, a restructuring of the subgraph would be required to add an additional Activity.  But in the case of Events which inherently have only a single Activity, this results in redundant nodes for the sake of uniform modeling. This raises the question: are there such Events? Bequests and Donations appear to be candidates (but not Ownership, since there may be joint ownerships).  

This decision impacts the earlier discussion of the CustodialHistory class:  If Activities do not need to link directly to a CustodialEvent, then the CustodialHistory container class is required in order to fully reconstruct an Item’s custodial history and its sequencing - i.e., to distinguish Activities that are part of the resource’s custodial history from other sorts of activities.

<b>CustodialEvent class hierarchy</b>

<b>Individual vs Aggregate CustodialEvents</b>

Consider defining two subclasses of CustodialEvent, one for individual (single Item) and one for aggregate (multi-Item) events.
> - Originally the custodial history model distinguished aggregate from individual custodial events formally, using two different classes. We then decided that these resources would be profiled similarly, with properties and relationships such as activities, dates, locations, price, etc, and we collapsed them into a single class.
> - The primary difference between the two is that the individual event attaches directly to a an individual Item’s CustodialHistory, whereas the aggregate event does not, but attaches only to individual custodial events. This is a fundamental distinction in the semantics and the behavior, and the lack of a formal differentiation results in limitations and complications to both (SHACL) constraints and implementing applications.
In general it is not good practice to bend the ontology to suit the application, but in this case the difficulty posed for applications may well suggest a deficiency in the model. That is, in situations where they need to be distinguished, the application has to deduce whether an event is individual or aggregate based on whether it is attached directly to an Item’s CustodialHistory or not.
An example of an application complexity was noted in the development of VitroLib. When the user wants to add a bf:partOf relationship between an individual and an aggregate event, he/she should be presented with choices of only the aggregate type - which has no definition in the model and thus has to be inferred from its other associations.
> - The proposal would be to define a CustodialEvent class, with two subclasses, IndividualCustodialEvent and AggregateCustodialEvent. This provides for both the common profiling of the two types of custodial events and the important distinctions between them.
> - Note also that the aggregate CustodialEvent cannot have an accession number.

<b>CustodialEvent subclassing</b>

Currently the only hierarchical relationship among CustodialEvent subclasses is that Auction is defined as a subclass of Sale. Consider implementing a deeper class hierarchy in terms of the CustodialEvent subclasses. E.g., Transfer could be a superclass of Bequest, Donation, Sale, etc. 

<b>Static vs active CustodialEvents</b>

The current model distinguishes static CustodialEvents, such as Ownership, from active CustodialEvents, such as Sale, by the fact that only the latter subclass schema:Event. Would there be value in defining an intermediate subclass for StaticEvent? Would it be a subclass of CustodialEvent, or orthogonal to it, like schema:Event (i.e., some but not all StaticEvent types also subclass CustodialEvents)? Are there existing terms for this concept in other ontologies?

<b>Activity class hierarchy</b>
The general issue of a deeper Activity class hierarchy is raised above. In the particular case of CustodialEvent-related Activities, consider augmenting the class hierarchy by capturing general concepts of “giver” and “recipient” (for the latter, the RecipientActivity is already defined), and defining more specific activities such as SellerActivity, LenderActivity, TestatorActivity, etc. as “givers” and BuyerActivity, BorrowerActivity, InheritorActivity, etc. as subclasses of RecipientActivity. 

<b>Broader definition of CustodialEvents</b>

Consider expanding CustodialHistory to include non-provenance-related events, such as rebinding. Considerations:
> - May want to replace CustodialHistory with the broader term History, though "custody" defined as “the protective care or guardianship of someone or something" may be broad enough to encompass conservation activities as well. There might be other events in the history of a resource that do not fit under the definition of "custody," however.
> - What are the pros and cons of including non-custodial and custodial events in the same timeline?
> - Could provide another argument for allowing Activities to attach directly to the history, rather than requiring an intervening custodial or other event; otherwise, one would need to define events for all the activities in the physical condition model (and perhaps other models): condition assessment activity, conservator activity, etc. 
> - Would require confronting the issue of overlapping and concurrent events, since conservation activities provide a strong use case (e.g., rebinding during a period of ownership).

<b>Price</b>

schema:priceSpecification takes a literal value in 3-letter ISO 4217 format as its object, whereas we would like to use URIs if possible. Determine whether an RDF vocabulary for currencies exists, and consider whether it can be used as the object of schema:priceSpecification.
Price is only relevant to some types of CustodialEvents (e.g., Sale but not Donation). This could be modeled either with somewhat complex OWL restrictions, or is perhaps best left to SHACL constraints.

<b>Constraints between Activity and CustodialEvent types</b>

Some CustodialEvent types can be related to some Activity types and not others; currently this is indicated merely by annotations on the event classes. This could be modeled with either OWL restrictions in the ontology or SHACL constraints (see broader discussion of these alternatives above).

<b>Alignment with general event models</b>

Modeling of the full set of relationships that may obtain between bibliographic resources and events is well beyond the scope of the ARM ontology, but is needed for general bibliographic modeling. Possibly the CustodialEvent model could be aligned with a generalized event model. 

It is important to consider that not all CustodialEvents are “events” (specifically, the “static” events) and thus perhaps not directly subsumed in an event model. However, the patterning may be the same (dates, locations, agents, etc.).


<a name="exhibitions">Exhibitions</a>
=============
<a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/exhibitions.md">Modeling recommendation</a>

<b>Other exhibition types</b>

The model could be extended to other types of exhibitions, such as performance-based events and virtual (online) exhibitions.

<b>General event models</b>
Modeling the full set of relationships that may obtain between bibliographic resources and events is well beyond the scope of the ARM ontology, but is needed for general bibliographic modeling. This could be based on an existing event ontology, if a suitable one exists, but may need extension for the specific relationships that hold in the bibliographic context.

<a name="fonts">Fonts, Handwriting, and Notations</a>
================
<a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/fonts_handwriting_notations.md">Modeling recommendation</a>

<b>Relationship between writing systems, styles of writing, and languages</b>

Consider the relationships between writing systems (which we propose as a more semantically accurate term than bf:Script), fonts and handwriting styles, and languages. For instance, some writing systems can only be used in some languages, and some fonts are applicable only to some writing systems. As noted in previous contexts, such as custodial events and their activities, this could be modeled with ontology axioms or SHACL constraints.

<b>Other notation systems</b>

Consider other notation subtypes, both within the linguistic domain (e.g., shorthand), and beyond it (e.g., mathematical, chemical, and logical symbol systems).

<b>Miscellaneous</b>
> - Consider renaming HandwritingType to WritingHand. This clarifies the meaning and reflects the traditional terminology.
> - Are Handwriting resources reusable (like fonts)? Do two texts written by the same person with the same handwriting both have the same Handwriting resource? If so, clarify in the definition; e.g., “A specific example of handwriting found in one or more resources.”
> - Consider an Activity TypefaceDesigner; can enable search of all books written in typefaces designed by person X, for example. Is there a similar Activity (perhaps ScribeActivity) that can be attached to a Handwriting resource - i.e., the person whose handwriting it is?

<a name="genre">Genre/Form</a>
=============
(No modeling recommendation)

<b>Genre/Form vs Work subtypes</b>

ARM maps both "forms" and "genre" to bf:genreForm. Revisit this decision and decide which "form types" are better treated as subtypes of bf:Work. This is another instance of the general ontology class hierarchy vs. taxonomy issue. 


<a name="markings">Markings</a>
==============
<a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/markings.md">Modeling recommendation</a>

<b>Classes and predicates</b>
> - Define a full class hierarchy of Markings; relates to general issue of class hierarchies vs taxonomies.
> - Consider using bf:partOf/hasPart rather than arm:marks/markedBy.
> - Representing digital images of a marking. Possible predicates include rdf:value, foaf:depiction, perhaps others.

<b>Markings and marginalia</b>

The definition of arm:Marking is “A standardized symbol, notation, or other marking present in or applied to the materials of which an object is composed, or applied to an object during or after creation, conveying information such as the object's origin or maker, its authenticity, or a change in its official status.” This contrasts with “marginialia and other unofficial markings applied by individual users outside the creation or production process or custodial history of an object.” Hereafter, for clarity, we use the term “marking” for the first type, and “marginalia” for the second, even if these are not the most suitable terms. 

This distinction may be elusive. For example, a binding autograph by the binding designer may be distinguished from an autograph hand-written in a book, by an author, owner, gift-giver, etc., when transferring ownership to another agent. If we maintain the distinction, then we would define another class hierarchy for the second category of marking, which could include marginalia, hand-written dedications and autographs, bookplates, and others. 

The fact that some of the subclasses defined here cut across these two major types; e.g., Autograph, Stamp, and Seal can be of either type, suggests that two disjoint class hierarchies is artificial. 

The particular subclassing needs review. For example, arm:Inscription, defined as “Words, texts, lettering, or symbols written in manuscript on a resource” is a subclass of arm:Marking, but is better suited to marginalia.

Approaches that will not work:
> - Use the Marking classes to encompass both markings and marginalia, and rely on whether the related resource is an instance or item to make the distinction. This doesn’t work because, while the second type of marking is only at item-level, the first type of marking can be at either instance- or item-level.
> - Use the Marking classes to encompass both markings and marginalia, and rely on the creator to make the distinction. This doesn’t work because both can be applied by a creator: an autograph can be engraved on a binding by a binder or hand-written in pen when the author gives a book as a gift.

Possible approaches:
> - Use the Marking classes to encompass both markings and marginalia, and use different predicates to distinguish the two. E.g., markings could use bf:partOf/hasPart and arm:marks/markedBy could be for marginalia. It is intuitively plausible that the first type of marking but not the second be considered a “part” of the resource. Or we could define a different predicate ourselves.
> - Use the Marking model recommended here for markings and the <a href="https://www.w3.org/TR/annotation-model/">Web Annotation model</a> for marginalia. One example of that approach is <a href="http://library.princeton.edu/cams/ld4p">Princeton's Derrida Project</a>. The hand-written autograph would be an annotation with the item or some specific location on the item as a target. The annotation body would be the autograph (or whatever) itself, and could have a more detailed description attached with a note. 

<a name="materials">Materials</a>
============
<a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/materials.md">Modeling recommendation</a>

> - Can emulsion (bf:emulsion, bf:Emulsion) be integrated into the Materials model, or does it require different treatment?
> - Consider whether the hasAppliedMaterial predicate should actually connect the applied material to the base material rather than the object; that is more semantically accurate. Could there be layers of applied materials, each applied on top of the other? That couldn’t be captured by multiple hasAppliedMaterial assertions on the resource. (However, this would preclude the use of the RDAU predicate, which is defined as “Relates a resource to a physical or chemical substance applied to a base material of a resource.”)
> - The ARM model uses RDAU properties for “has applied material” and “has base material,” and defines arm:hasMaterial property, which cannot formally be defined as the super-property of the RDAU properties. Consider asking RDA to define this super-property in its own domain.
> - The recommendation provides for the type and color of material resources. What other attributes might they have? Texture? Matte vs. glossy? Or are those inherent properties of the material designated by the vocabulary term itself?

<a name="measurements">Measurements</a>
============
<a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/measurements.md">Modeling recommendation</a>

<b>Ontology reuse or alignment</b>

The ARM measurement model is quite intuitive, and one would expect that such an ontology has already been defined. The group explored other ontologies but did not identify one that fully satisfied all ARM descriptive needs. Continue this exploration, either for full re-use or alignment, and in particular reconsider the CIDOC-CRM model

<b>Measurements of specific arrangements of a resource</b>

As illustrated in Diagrams <a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/measurements.md#diagram-5-measurements-of-arrangement-arrangement-is-a-resource">5</a> and <a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/measurements.md#diagram-6-measurements-of-arrangements-multiple-arrangement-resources">6</a>, of the recommendation, when a MeasurementGroup applies to a specific arrangement of a resource, the model proposes that it is attached directly to the Arrangement and only indirectly to the resource itself. This creates an asymmetry between this and other scenarios, where the predicates hasMeasurementGroup/isMeasurementGroupOf link the MeasurementGroup directly to the Item, Instance, or other resource. One might propose an alternative model in which the MeasurementGroup is directly attached to the resource, as in other cases, and linked to the Arrangement, either using hasMeasurementGroup again, or via some other suitable predicate with the semantics "measures arrangement." However, the Arrangement nevertheless does need to attach directly to the resource, since it is a descriptor of the resource itself independent of, and in the absence of, any measurements. One could contemplate a triangular model in which each resource attaches directly (but redundantly) to both of the others, as in <a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/measurements.md#diagram-7-triangulated-resource-arrangement-and-measurement">Diagram 7</a>. The larger research question is whether introducing redundancy into a model for the sake of maintaining uniform modeling is preferable to maintaining asymmetric models to avoid redundancy, noting that redundancy creates data maintenance problems.

<a name="physcondition">Physical Condition and Conservation</a>
============
<a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/physical_condition.md">Modeling recommendation</a>

<b>Modeling input and output</b>

The modeling of condition assessment and conservator activities could be simplified by linking a ConditionAssessmentActivity to both an Item and a ConditionAssessment via the hasActivity/isActivity predicates; similarly for the relationship between ConservatorActivity, Item, and PhysicalCondition. This obviates the need for the specialized input and output relationships proposed in the recommendation. While the hasActivity/isActivityOf relationship is less specific than input and output, the precise semantics can be determined from the types of resources involved, as in many other instances. That is, as we have advocated in many contexts, predicates whose meaning incorporates the domain or range are redundant. E.g., a single predicate arm:covers can point to either a place or time, without the need to differentiate predicates for geographic or temporal coverage; the precise semantics of an assertion is derived from the type of its object. However, it is an open question when it is appropriate to define or use more specialized predicates and when to use more general predicates and rely on usage context to provide more nuanced semantics. This question also arises in relation to Bindings.

<b>Descriptions</b>

<a href="https://github.com/LD4P/arm/issues/27">See GitHub issue</a>.

Currently ARM defines two predicates, arm:describes/arm:describedBy, for the description of one resource by another (in particular, an arm:ConditionAssessment describes an Item). Consider deprecating these predicates and adopting one of the following alternatives:

> - Reuse dcterms:description, taking advantage of its flexibility as an rdf:Property to allow an entity as object in addition to a literal. One consideration: We may not want to muddy our application profiles in this way; initially we were clear that we want to profile an rdf:Property with either literal or entity values, but not both, and we have opted to use dcterms:description with literal values. 
> - Reuse dcterms:subject: The PhysicalCondition is the subject of the ConditionAssessment. This is preferable to the dcterms predicates due to closer alignment with BIBFRAME.

<a name="style_period">Style/Period</a>
============
<a href="https://github.com/LD4P/arm/blob/master/modeling_recommendations/style_period.md">Modeling recommendation</a>

Thanks to Vladimir Alexiev for several suggestions in this section.

<b>Reuse and alignment</b>

Consider alignment with or use of VRA Style/Period or other ontologies.


<b>Technique and instrumentation</b>

Consider the description of:
> - Relationships between technique and style/period. E.g., <a href="http://vocab.getty.edu/aat/300067450">pointillism</a> from the AAT Processes and Techniques Hierarchy, and <a href="http://vocab.getty.edu/aat/300021505">Neo-Impressionist</a> from the AAT Styles and Periods Hierarchy.
> - Relationships between technique and instrumentation - e.g., dry-point designates both an engraving tool and the intaglio technique that uses this tool. 

<b>Style/Period classes</b>
> - Do we need a class StylePeriod, or is it sufficent to use skos:Concept? 
> - If we keep the StylePeriod class: Should it subclass skos:Concept? Consider defining subclasses, such as ethnicity  (e.g.,  a Mayan stone inscription), dynasty (e.g.,  a Ming vase) or religion (e.g., a Christian Orthodox icon).

<b>Emulation/Attribution of Style/Period</b>

A work may emulate a style/period of an earlier time period. E.g., the early 20th-century composer Fritz Kreisler wrote pieces in the Baroque style. It would be interesting to use the Attribution model  to describe such cases, with the Attribution attached to the StylePeriod resource, and the creator as the agent of the Attribution.


<b>Style/Periods spanning multiple vocabulary terms</b>

In some cases it is not possible to identify a single vocabulary term for the style/period of a work; for instance, in the case of uncertain style/period, the cataloger may use a disjunction, such as “Ming or Qing dynasty,” or a range, such as “Muromachi to Momoyama periods,” indicating somewhere within the designated time period. Currently these will be modeled as an rdf:value or rdfs:label on a StylePeriod individual (rdf:value is preferred because it has semantic weight). 

The disjunction could be modeled with skos:narrower pointing at two vocabulary terms: the concept “Ming or Qing” is broader than the terms for Ming dynasty and Qing dynasty. But do the skos:narrower assertions sufficiently capture the precise semantics of the disjunction?  Is it more appropriate to use rdf:value, rdfs:label, or dcterms:description? rdfs:label has no semantic weight; however, the disjunction is used to express unknown or limited information for human readers, so it may be appropriate.


