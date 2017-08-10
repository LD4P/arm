#Accession Number

April 20, 2017

Summary Recommendation 
-----------------------

-   Create new sub-class bf:AccessionNumber as subclass of bf:Identifier to be used within the approved bibliotek-o [*Identifier*](https://wiki.duraspace.org/display/LD4P/bibliotek-o?preview=/79795231/83237327/bibliotek-o_pattern_identifiers_201612.pdf) pattern.
	-	Note: LC accepted this recommendation and plan to create the bf:AccessionNumber class as a subclass of bf:Identifier

Justification
-------------
Accession numbers are an important identifier for cultural heritage institutions to record and track an object in their collections. These numbers are also useful in the provenance of an object. BF2 does not explicit way to record accession numbers that are currently being recorded in MARC 541 \$e. This issue was discussed during the Rare Material and ArtFrame Ontology Spring on March 2-3, 2017, and it was determined that accession numbers are an essential identifier and must have some way recording this information in a linked data ontology for cultural heritage and rare materials.

CIDOC-CRM
---------

CIDOC-CRM has a way to record associated identifiers with an object, and
accession numbers could fall into this pattern.

![CIDOC-CRM AccessionNumber RDF-XML](/modeling_recommendations/modeling_diagrams/accession_number_cidoc-crm.png)

However, introducing second pattern for recording identifiers into the
bibliotek-o ontology would not be the ideal modeling. So it was
determined to work with the current Identifier pattern, and create a new
subclass AccessionNumber.

**bibliotek-o Identifier Model**
============================
![Accession Number Diagram](/modeling_recommendations/modeling_diagrams/accession_number_diagram.png)

_:item a bf:Item ;
    bf:identifiedBy [  
        a bib:AccessionNumber ;
        rdf:value "2017.001.004" ;
        bib:hasSource &lt;http://id.loc.gov/authorities/names/n80087582 &gt; ;
        bf:status bib:invalid ;
        dcterms:date "2017"
    ] .
  -----------------------------------------------------------------------

**LD4L-O v2 Resource-to-Identifier Relationships**
--------------------------------------------------
**bf:identifiedBy (object property)**
> Label: Identifier
> URI: [*http://id.loc.gov/ontologies/bibframe/identifiedBy*](http://id.loc.gov/ontologies/bibframe/identifiedBy)
> Definition: Character string associated with a resource that serves to differentiate that resource from other resources, i.e., that uniquely identifies an entity.
> Comment: Used with Unspecified
> Domain: unspecified
> Range: bf:Identifier
> Inverse: [*http://id.loc.gov/ontologies/bibframe/identifies*](http://id.loc.gov/ontologies/bibframe/identifies)

**bf:identifies (object property)**
> Label: identifies
> URI: [*http://id.loc.gov/ontologies/bibframe/identifies*](http://id.loc.gov/ontologies/bibframe/identifies)
> Definition: Resource that this character string serves to differentiate that resource from other resources, i.e., that uniquely identifies an entity.
> Domain: bf:Identifier
> Range: unspecified
> Inverse: [*http://id.loc.gov/ontologies/bibframe/identifiedBy*](http://id.loc.gov/ontologies/bibframe/identifiedBy)


**LD4L-O v2 Identifier Class Hierarchy**
-------------------------------------------------------

**bf:Identifier**
> Label: Identifier
> URI: [*http://id.loc.gov/ontologies/bibframe/Identifier*](http://id.loc.gov/ontologies/bibframe/Identifier)
> Definition: Token or name that is associated with a resource, such as a URI or an ISBN.
> Comment: Used with Unspecified

####**Proposed subclasses of bf:Identifier**
**bf:AccessionNumber**
> Label: AccessionNumber
> URI: [*http://id.loc.gov/ontologies/bibframe/AccessionNumber*](http://id.loc.gov/ontologies/bibframe/Ansi)
> Definition: Numeric, alphanumeric, or other identifying codes assigned when an art object, book, or other item enters the collection of a museum, library, or other repository. Such codes are unique within the set of codes, and specifically identify the particular item at hand. The numbers may be marked on the objects or not. ([*http://vocab.getty.edu/aat/300312355*](http://vocab.getty.edu/aat/300312355))
> Subclass of: [*http://id.loc.gov/ontologies/bibframe/Identifier*](http://id.loc.gov/ontologies/bibframe/Identifier)