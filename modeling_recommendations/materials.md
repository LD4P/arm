Materials
==========
ArtFrame and RareMat, 2017-11-06

Table of Contents
=======
- [Overview](#overview)
- [BIBFRAME Materials Model](#BFModel)
- [Recommended Materials Model](#RareMatModel)
- [Requests to Library of Congress](#RequeststoLibraryofCongress)
- [Terms](#Terms)
- [Diagram](#Diagram)
- [RDF Sample](#RDFSample)
- [Areas for Future Research](#AreasforFutureResearch)

<a name="overview">Overview</a>
=========
The goal of this model is to describe the material(s) out of which a resource or part of a resource is made.

BIBFRAME has relatively limited descriptive capacity in this realm, presumably with the intent that the model would be expanded by a domain-specific ontology. It defines classes bf:AppliedMaterial, bf:BaseMaterial, and bf:Mount, with corresponding predicates bf:appliedMaterial, bf:baseMaterial, and bf:mount. (We leave bf:emulsion/bf:Emulsion out of this discussion, since it is not clear to us how it fits in.)

We propose a more expressive model in which resource parts such as mounts can be independent resources, in order to describe the materials out of which they are constructed, as well as also other attributes, such as color, measurements, and so on.

The RareMat and ArtFrame extensions have consistently found need to describe resource parts as independent resources in various contexts: Citations, to locate citations in specific entries or on specific pages; Physical Description (forthcoming), Physical Condition, and Measurements, to describe and measure parts of resources such as frames, bindings, etc.; and Part-Whole relationships (forthcoming), to model the relationship of parts such as bindings, mounts, and marginalia to the bibliographic resources that include them. The Materials model provides another case for the independent identity of resource parts, in order to describe what the part is made of.

<a name="BFModel">BIBFRAME Materials Model</a>
============
Classes
---------
**bf:AppliedMaterial**
> - **Label**: Applied material
> - **URI**: http://id.loc.gov/ontologies/bibframe/AppliedMaterial
> - **Definition**: Physical or chemical substance applied to a base material of a resource.

**bf:BaseMaterial**
> - **Label**: Base material
> - **URI**: http://id.loc.gov/ontologies/bibframe/BaseMaterial
> - **Definition**: Underlying physical material of a resource.

**bf:Mount**
> - **Label**: Mount
> - **URI**: http://id.loc.gov/ontologies/bibframe/Mount
> - **Definition**: Physical material used for the support or backing to which the base material of a resource has been attached.

Properties
----------
**bf:appliedMaterial**
> - **Label**: Applied material
> - **URI**: http://id.loc.gov/ontologies/bibframe/appliedMaterial
> - **Definition**: Physical or chemical substance applied to a base material of a resource.
> - **Domain**: bf:Instance
> - **Range**: bf:AppliedMaterial

**bf:baseMaterial**
> - **Label**: base material
> - **URI**: http://id.loc.gov/ontologies/bibframe/baseMaterial
> - **Definition**: Underlying physical material of a resource.
> - **Domain**: bf:Instance
> - **Range**: bf:BaseMaterial

**bf:mount**
> - **Label**: Mount material
> - **URI**: http://id.loc.gov/ontologies/bibframe/Mount
> - **Definition**: Physical material used for the support or backing to which the base material of a resource has been attached.
> - **Domain**: bf:Instance
> - **Range**: bf:Mount

<a name="RareMatModel">Recommended Materials Model</a>
===========================

Summary of recommendations
---------------------
We diverge from the BIBFRAME model in the following respects:
- We do not believe that BaseMaterial and AppliedMaterial are types of things. A material instance is simply a Material, and it may be used as the base material or the applied material in specific cases. A material which is a base material to one resource may be the applied material of another. These materials belong to a Material class, with members defined in a (large) controlled vocabulary, such as cardboard, paper, bronze, etc.
- The relationship of an object to these materials is captured by the predicates baseMaterial and appliedMaterial, but without the ranges specified in BIBFRAME of, respectively, BaseMaterial and AppliedMaterial. We believe the ranges should remain unspecified to allow for use with materials vocabularies that do not declare their terms to be of type Material. 
- We also recommend a general hasMaterial superproperty for cases such as:
> - It is difficult to distinguish applied from base material; e.g., tridimensional works.
> - Some catalogers consider a particular material an applied material, while others encode it as a base material; e.g., papier de Chine.
> - The institutional cataloging practice (e.g., at many museums) does not distinguish base and applied materials, but simply list all the materials they can identify.
- We believe that a Mount is a part of a resource, similar to Frame, Binding, etc. We therefore propose defining a Mount class (note the semantics differ from  bf:Mount, which is a material) alongside these other classes, using dcterms:hasPart to link the bibliographic resource to its part.


<a name="RequeststoLibraryofCongress">Requests for Modifications to BF2</a>
-------

- Remove domain and ranges from bf:appliedMaterial and bf:baseMaterial, and add a superproperty bf:material with domain and range also unspecified. If the request is rejected, the Rare Materials Ontology Extension Group and the ArtFrame  group will use rdau:P60159 “has applied material” and rda:P60596 “has base material” and define its own hasMaterial predicate, with inverse.
- Add inverses of bf:appliedMaterial and bf:baseMaterial. If the request is rejected, the Rare Materials Ontology Extension Group and the ArtFrame  group will create inverses of rdau:P60159 and rdau:P60596.
- Remove property bf:mount.
- Remove classes bf:AppliedMaterial and bf:BaseMaterial.
- Change definition bf:Mount to be a mount object rather than a mount material, or remove the class and leave it to be defined by ArtFrame/RareMat groups along with other resource parts such as Binding, Frame, etc.

<a name="Terms">Terms</a>
-----
Labels, definitions, and URIs TBD depending on whether terms are adopted into BF, reused from external ontologies, or defined in the ArtFrame-RareMat shared namespace.

Note that the Binding class is defined in its own recommendation (fortcoming).

Classes
---------
**crm:E57_Material**
> - **Label**: Material
> - **URI**: http://www.cidoc-crm.org/html/5.0.4/cidoc-crm.html#E57
> - **Subclass of**: E55_Type
> - **Comment**: This class is a specialization of E55 Type and comprises the concepts of materials.
>   - Instances of E57 Material may denote properties of matter before its use, during its use, and as incorporated in an object, such as ultramarine powder, tempera paste, reinforced concrete. Discrete pieces of raw-materials kept in museums, such as bricks, sheets of fabric, pieces of metal, should be modelled individually in the same way as other objects. Discrete used or processed pieces, such as the stones from Nefer Titi's temple, should be modelled as parts (cf. P46 is composed of).
>   - This type is used categorically in the model without reference to instances of it, i.e. the Model does not foresee the description of instances of E57 Material, e.g.: “instances of  gold”.
>   - It is recommended that internationally or nationally agreed upon codes and terminology are used.

**Mount**
> - **Options**: bf:Mount if LC agrees to our recommendation, otherwise Mount in our own namespace.
> - **Label**: Mount
> - **URI**: TBD
> - **Definition**: Secondary surfaces on which works, often drawings, photographs, or other works on paper supports, are pasted, taped, or otherwise attached. 

**Frame**
> - **Label**: Frame
> - **URI**: TBD
> - **Definition**: Cases or structures that surround or enclose such items as works of art, mirrors, or documents, serving as support or protection or to call attention, while leaving the items visible. 
> - **Subclass of**: Mount


Properties
--------
**hasMaterial**
> - **Options**: bf:material if LC agrees to our recommendation, or hasMaterial in our own namespace. Note that because we would be using rdau properties for base and applied materials, our property cannot be defined as a superproperty of these.
> - **Label**: TBD
> - **URI**: TBD
> - **Definition**: TBD
> - **Domain**: unspecified
> - **Range**: unspecified
> - **Inverse**: isMaterialOf

**isMaterialOf**
> - **Options**: BIBFRAME term if LC agrees to our recommendation (see below), or define our own (see above for hasMaterial).
> - **Label**: TBD
> - **URI**: TBD
> - **Definition**: TBD
> - **Domain**: unspecified
> - **Range**: unspecified
> - **Inverse**: hasMaterial

**hasAppliedMaterial**
> - **Options**: bf:appliedMaterial if LC agrees to our recommendation, or rdau:P60159
> - **Label**: TBD
> - **URI**: TBD
> - **Definition**: TBD
> - **Domain**: unspecified
> - **Range**: unspecified
> - **Inverse**: isAppliedMaterialOf

**isAppliedMaterialOf**
> - **Options**: BIBFRAME term if LC agrees to our recommendation, or define our own as inverse of rdau:P60159.
> - **Label**: TBD
> - **URI**: TBD
> - **Definition**: TBD
> - **Domain**: unspecified
> - **Range**: unspecified
> - **Inverse**: hasAppliedMaterial

**hasBaseMaterial**
> - **Options**: bf:baseMaterial if LC agrees to our recommendation, or rdau:P60596
> - **Label**: TBD
> - **URI**: TBD
> - **Definition**: TBD
> - **Domain**: unspecified
> - **Range**: unspecified
> - **Inverse**: isBaseMaterialOf

**isBaseMaterialOf**
> - **Options**: BIBFRAME term if LC agrees to our recommendation (see below), or define our own as inverse of rdau:P60596.
> - **Label**: TBD
> - **URI**: TBD
> - **Definition**: TBD
> - **Domain**: unspecified
> - **Range**: unspecified
> - **Inverse**: hasBaseMaterial

**dcterms:hasPart**
> - **Label**: Has Part
> - **URI**: http://purl.org/dc/terms/hasPart
> - **Definition**: A related resource that is included either physically or logically in the described resource.

**dcterms:isPartOf**
> - **Label**: Is Part Of
> - **URI**: http://purl.org/dc/terms/isPartOf
> - **Definition**: A related resource in which the described resource is physically or logically included.

**rdau:P60558**
> - **Label**: has colour content
> - **URI**: http://rdaregistry.info/Elements/u/colourContent.en
> - **Scope note**: Black, white, single colour shades of black, single colour tints of white, and single colour tones of gray are considered to be single colours.
> - **Domain**: undefined
> - **Range**: undefined
> - **Subproperty of**: rdau:P20224

**crm:P2_has_type**
> - **Label**: has type
> - **URI**:http://www.cidoc-crm.org/html/5.0.4/cidoc-crm.html#P2
> - **Scope note**: This property allows sub typing of CRM entities - a form of specialisation – through the use of a terminological hierarchy, or thesaurus. The CRM is intended to focus on the high-level entities and relationships needed to describe data structures. Consequently, it does not specialise entities any further than is required for this immediate purpose. However, entities in the isA hierarchy of the CRM may by specialised into any number of sub entities, which can be defined in the E55 Type hierarchy. E51 Contact Point, for example, may be specialised into “e-mail address”, “telephone number”, “post office box”, “URL” etc. none of which figures explicitly in the CRM hierarchy. Sub typing obviously requires consistency between the meaning of the terms assigned and the more general intent of the CRM entity in question.
> - **Domain**: crm:E1_CRM_Entity
> - **Range**: crm:E55_Type

**crm:P2i_is_type_of**
> - **Label**: is type of
> - **URI**: http://www.cidoc-crm.org/html/5.0.4/cidoc-crm.html#P2
> - **Domain**: crm:E55_Type
> - **Range**: crm:E1_CRM_Entity

Note that crm:P2_has_type and its inverse are used to type an individual material resource within a taxonomic hierarchy, where the object is a named individual, as opposed to rdf:type with range rdfs:Class.

Named Individuals
----------
Vocabularies for materials and colour content. Consider the following and others.
- [RDA Material vocabulary](http://www.rdaregistry.info/termList/RDAMaterial/)
- [RBMS Binding Materials vocabulary](http://rbms.info/vocabularies/binding/th16.htm)
- [AAT Materials Facet](http://www.getty.edu/vow/AATHierarchy?find=&logic=AND&note=&subjectid=300264091)
- [AAT Color Facet](http://www.getty.edu/vow/AATFullDisplay?find=blue&logic=AND&note=&page=1&subjectid=300131647)

<a name="Diagram">Diagram</a>
===========
![Materials model diagram](/modeling_recommendations/modeling_diagrams/materials.png)
Note that ex is the namespace of the current model, while ex1 is the namespace of a controlled vocabulary for materials. These may or may not be the same; moreover, different material terms could belong to different namespaces. Namespaces of terms shown without prefixes are currently undefined, and depend on the outcome of BIBFRAME recommendations.

<a name="RDFSample">Sample RDF</a>
===========
```
:item a bf:Item ;
    dcterms:hasPart :mount1.

 :mount1 a ex1:Mount ;
     ex2:hasBaseMaterial :baseMaterial1 .
 
 :baseMaterial1 a crm:E57_Material ;
      crm:P2_has_type :wood (plant material) ;
      rdau:P60558 :brown (color) .
```

<a name="AreasforFutureResearch">Areas for Future Research</a>
===========
- Can emulsion (bf:emulsion, bf:Emulsion) be integrated into the Materials model, or does it require different treatment?
- Consider whether the hasAppliedMaterial predicate should actually connect the applied material to the base material rather than the object; that seems to be more semantically accurate. Could there be layers of applied materials, each applied on top of the other? That couldn’t be captured by multiple hasAppliedMaterial assertions on the resource.
- Consider whether it would be useful to ask RDA to define a superproperty “has material” of properties “has applied material” and “has base material”.

