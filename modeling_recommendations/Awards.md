Awards
================
ArtFrame, 2017-11-17

Summary Recommendation 
-----------------------

Table of Contents
> - [Overview](#overview)
> - [Awards in BIBFRAME](#bfawards)
> - [Recommendations for Moving Forward](#recommendations)
> - [Involved Classes](#classes)
> - [Involved Properties](#properties)
> - [Diagram](#diagram)
> - [Examples](#examples)


<a name="overview">Overview</a>
--------

Many artists, artworks or art related publications represented in our library collections are recipients of awards. 
Being able to find all the resources connected to a specific award within one collection or across different collections 
has been identified as a critical use case ([*https://wiki.duraspace.org/display/LD4P/ArtFrame?preview=/79795202/83235173/PublicUseCases.pdf*](https://wiki.duraspace.org/display/LD4P/ArtFrame?preview=/79795202/83235173/PublicUseCases.pdf))by the ArtFrame group. An award could be given to a creator for a specific work 
(in which case the award would need to be associated with that work) or it could be a career achievement award that can only 
be associated with the agent, but not with a specific work.


The ArtFrame group considered the inclusion of awards in the LD4P event model (tbd), but decided that for the ArtFrame use case 
the actual event, e.g. an awards ceremony, is not what is considered important. It is sufficient to say that a specific work or 
agent received a specific award on a given date.

In the traditional MARC environment, catalogers have recorded award information in the Awards note: 586. ([*http://www.loc.gov/marc/bibliographic/bd586.html*](http://www.loc.gov/marc/bibliographic/bd586.html)) Access points related 
to awards are generally coded as LC subject headings (150 with a 550 Art--Awards), however these LCSH terms are applied to 
resources about that award, not to those receiving an award. The content standard RDA covers awards in 7.28. The instructions 
are limited to “Record information on an award if considered important for identification or selection.” The examples reflect a 
note style. The RDA registry provides a property rdau:P60090. ([*http://metadataregistry.org/schemaprop/show/id/14686.html*](http://metadataregistry.org/schemaprop/show/id/14686.html))


In BIBFRAME a property bf:awards is available. However, bf:awards is a datatype property and therefore carries the MARC practice 
forward to record related information in a text string. It does currently not allow for linking out to awards, for example in 
Wikidata (e.g. Sobey Art Award) ([*https://www.wikidata.org/wiki/Q7549952*](https://www.wikidata.org/wiki/Q7549952)).
The VIVO ontology has a class vivo:Award ([*http://vivoweb.org/sites/vivoweb.org/files/vivo-isf-public-1.6.owl#Award*](http://vivoweb.org/sites/vivoweb.org/files/vivo-isf-public-1.6.owl#Award))and related properties, however those tend to have ranges limiting their use to foaf:Agent or foaf:Organization.

The art specific standards and ontologies that were investigated do not specifically address the issue of awards.

<a name="bfawards">Awards in BIBFRAME</a>
============
Properties
---------
**bf:awards**
> - **Label**: Award note
> - **URI**: http://id.loc.gov/ontologies/bibframe/awards
> - **Definition**: Information on awards associated with the described resource.
> - **Used with**: Work or Instance
> - **Range**: Literal

<a name="recommendations">Recommendations for Moving Forward</a>
===========================

The proposed Awards model for ArtFrame is in part based on the award classes and properties developed for the LD4L 2014 Ontology ([*https://www.ld4l.org/ld4l-2014/ontology*](https://www.ld4l.org/ld4l-2014/ontology)) and a proposal developed for bibliotek-o that remained unfinished due to time constraint. However, these models were adjusted and extended to accommodate use cases and data examples identified by the ArtFrame group.

Classes
---------
**Award**
> - **Label**: Award or Honor
> - **URI**: http://vivoweb.org/ontology/core#Award
> - **Definition**: An award or honor

**Activity**
> - **Label**: Activity
> - **URI**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: An activity or contribution by a single agent that affects or alters the existence or state of a resource.

**SelectorActivity**
> - **Label**: Award Selector
> - **URI**: TBD
> - **Definition**: The activity of nominating or judging a resource in relation to an award, honor, etc.
> - **scopeNote**: This class is not derived from a MARC relator.
> - **Subclass of**: bib:Activity

**AwardGranterActivity**
> - **Label**: Award Granter
> - **URI**: TBD
> - **Definition**: The activity of granting an award.
> - **scopeNote**: This class is not derived from a MARC relator.
> - **Subclass of**: bib:Activity

**AwardReceipt**
> - **Label**: Award Receipt
> - **URI**: TBD
> - **Definition**: The bestowal of an award, honor, or distinction to an Agent or Work. The award bestowed should be represented with the Award class. The AwardReceipt is a context node between the award and the recipient which may contain further information, such as date.

**AwardWinner**
> - **Label**: Award Winner
> - **URI**: TBD
> - **Definition**: The specific nature of the award receipt is award winner.
> - **Subclass of**: af:AwardReceipt

**AwardShortlist**
> - **Label**: Award Shortlist
> - **URI**: TBD
> - **Definition**: The specific nature of the award receipt is award shortlist.
> - **Subclass of**: af:AwardReceipt

**AwardHonoraryMention**
> - **Label**: Award Honorary Mention
> - **URI**: TBD
> - **Definition**: The specific nature of the award receipt is honorary mention.
> - **Subclass of**: af:AwardReceipt

**AwardNominee**
> - **Label**: Award Nominee
> - **URI**: TBD
> - **Definition**: The specific nature of the award receipt is nominee.
> - **Subclass of**: af:AwardReceipt

**AwardCitation**
> - **Label**: Award Citation
> - **URI**: TBD
> - **Definition**: The specific nature of the award receipt is citation.
> - **Subclass of**: af:AwardReceipt

**AwardLonglist**
> - **Label**: Award Longlist
> - **URI**: TBD
> - **Definition**: TThe specific nature of the award receipt is longlist.
> - **Subclass of**: af:AwardReceipt

Propertoes
---------
**received (object property)**
> - **Label**: received
> - **URI**: TBD
> - **Definition**: This Agent or Work is the recipient of the specified AwardReceipt
> - **Domain**: unspecified
> - **Inverse**: af:receivedBy

> - **Range**: af:AwardReceipt>
