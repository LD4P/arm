Style/Period
============

ArtFrame and RareMat, 2018.03.16

Introduction
-----------
According to CCO, style designation “identifies the named, defined style, historical or artistic period, movement, group, or school whose characteristics are represented in the work being cataloged”; style information is based on scholarship in fields such as art history, cultural studies and archeology. As such, it represents a key concept by which specialists categorize cultural objects. Content and data structure standards in museology—including VRA Core, CCO, CDWA, CIDOC CRM, and LIDO—have provisions allowing catalogers to qualify an object by its artistic style. However, no field was ever defined in the MARC format to accommodate style, nor is there a specific class or property in BIBFRAME, which has largely been designed to move our existing library data into linked data. 

Though certain metadata standards, such as the CHIN Data Dictionary, allow catalogers to record style information as a work and/or creator attribute, we believe style should be defined for the work rather than the creator, since an artist may adopt several different styles during his/her career.

Relationship of Style/Period to Culture and Nationality
------------

Stylistic information is closely related to the cultural context of the work, since a style or period may be characteristic of a given culture (e.g. Minoan Style, Spanish Colonial Style, Olmec Style).  

Art cataloguing standards have dealt with culture and nationality in various ways. In general, culture and nationality are considered attributes of the agent and should be recorded as such. In the case of nationality this is uncontroversial, since by definition only persons can have nationality. However, culture can at times be considered an attribute of a work, for example,  cultural objects created by a group of people, or a work deliberately created by an artist in the style of a culture that is not his/her own. The attribution of culture in these cases is more closely aligned with style; to the extent that culture adheres to a work, it can be captured by the concept of Style/Period. This group therefore recommends the usage of ex:hasStylePeriod for recording cultural-related information in the work context, and reserves direct attribution of nationality and culture to agents.  

Sample Data
-----------
"late 17th-century English binding"

2 examples from CCO:

```Class [controlled]: • decorative arts  • Islamic art  • murals
Work Type [link]: • mosaic
Title: Tile Mosaic Panel
Creator Display: Persian
Role [link]: artist  [link]: Persian
Creation Date: 16th century  [controlled]: • Earliest: 1500  • Latest: 1599
Subject [links]: • interior architecture  • star medallions  • palmettes  • vases
Style [link]: Safavid dynasty
Culture [link]: Persian
Current Location [link]: Philadelphia Museum of Art (Philadelphia, Pennsylvania, USA)  • ID: 1931-76-1
Creation Location [link]: Esfahan (Persia)
Measurements: 106.68 cm height (42 inches)
[controlled]  • Value: 106.68 Unit: cm Type: height
Materials and Techniques:  glazed pottery 
Material [links]: • terracotta  Technique [links]: • glazing
Description: Created during the reign of the Safavid court at Esfahan in Persia. The panel may have come from a monastery of the Sufi branch of Islam. Glazed turquoise, cobalt blue, beige, white, and black colors form a pattern dominated by star medallions and floral palmettes in vases.
Description Source [link]: Philadelphia Museum of Art. Handbook of the Collections.Philadelphia: Philadelphia Museum of Art, 1986.  Page: 64>
```
```Class [controlled]: • paintings  • South American art
Work Type [link]: • painting
Title: Saint Ursula Receiving the Martyr’s Crown from an Angel  Title Type:translated
Title: Santa Úrsula recibe de un ángel la corona del martirio Title Type: repository
Creator Display:  unknown Colombian
Role [link]: painter  [link]: unknown Colombian
Creation Date: 17th century   [controlled]: • Earliest: 1600  • Latest: 1699
Subject [links]: • religion and mythology  • Saint Ursula (Christian iconography)  • martyrdom  • angel  • crown
Style [link]: Spanish Colonial
Culture [link]: Colombian
Current Location [link]: Museo Nacional de Colombia (Bogotá, Colombia)  • ID:23.8.1951
Measurements: 44.5 x 63.8 cm (17 1/2 x 25 1/8 inches)
[controlled]:  • Value: 44.5 Unit: cm Type: height  |  • Value: 63.8 Unit: cm Type: width 
Materials and Techniques: oil on panel
Material [links]: • oil paint  • panel (wood)  Technique [links]: • painting
```
 


Style/Period in BIBFRAME
------------
There is no modeling of Style/Period in BIBFRAME.

Overview of the RareMat/ArtFrame Style/Period Model
----------
The RareMat/ArtFrame Style/Period model is quite simple, involving a class, StylePeriod, and two predicates, hasStylePeriod and isStylePeriodOf. The range of hasStylePeriod and domain of isStylePeriodOf are left unspecified so that vocabularies (such as AAT) can be used without unwanted type entailments.

Term Specifications
---------------

Classes
========
**ex:StylePeriod**
> - **URI:** TBD
> - **Label:** Style/Period
> - **Definition:** A defined style, historical period, group, school, dynasty, movement, nationality, culture, etc. whose characteristics are represented in the work. 


Properties
==========

**ex:hasStylePeriod** (object property)
> - **URI:** TBD
> - **Label:** has style/period
> - **Definition:** A resource’s relationship to a style/period it represents.
> - **Domain:** unspecified
> - **Range:** unspecified
> - **Inverse:** ex:isStylePeriodOf
> - **Editorial note:** Range is unspecified to allow values from controlled vocabularies not typed as ex:StylePeriod.

**ex:isStylePeriodOf** (object property)
> - **URI:** TBD
> - **Label:** is style/period of
> - **Definition:** A style/period’s relationship to a resource representing it.
> - **Domain:** unspecified
> - **Range:** unspecified
> - **Inverse:** ex:hasStylePeriod
> - **Editorial note:** Domain is unspecified to allow subjects from controlled vocabularies not typed as ex:StylePeriod.

Note: Range of hasStylePeriod and domain of isStylePeriodOf remain unspecified so that vocabularies can be used without unwanted entailments.

Diagram
-----------

![Style and Period diagram](/modeling_recommendations/modeling_diagrams/style_period.png)

Sample RDF
--------
```
:work a bf:StillImage ;
    bf:title :title ;
    ex:hasStylePeriod <http://vocab.getty.edu/aat/300172863> .

:title rdf:value “Atala et Chactas” .
``` 

Areas for Future Research
---------
- Alignment with or use of VRA Style/Period or other ontologies.
- Modeling of technique and instrumentation. 
> - In some cases there are relationships between technique and style/period. E.g., <a href="http://vocab.getty.edu/aat/300067450">pointillism</a> from the Processes and Techniques Hierarchy, and <a href="http://vocab.getty.edu/aat/300021505">Neo-Impressionist</a> from the Styles and Periods Hierarchy.  
> - There are frequently relationships between technique and instrumentation - e.g., dry-point designates both an engraving tool and the intaglio technique that uses this tool. How should these be modeled?
> - BIBFRAME defines bf:productionMethod and bf:ProductionMethod, but these apply at the instance level and are therefore not applicable to the current context.
- Modeling of culture and nationality in relation to an agent as suggested above.
- Modeling of a work that emulates a style/period of an earlier time period. E.g., the early 20th-century composer Fritz Kreisler wrote pieces in the Baroque style.




