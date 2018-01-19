Award
================
ArtFrame, 2017-11-17

Summary Recommendation 
-----------------------

Table of Contents
> - [Overview](#overview)
> - [Awards in BIBFRAME](#bfawards)
> - [Recommendations for Moving Forward](#recommendations)
> - [Diagram](#diagram)
> - [Examples](#examples)


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

<a name="recommendations">Recommendations</a>
===========================

The proposed Award model for ArtFrame is in part based on the award classes and properties developed for the LD4L 2014 Ontology ([*https://www.ld4l.org/ld4l-2014/ontology*](https://www.ld4l.org/ld4l-2014/ontology)) and a proposal developed for bibliotek-o that remained unfinished due to time constraint. However, these models were adjusted and extended to accommodate use cases and data examples identified by the ArtFrame group.

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

**AwardSelectorActivity**
> - **Label**: Award selector
> - **URI**: TBD
> - **Definition**: The activity of nominating or judging a resource in relation to an award, honor, etc.
> - **scopeNote**: This class is not derived from a MARC relator.
> - **Subclass of**: bib:Activity

**AwardGranterActivity**
> - **Label**: Award granter
> - **URI**: TBD
> - **Definition**: The activity of granting an award.
> - **scopeNote**: This class is not derived from a MARC relator.
> - **Subclass of**: bib:Activity

**AwardReceipt**
> - **Label**: Award receipt
> - **URI**: TBD
> - **Definition**: The bestowal of an award, honor, or distinction to an Agent or Work. The award bestowed should be represented with the Award class. The AwardReceipt is a context node between the award and the recipient which may contain further information, such as date.

**AwardWinner**
> - **Label**: Award winner
> - **URI**: TBD
> - **Definition**: The specific nature of the award receipt is award winner.
> - **Subclass of**: af:AwardReceipt

**AwardShortlist**
> - **Label**: Award shortlist
> - **URI**: TBD
> - **Definition**: The specific nature of the award receipt is award shortlist.
> - **Subclass of**: af:AwardReceipt

**AwardHonoraryMention**
> - **Label**: Award honorary mention
> - **URI**: TBD
> - **Definition**: The specific nature of the award receipt is honorary mention.
> - **Subclass of**: af:AwardReceipt

**AwardNominee**
> - **Label**: Award nominee
> - **URI**: TBD
> - **Definition**: The specific nature of the award receipt is nominee.
> - **Subclass of**: af:AwardReceipt

**AwardCitation**
> - **Label**: Award citation
> - **URI**: TBD
> - **Definition**: The specific nature of the award receipt is citation.
> - **Subclass of**: af:AwardReceipt

**AwardLonglist**
> - **Label**: Award longlist
> - **URI**: TBD
> - **Definition**: The specific nature of the award receipt is longlist.
> - **Subclass of**: af:AwardReceipt

Properties
---------
**received (object property)**
> - **Label**: received
> - **URI**: TBD
> - **Definition**: This resource, such as an Agent or Work, is the recipient of the specified AwardReceipt
> - **Domain**: unspecified
> - **Inverse**: af:receivedBy
> - **Range**: af:AwardReceipt

**receivedBy (object property)**
> - **Label**: received by
> - **URI**: TBD
> - **Definition**: This AwardReceipt was received by the specified award recipient (such as an Agent or Work).
> - **Domain**: af:AwardReceipt
> - **Range**: unspecified
> - **Inverse**: af:received

**hasAward (object property)**
> - **Label**: has award
> - **URI**: TBD
> - **Definition**: This resource is a receipt of the specified award or honor.
> - **Domain**: af:AwardReceipt
> - **Range**: af:Award
> - **Inverse**: af:isAwardOf

**isAwardOf (object property)**
> - **Label**: is award of
> - **URI**: TBD
> - **Definition**: Links a specified award or honor to its receipt.
> - **Domain**: af:Award
> - **Range**: af:AwardReceipt
> - **Inverse**: af:hasAward

**dcterms:date**
> - **Label**: Date
> - **URI**: http://purl.org/dc/terms/date
> - **Definition**: A point or period of time associated with an event in the lifecycle of the resource.

**hasAgent (Object property)**
> - **Label**: has Agent
> - **URI**: http://bibliotek-o.org/1.1/ontology/hasAgent
> - **Definition**: Relates an activity to its agent.
> - **Inverse**: bib:isAgentOf

**isAgentOf (Object property)**
> - **Label**: is Agent of
> - **URI**: http://bibliotek-o.org/1.1/ontology/isAgentOf
> - **Definition**: Relates an Agent to an Activity they participated in.
> - **Domain**: bf:Agent
> - **Inverse**: bib:hasAgent

**hasActivity (Object property)**
> - **Label**: has activity
> - **URI**: http://bibliotek-o.org/1.1/ontology/hasActivity
> - **Definition**: Relates this resource to an activity or contribution by a single agent that affects or alters its existence  
                    or state.
> - **Inverse**: bib:isActivityOf

**isActivityOf (Object property)**
> - **Label**: is activity of
> - **URI**: http://bibliotek-o.org/1.1/ontology/isActivityOf
> - **Definition**: Relates an activity to the affected resource.
> - **Inverse**: bib:hasActivity

<a name="Diagram">Diagram</a>
===========

![Award model diagram](/modeling_recommendations/modeling_diagrams/Awards2.jpg)

<a name="examples">Examples</a>
--------

> - **586 (awards note): Man Booker Prize, 1987, shortlist -- BIBFRAME**
```

:w1 a bf:Work ;
bf:awards "Man Booker Prize, 1987, shortlist" .

```
> - **586 (awards note): Man Booker Prize, 1987, shortlist -- biblioteko/ArtFrame**
```
:chatterton a bf:Work ;
 af:received :awardReceipt1 .

:awardReceipt1 a af:AwardReceipt, af:AwardShortlist ;
af:hasAward :award1 ;
 af:receivedBy :chatterton ;
 dcterms:date "1987" .

:award1 a vivo:Award ;
 rdfs:label "Man Booker Prize" .

```
> - **586 (awards note): George Wittenborn Award, Art Libraries Society of North  America, 1998 -- BIBFRAME**
```
w1 a bf:Work ;
bf:awards "George Wittenborn Award, Art Libraries Society of North  America, 1998" .

```
> - **586 (awards note): George Wittenborn Award, Art Libraries Society of North  America, 1998 -- biblioteko/ArtFrame**
```
:Ikat a bf:Work ;
 af:received :awardReceipt1 .

:awardReceipt1 a af:AwardReceipt, af:AwardWinner  ;
 af:hasAward :award1 ;
 af:receivedBy :Ikat ;
 dcterms:date "1998" ;
 bib:hasActivity :activity1 .

:award1 a vivo:Award ;
 rdfs:label "George Wittenborn Award" .

:activity1 a af:AwardGranterActivity ;
 bib:hasAgent <http://id.loc.gov/row/agents/n82039281> .

```
> - **586 (awards note): Smith Award, Decorative Arts Society, 2006, for the essay,  "The most artistic house in New York City" -- BIBFRAME**
```
w1 a bf:Work ;
bf:title :t1 ;
bf:partOf :w2 ;
bf:awards "Smith Award, Decorative Arts Society, 2006” .

:t1 a bf:Title ;
rdfs:label "The most artistic house in New York City" ;
bf:mainTitle "The most artistic house in New York City" .

:w2 a bf:Work ;
bf:title :t2 ;
bf:hasPart :W1 .

:t2 a bf:Title ;
rdfs:label "Louis Comfort Tiffany and Laurelton Hall" ;
bf:mainTitle "Louis Comfort Tiffany and Laurelton Hall" .

```
> - **586 (awards note): Smith Award, Decorative Arts Society, 2006, for the essay,  "The most artistic house in New York City" -- biblioteko/ArtFrame**
```
:w1 a bf:Work ;
 dcterms:isPartOf :w2 ;
 af:received :awardReceipt1 .

:awardReceipt1 a af:AwardReceipt, af:AwardWinner ;
 af:hasAward :award2 ;
 af:receivedBy :w1 ;
 dcterms:date "2006" ;
 bib:hasActivity :activity1 .
 
:award2 a vivo:Award ;
 rdfs:label "Smith Award" .

:activity1 a af:AwardGranterActivity ;
 bib:hasAgent :agent1 .

:agent1 a bf:Organization ;
 rdfs:label "Decorative Arts Society" .

```
> - **Someone talked! (Poster) "Winner R. Hoe & Co., Inc. Award - National War Poster Competition. -- BIBFRAME**
```
:w a bf:Work ;
bf:award "Winner R. Hoe & Co., Inc. Award - National War Poster Competition."

```
> - **Someone talked! (Poster) "Winner R. Hoe & Co., Inc. Award - National War Poster Competition. -- biblioteko/ArtFrame**
```
:SomeoneTalked! a bf:Work ;
 af:received :awardReceipt1 .

:awardReceipt1 a af:AwardReceipt, af:AwardWinner ;
 af:hasAward :award1 ;
 af:receivedBy :SomeoneTalked! .

:award1 a vivo:Award ;
 rdfs:label "R. Hoe & Co., Inc. Award--National War Poster Competition" .

```
> - **Award selector/judge -- biblioteko/ArtFrame**
```
:MurrayHill a bf:Person ;
 :received :awardReceipt.

:awardReceipt a af:AwardReceipt, a af:AwardWinner ;
 af:isReceiptOf :AnnualContemporaryCrafExhibitionforGlass ;
 af:receivedBy :MurrayHill ;
 dcterms:date "1987" ;
 bib:hasActivity :activity1, :activity2 .

:activity1 a af:SelectorActivity ;
 bib:hasAgent <http://id.loc.gov/row/agents/no2003101967> .

:activity2 a af:AwardGranterActivity ;
 bib:hasAgent :agent2 .
