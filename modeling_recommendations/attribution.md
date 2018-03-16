Attribution
===============
ArtFrame, March 16, 2018

**Table of Contents**
- [Background](#background)
- [Recommendations for Moving Forward](#recommendations)
  - [Recommended Classes](#classes)
  - [Recommended Properties](#properties)
- [RDF Sample](#rdf)
- [Diagram](#diagram)

<a name="background">Background</a>
-----------
The attribution of a work to a specific creator is an important concept in art cataloging. An attribution can be defined as the 
activity of “ascribing a work to a particular artist or school of artists” [*aat*](http://www.getty.edu/vow/AATFullDisplay?find=attribution&logic=AND&note=&english=N&prev_page=1&subjectid=300056109).
This attribution may change over time as new research becomes available. In the MARC 21 standard this has so far been handled by 
adding subfield j (attribution qualifier) to the 1xx field in the bibliographic record. The MARC Relator Terms contain “Attributed 
name” (http://id.loc.gov/vocabulary/relators/att) for use in this subfield. However, the ArtFrame group felt that attributions 
behaves somewhat differently from other relators such as artist or author. BIBFRAME and the conversion specifications made public 
by the Library of Congress have not yet addressed this concept.

<a name="recommendations">Recommendations for Moving Forward</a>
---------------------------

This model proposes a new object property (ex:hasAttribution) and a class (ex:Attribution). Necessary information such as dates of 
the attribution; agent responsible for making the attribution and/or the source on which this attribution is based can associated 
directly with this Attribution node. Complex information that cannot easily be expressed in structured form should be recorded in 
a bf:Note.

<a name="classes">Recommended Classes</a>
-----------

**ex:Attribution**
> - **Label:** Attribution
> - **IRI:** TBD
> - **Definition:** The activity of ascribing a work to a particular agent or agents. This attribution may change over time 
                    based on new evidence.

**ex:Activity**
> - **Label:** Activity
> - **IRI:** TBD
> - **Definition:** An activity or contribution by a single agent that affects or alters the existence or state of a resource.

**ex:ArtistActivity**
> - **Label:** Artist
> - **IRI:** TBD
> - **Definition:** The activity of creating a work by conceiving, and implementing, an original graphic design, drawing, 
                    painting, etc. For book illustrators, prefer IllustratorActivity.
> - **Subclass of:** ex:Activity
> - **Editorial note:** Future work: consider more formal alignment between the class and corresponding MARC relator.
> - **Scope note:** This class is derived from the MARC relator: http://id.loc.gov/vocabulary/relators/art.

*NB:* ex:ArtistActivity is listed as one example of an activity that can be associated with ex:hasAttribution. Other activities 
may be used as provided by the ontology.

**bf:Agent**
> - **Label:** Agent
> - **IRI:** http://id.loc.gov/ontologies/bibframe/Agent
> - **Definition:** Entity having a role in a resource, such as a person or organization.

**bf:Note**
> - **Label:** Note
> - **IRI:** http://id.loc.gov/ontologies/bibframe/Note
> - **Definition:** Information, usually in textual form, on attributes of a resource or some aspect of a resource.

<a name="properties">Recommended Properties</a>
-----------

**ex:hasAttribution (object property)**
> - **Label:** has attribution
> - **IRI:** TBD
> - **Definition:** The attribution of an activity of ascribing a work to a particular agent or agents.
> - **Range:* ex:Attribution
> - **Inverse:** ex:isAttributionOf

**ex:isAttributionOf (object property)**
> - **Label:** is attribution of
> - **IRI:** TBD
> - **Definition:** Links the attribution to the activity of ascribing a work to a particular agent or agents.
> - **Domain:* ex:Attribution
> - **Inverse:** ex:hasAttribution

**bf:agent (object property)**
> - **Label:** Associated agent
> - **IRI:** http://id.loc.gov/ontologies/bibframe/agent
> - **Definition:** Entity associated with a resource or element of description, such as the name of the entity responsible for 
                    the content or of the publication, printing, distribution, issue, release or production of a resource.
> - **Comment** Used with Unspecified.
> - **Range:** bf:Agent

**ex:hasActivity (object property)**
> - **Label:** has activity
> - **IRI:** TBD
> - **Definition:** Relates this resource to an activity or contribution by a single agent that affects or alters its existence 
                    or state.
> - **Range** ex:Activity
> - **Inverse:** ex:isActivityOf

**ex:isActivityOf (object property)**
> - **Label:** is activity of
> - **IRI:** TBD
> - **Definition:** Relates an activity to the affected resource.
> - **Domain:* ex:Activity
> - **Inverse:** ex:hasActivity

**bf:date (object property)**
> - **Label:** Date
> - **IRI:** http://id.loc.gov/ontologies/bibframe/date
> - **Definition:** Date designation associated with a resource or element of description, such as date of title variation; 
                    year a degree was awarded; date associated with the publication, printing, distribution, issue, release or 
                    production of a resource. May be date typed.
> - **Comment** Used with Unspecified.

**ex:hasSource (object property)**
> - **Label:** has source
> - **IRI:** TBD
> - **Definition:** Relates this resource to the source from which it was derived.
> - **Comment:** Has general applicability to many types of sources and resources.
> - **Inverse:** ex:isSourceOf

**ex:isSourceOf (object property)**
> - **Label:** is source of
> - **IRI:** TBD
> - **Definition:** Relates this resource to a resource of which it is the source.
> - **Comment:** Has general applicability to many types of sources and resources.
> - **Inverse:** ex:hasSource

**bf:note (object property)**
> - **Label:** Note
> - **IRI:** http://id.loc.gov/ontologies/bibframe/note
> - **Definition:** General textual information relating to a resource, such as Information about a specific copy of a resource 
                    or information about a particular attribute of a resource.
> - **Comment:** Used with Unspecified.
> - **Range:** bf:Note

<a name="rdf">RDF Sample</a>
-----------

```
:work a bf:Work ;
    ex:hasActivity :artistActivity .

 :artistActivity a ex:ArtistActivity ;
      bf:agent :artist ;
      ex:hasAttribution :attribution .
:attribution a ex:Attribution ;
    bf:agent :attributor ;
    bf:date "2017" ;
    ex:hasSource :source ;
    bf:note :note .

:note1 a bf:Note ;
    rdf:value "Some text about the attribution" .

```
<a name="diagram">Diagram</a>
-----------
![Attribution](/modeling_recommendations/modeling_diagrams/attribution_diagram_2.png)
