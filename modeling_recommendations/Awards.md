Awards
================
ArtFrame, 2017-11-17

Summary Recommendation 
-----------------------

Table of Contents
> - [Overview](#overview)
> - [Background](#background)
> - [Recommendations for Moving Forward](#recommendations)
> - [Relevant ArtFrame Use Case](#useCase)
> - [Titles in MARC](#MARC)
> - [Titles in BIBFRAME](#BIBFRAME)
> - [Titles in bibliotek-o](#bibliotek-o)
> - [Side-by-Side Examples](#examples)


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

In the traditional MARC environment, catalogers have recorded award information in the Awards note: 586. ([*http://www.loc.gov/marc/bibliographic/bd586.html*](http://www.loc.gov/marc/bibliographic/bd586.html))Access points related 
to awards are generally coded as LC subject headings (150 with a 550 Art--Awards), however these LCSH terms are applied to 
resources about that award, not to those receiving an award. The content standard RDA covers awards in 7.28. The instructions 
are limited to “Record information on an award if considered important for identification or selection.” The examples reflect a 
note style. The RDA registry provides a property rdau:P60090. ([*http://metadataregistry.org/schemaprop/show/id/14686.html*](http://metadataregistry.org/schemaprop/show/id/14686.html))


In BIBFRAME a property bf:awards is available. However, bf:awards is a datatype property and therefore carries the MARC practice 
forward to record related information in a text string. It does currently not allow for linking out to awards, for example in 
Wikidata (e.g. Sobey Art Award) ([*https://www.wikidata.org/wiki/Q7549952*](https://www.wikidata.org/wiki/Q7549952)).
The VIVO ontology has a class vivo:Award ([*http://vivoweb.org/sites/vivoweb.org/files/vivo-isf-public-1.6.owl#Award*](http://vivoweb.org/sites/vivoweb.org/files/vivo-isf-public-1.6.owl#Award))and related properties, however those tend to have ranges limiting their use to foaf:Agent or foaf:Organization.

The art specific standards and ontologies that were investigated do not specifically address the issue of awards.
