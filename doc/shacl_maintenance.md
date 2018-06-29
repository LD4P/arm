SHACL Maintenance
==========================

**Table of Contents**
> - [Introduction](#introduction)
> - [SHACL Outputs](#outputs)
> - [History and Context](#history)
> - [SHACL Implementation Patterns](#patterns)
> - [Outstanding Questions](#questions)


<a name="overview">Introduction</a>
------------

The examples of Shapes Constraint Language (SHACL) created in this repository serve as the start of machine actionable application profiles for the Art and Rare Materials (ARM) BIBFRAME Ontology Extension. As the ARM ontologies mature through community testing and adoption, it is equally important to reflect these experiences in shared application profiles.

To what extent these application profiles are shareable within and across communities and employed by various RDF editor environments is an open question. To date, VitroLib is the only tool used to enact the ARM SHACL (partially, through a combination of scripting and manual translations), but this does not preclude its use by other editing environments. Looking at the role of application profiles more broadly, given RDF is not record- based, we might find the SHACL-driven forms catalogers interact with on a daily basis will serve as the common shared experience required to enable communication and training for our descriptive practices and the underlying model.

SHACL maintenance will require a combination of skills and backgrounds, including knowledge of cataloging practices and workflows, some RDF and ontology engineering experience, and experience with GitHub and file management best practices. Different styles of SHACL (described below) have been explored. As the community’s application profile needs and the level of involvement from its members becomes more clear, these sensibilities can be paired with an appropriate SHACL implementation pattern.

<a name="outputs">SHACL Outputs</a>
------------

Within the Application Profile section of the Art and Rare Materials (ARM) BIBFRAME Ontology Extension GitHub repository, SHACL files have been created for both art works and rare monographs. Alongside the SHACL files, we provide fragments of external ontologies and vocabularies that they reference. There is also validation SHACL paired with the core and modular ontologies throughout the repository. For more information on organization of the ARM repository, see the ARM Repository Contents document.

Note: Cornell’s LD4P Hip Hop LP cataloging project also created SHACL (bibliotek-o_shapes.shapes.ttl) in the LD4P Hip Hop repository, but this SHACL is strictly a proof of concept for working with a local collection in VitroLib; the Music Library community will likely have their own process for creating application profiles.

<a name="history">History and Context</a>
------------

The LD4L-Labs and LD4P 2016-2018 grants evaluated and piloted multiple RDF editors, (including VitroLib, BIBFRAME Editor, CEDAR) in order to implement modeling decisions in linked data native cataloging environments. These decisions included the use of BIBFRAME, along with domain extensions, the use of particular vocabularies, and more. Early on it became clear that ontologies alone do not capture enough information to create a fully functional editing environment. For example, we may want a general property like bf:hasPart to display and be used in very specific ways throughout an application, or perhaps we only want to make available music-related contributor roles to a cataloger when describing musical works.

Because each editor platform evaluated in the two grants was framed as a prototype to gain experience with building a linked data cataloging tool, some efforts within LD4L-Labs and LD4P 2016-2018 targeted more a neutral platform-agnostic method for creating application profiles using the W3C recommendation Shapes Constraint Language (SHACL). SHACL then provided a standards-based, machine-actionable record of how modeling decisions should be reflected in a catalog interface, which could then be converted into specific platform configuration requirements. Because SHACL itself is RDF-based, it can be represented as linked data and easily made available for reuse and extension by other communities. In the future, editor environments would ideally become standards-compliant and use specifications like SHACL natively.

In addition to being a W3C recommendation, another reason SHACL was chosen as the language for capturing application profiles was that the grant work was primarily focused on form creation, and SHACL’s built-in non-validating property shape characteristics proved very useful in this context. These non-validating characteristics allowed assertions critical for creating usable forms, e.g. how properties are labeled and described for a particular use, coherent groupings for related properties, and order. Of course we also wanted forms that ensure the creation of valid data, which naturally meant also incorporating SHACL’s validating property shape characteristics. For detailed examples on how form semantics potentially map to SHACL, see SHACL Semantics for Form Building.

<a name="patterns">SHACL Implementation Patterns</a>
------------

### Non-Modular and Heavy Blank Node Use (Hip Hop)

The first attempt in the grants to use SHACL to create application profiles was for the Cornell Hip Hop Cataloging project, which started out using a free trial of TopBraid Composer. The default property shapes created from Composer were represented as blank nodes (without URIs for the sh:PropertyShapes). At the time we were less concerned with the shareability and reuse of the shapes, so we did not refactor these to have URIs. Even though blank nodes can improve the readability of shapes, we do not recommend their use going forward except perhaps in the most narrow cases where reuse is not anticipated.

### A Largely Non-Modular Approach (Art and Portions of Rare Monograph)

The initial rare monograph SHACL was focused on creating a single file raremat_monograph_form.ttl that included SHACL Node Shapes to represent separate forms for each entity type being described and Property Shapes off of each Node Shape to represent a field in a particular form. Little effort was given to teasing apart non-validating user interface decisions from data validation decisions. Instead, the focus was on having a single file to maintain with each Property Shape being self-contained. While perhaps easier to read at a glance (not requiring to navigate through multiple files and multiple property shapes to understand a form field’s behavior), this approach does not take advantage of modular reuse of validation shapes.

### Modular Approach (Select Patterns from Rare Monograph)

The rare monograph SHACL files other than raremat_monograph_form.ttl illustrate a modular style in which (a) multiple files are used, with each file including shapes for a single submodel (e.g., activities, exhibitions, titles, and so on), and (b) shapes are layered on top of one another using sh:node: form/UI shapes are built on both validation shapes and other UI shapes, and validation shapes are also layered on top of other validation shapes. The basic principles are (a) DRY (“don’t repeat yourself”) for its well-documented benefits, and (b) separation of UI shapes from validation shapes, since they serve fundamentally distinct functions, while recognizing that, since an application must adhere to both general model-level constraints and application-specific UI instructions, UI shapes logically extend validation shapes. 

Validation shapes are located in the validation folders inside the ontology directories. At the time of this writing, only activity, core and custodial_history validation shapes have been implemented; these are located in /activity/validation, /core/validation and /custodial_history/validation, respectively.

Some concrete examples of shape extension using sh:node follow. 

#### 1. A property shape with a specific object type (defined by sh:class) extends a property shape with unspecified object type.

```
# File arm_core_property_shapes.ttl

# Generic PropertyShape linking a resource to one of its parts.    
:bf_hasPart
    a sh:PropertyShape ;
    sh:path bf:hasPart;
    sh:nodeKind sh:IRI .

# Links a multi-part or traveling ExhibitionEvent to one of its sub-events.
 
:bf_hasPart_schema_ExhibitionEvent
    a sh:PropertyShape ;
    sh:node :bf_hasPart ;
    sh:targetClass schema:ExhibitionEvent ;
    sh:class schema:ExhibitionEvent .
```


#### 2. A UI property shape extends a validation shape. 

```
# File arm_core_property_shapes.ttl

# Generic PropertyShape linking a resource to one of its parts.    
:bf_hasPart
    a sh:PropertyShape ;
    sh:path bf:hasPart;
    sh:nodeKind sh:IRI .


# File raremat_monograph_enclosure.ttl

# Generic PropertyShape linking a resource to an Enclosure. Specific
# constraints are added in InstanceForm_bf_hasPart_arm_Enclosure and 
# ItemForm_bf_hasPart_arm_Enclosure.
:bf_hasPart_arm_Enclosure
    a sh:PropertyShape ;
    sh:node arm_core_property_shapes:bf_hasPart ;
    sh:class arm:Enclosure ;
    sh:name "Other enclosure" . 
```



#### 3. UI property shapes extend another UI property shape.

```
# File raremat_monograph_enclosure.ttl

# Generic PropertyShape linking a resource to an Enclosure. Characteristics specific to subject type are added in InstanceForm_bf_hasPart_arm_Enclosure and ItemForm_bf_hasPart_arm_Enclosure.
:bf_hasPart_arm_Enclosure
    a sh:PropertyShape ;
    sh:node arm_core_property_shapes:bf_hasPart ;
    sh:class arm:Enclosure ;
    # NON-VALIDATING   
    sh:name "Other enclosure" .         

# Links Instance to Enclosure. Note that Instance and Item use different
# PropertyShapes because they belong to different property groups. Distinct
# property groups are needed because properties are ordered differently for 
# Instances and Items.
:InstanceForm_bf_hasPart_arm_Enclosure
    a sh:PropertyShape ;
    sh:node :bf_hasPart_arm_Enclosure ;
    sh:targetClass bf:Instance ;
    # NON-VALIDATING 
    sh:group raremat_monograph_property_groups:InstancePhysicalDescriptionPropertyGroup ;   
    sh:order "10"^^xsd:int .

# Links Item to Enclosure. Note that Instance and Item use different
# PropertyShapes because they belong to different property groups. Distinct
# property groups are needed because properties are ordered differently for 
# Instances and Items.
:ItemForm_bf_hasPart_arm_Enclosure
    a sh:PropertyShape ;
    sh:node :bf_hasPart_arm_Enclosure ;  
    sh:targetClass bf:Item ;     
    # NON-VALIDATING 
    sh:group raremat_monograph_property_groups:ItemPhysicalDescriptionPropertyGroup ;   
    sh:order "2"^^xsd:int .
```


#### 4. A form node shape extends another form node shape.

```
# File raremat_monograph_note.ttl

:NoteForm
    a sh:NodeShape ;
    rdfs:label "Note form" ;
    sh:targetClass bf:Note ;
    sh:property 
        # Type options depend on context (i.e., the specific form), so omit this property shape here.
        # :NoteForm_rdf_type ,        
        :NoteForm_rdf_value .


# File arm_core_property_shapes.ttl

# Links a resource to its rdf:type.           
:rdf_type
    a sh:PropertyShape ;
    sh:path rdf:type ;
    sh:nodeKind sh:IRI ;
    .


# File raremat_monograph_marking.ttl

:MarkingNoteForm 
    a sh:NodeShape ;
    sh:node raremat_monograph_note:NoteForm ;
    sh:property :MarkingNote_rdf_type .

# Marking note type options
:MarkingNote_rdf_type 
    a sh:PropertyShape ;
    sh:node arm_core_property_shapes:rdf_type ;
    sh:targetClass bf:Note ;
    sh:in (
        arm:DescriptiveNote
        bf:Note
    ) .
```


#### Notes

> - In these examples, and in the current implementation as a whole, the validation shapes are quite skeletal, so the motivation for reusing them rather than simply copying the contents into various shapes may not seem compelling at this stage, especially given that there is a steeper learning curve in applying the modular approach. These validation shapes are intended as prototypes, and can be made more substantive in future development in order to more fully realize the benefits of this approach.
> - There is considerable overlap between shapes defined in the modular approach and shapes defined in the non-modular approach in raremat_monograph_form.ttl, because, again, the modular shapes are a proof-of-concept and include all the pieces needed to build shapes on top of other shapes. In an actual implementation, one would choose one approach or the other without repetition or overlap.
> - Ontology axioms and SHACL constraints. We conceive of validation shapes as not solely serving a validation function (i.e., running a validation engine on RDF instance data), but also to provide a concrete, formal specification of the models contained in the modeling recommendations beyond what the ontologies can (easily) provide. There is overlap in what can be specified in ontology axioms and SHACL validation constraints, and it is an open question which constraints are best implemented in one or the other, and what principles and best practices should be brought to bear on this decision. Sometimes, but not always, fairly complex OWL restrictions are needed to express what can be more simply expressed in SHACL; an overly complex and constrained ontology may discourage implementation. 
> - The SHACL specification provides for extension (very similar to extension in object-oriented programming languages) but not for overrides. The possibilities for extension and for assertions in extended shapes would be considerably richer if an override mechanism were implemented, either in SHACL itself or in custom SHACL extensions.


<a name="questions">Outstanding Questions</a>
------------
#### 1. SHACL is a large and flexible constraint language; we still need to decide how much/which parts of the specification we want to encourage in library implementations. For example:

  * There are multiple ways to create controlled lists; we settled on sh:in (over sh:hasValue, etc.) for the most part. Need to access whether this is the best way; does it cover all our needs?

  * Validation shapes separate from display shapes makes the decisions more modular, but how do we balance this with it being consumable and maintainable by the communities they serve.

    * There are multiple ways to reference/reuse external shapes within a shape; best practices haven’t emerged yet.

    * More work is need on automated joining of PropertyShapes; we can’t just join all PropertyShapes using sh:path because the property might be used in many different ways.
  * Largely due to time, the Art SHACL currently attempts to create single form for bf:Text, bf:Object, and bf:StillImage.
    * If conditional logic (different activity types) is to be supported for different work types within the same form, this might require not only having sh:targetClass assertions on sh:NodeShapes (the implementation pattern currently use by other SHACL in the project), but also on sh:PropertyShapes. 
      * What are the implications of requiring software to check both sh:NodeShapes and sh:PropertyShapes for targets?
      * Would separate form SHACL per work type ultimately be a better approach to application profiles, so that someone interested in only one work type doesn’t have to have to actively ignore the inapplicable shapes?
      * Does the ability to use large portions of the same SHACL across multiple work types suggest a modular approach reusing general work shapes would be useful? 
        * We need more experience to know which parts of the application profile will remain general vs. specialized for different work types, etc.
#### 2. Due to time, the project was unable to spend much time on what we mean by “validation”. 
  * Do we expect closed or open shapes?
  * Do we support severity, e.g. failures, vs. warnings?
  * Will different communities/institutions have different validation shapes based on workflows and policies?
#### 3. Due to time, the project was unable to spend much time creating SHACL that is more responsive to different workflows. How do we enable this level of decision making?
  * For example, in practice we would need not just an Audio profile, but also profiles for cd’s, lp’s, etc. 
    *sh:default could be really useful in setting up these templates.
  * Also, there may be profiles based on staffing/levels of description expected for different resources.
    * This intersects with degrees of validation.
#### 4. Ultimately, we need quicker/easier/more inclusive ways of creating the application profiles.
 * Perhaps a VitroSHACL could provide a GUI for the creation of SHACL
    * Or just use TopBraid Composer, but there is a steep learning curve and set up costs.
#### 5. There still needs to be a machine-actionable way in the application profile to designate that instances of particular entity types are not reusable.
  * E.g. Titles, Notes, Activities, and others are treated as entities to provision for the desired semantics, but when assigning a Title, Note, Activity to a new work a cataloger shouldn’t have the option to pick from existing Title, Notes, Activities.
#### 6. There still needs to be a machine-actionable way of stating that look-ups should come from multiple sources.
  * E.g. Primarily want terms to come from a particular vocab, but allow local term creation. Or for example: Search across these three vocabularies.
  * There is probably a way to use sh:class and lookup properties to do this, or using sh:pattern. 
    *(sh:pattern wasn’t used in the current SHACL, but examples show regular expressions used to identify namespaces.)
#### 7. Though built into SHACL, is sh:order the best way to configure order of PropertyGroups and PropertyShapes?
  * Are there advantages to using rdf:List, or other existing sequencing predicates, e.g. seq:precedes/follows/directlyPrecedes/directlyFollows? This likely comes down to which method is most easily/often interpreted by machines and implementers.
  * xsd:int or xsd:decimal? We settled on xsd:int due to VitroLib limitations in processing decimals for property group ordering, but decimal might ultimately be the better approach if we anticipate moving form shapes around, because we can always interfile terms by adding a new significant digital.
#### 8. Similar to sh:order, there are widely adopted analogous external terms for the other non-validating SHACL predicates.  E.g. sh:name vs rdfs:label, sh:description vs rdfs:comment or dcterms:description.
  * Is it important to wholly implement the SHACL specification? Or would consumption of SHACL be aided by reusing external terms?
#### 9. TopBraid has developed extensions to SHACL to accommodate more complicated UI configurations, e.g. tosh:editWidget swa:NestedObjectEditor
  * This has been nice to pick up and use, but in the long term should this be bumped up to a group-owned standard/effort?
#### 10. SHACL testing
  * Syntax: Our SHACL has been syntactically validated as Turtle, but not as SHACL.
  * Semantics: Our SHACL has not been tested to ensure that it correctly follows SHACL semantics. 
#### 11. Custom SHACL extensions
  * Some custom SHACL terms have been introduced in our work without formal definition, relying instead on human interpretation. In order to make fully machine-readable SHACL, it would be necessary to formally define SHACL extensions.
