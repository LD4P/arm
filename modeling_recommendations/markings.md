Markings
=============
RareMat and ArtFrame, 2018.03.16

<a name="intro">Introduction</a>
-----------
Markings, as defined in AAT, are “Standardized symbols, notations, or other markings applied to objects during or after creation, conveying information such as the object's origin or maker, its authenticity, or a change in its official status.”

We contrast such markings with marginalia and other unofficial markings applied by individual users, rather than as an element of the creation or production process of the object, or of its custodial history, noting that in some cases the distinction may be subtle. For example, a binding autograph by the binding designer (see Sample Data) is distinguished here from an autograph hand-written in a book, by an author, owner, gift-giver, etc., when transferring ownership to another agent. In-depth pursuit of the distinctions and modeling issues is left for future research. Preliminary remarks are made in [Appendix](#appendix). 

<a name="sampledata">Sample Data</a>
--------
“Pictorial cloth binding with gold, brown, and green stamping on brown calico-textured cloth, designed by Margaret Armstrong; signed: M.A.” (signature is near the bottom, just right of center).

<a name="bfmarkings">Markings in BIBFRAME</a>
-----------------
By intent, BIBFRAME does not provide deep modeling of resource components or physical description; these areas are left to domain extensions.  

<a name="rarematMarkings">Overview of the RareMat &amp; ArtFrame Marking Model</a>
-------------
The Marking model is quite simple, involving a class hierarchy descending from a Marking superclass, and a pair of predicates to relate the Marking to the object marked. Other modeling derives from other Raremat/ArtFrame models such as Activities and <a href="https://github.com/LD4P/ArtFrame-RareMat/blob/master/modeling_recommendations/materials.md">Materials</a>, as well as standard terms used in the Raremat/ArtFrame application profiles for dates, descriptions, and other properties.

Diagram
-------
![Markings diagram](/modeling_recommendations/modeling_diagrams/markings.png)

Note that while the diagram and Sample RDF below show a marking attached to a binding, markings can apply to many types of resources.


Term Specifications
----------------

Classes
-------
**ex:Marking**
> - **URI:** TBD
> - **Label:** Marking
> - **Definition:** A standardized symbol, notation, or other marking present in or applied to the materials of which an object is composed, or applied to an object during or after creation, conveying information such as the object's origin or maker, its authenticity, or a change in its official status. 

**ex:Autograph**
> - **URI:** TBD
> - **Label:** Autograph
> - **Definition:** Persons' names written in their own hand.
> - **Subclass of:** Marking

**ex:BindersTicket**
> - **URI:** TBD
> - **Label:** Binder’s ticket
> - **Definition:**  Small engraved or printed label, usually found on the upper outside corner of one of the front flyleaves, giving the name and usually the address of the bookbinder; common in the 18th and early 19th centuries.
> - **Subclass of:** Marking

**ex:Inscription**
> - **URI:** TBD
> - **Label:** Inscription
> - **Definition:** Words, texts, lettering, or symbols written in manuscript on a resource.
> - **Subclass of:** Marking

**ex:Label**
> - **URI:** TBD
> - **Label:** Label
> - **Definition:** A piece of paper, leather, fabric, or other material inscribed, printed, or engraved with information and affixed to a resource or part of a resource for identification or description.
> - **Subclass of:** Marking

**ex:Seal**
> - **URI:** TBD
> - **Label:** Seal
> - **Definition:** An impression that has been made in wax, clay, or another soft material by the impact of a hard engraved surface with monograms, writing, numbers, symbols, or design in intaglio, generally used to authenticate documents or for decoration.
> - **Subclass of:** Marking

**ex:Stamp**
> - **URI:** TBD
> - **Label:** Stamp
> - **Definition:** A mark that is impressed, printed, perforated, or embossed, made by a hard object, especially a die, block, or other tool, on a softer material such as paper or wax.
> - **Subclass of:** Marking

**ex:Watermark**
> - **URI:** TBD
> - **Label:** Watermark
> - **Definition:** A faint design or device incorporated into paper as it is made and appearing as translucent or shaded areas visual only through transmitted light. Often used to give the name of the manufacturer and the date of the paper's manufacture; a symbol, seal, or initials are also common. Often used to detect and prevent counterfeiting and forgery.
> - **Subclass of:** Marking

Properties
------------

**ex:marks** (ObjectProperty)
> - **URI:** TBD
> - **Label:** marks
> - **Definition:** A Marking’s relationship to the resource it is on or in.
> - **Domain:** Marking
> - **Range:** unspecified
> - **Inverse:** ex:markedBy

**ex:markedBy** (ObjectProperty)
> - **URI:** TBD
> - **Label:** markedBy
> - **Definition:** The resource’s relationship to a Marking it bears. 
> - **Domain:** unspecified
> - **Range:** Marking
> - **Inverse:** ex:marks

Sample RDF
------------
```
:binding a ex:Binding ;
    ex:markedBy :marking ;
    ex:hasActivity :activity1 .

:marking a ex:Autograph ;
    rdf:value “M.A.” ;
    ex:hasActivity :activity2 .

:activity1 a ex:DesignerActivity ;
    bf:agent :margaret_armstrong .

:activity2 a ex:CreatorActivity ;
    bf:agent :margaret_armstrong .

```

Areas for Future Research
-------------
- Consider use of dcterms:isPartOf/dcterms:hasPart instead of marks/markedBy.
- Marginalia and similar markings
> - Define a class hierarchy
> - Markings vs marginalia; see Appendix A for some preliminary remarks.
- Use of controlled vocabularies rather than subclassing for Marking types. We could define the superclass Marking, and leave all typing to marking taxonomies such as AAT. Explore pros and cons of each approach. If the marking taxonomy is deep and complex, it is more practical to use it rather than defining a parallel set of subclasses.


<a name="appendix">Appendix. Markings and Marginalia</a>
--------------
As noted in the Introduction, we make a distinction between the Markings modeled here and marginalia and other unofficial markings applied by individual users, rather than as an element of the creation or production process of the object, or of its custodial history. In-depth pursuit of the distinction and modeling is left for future research, but we make some preliminary remarks here.

As noted, this distinction may be elusive. For example, a binding autograph by the binding designer (see Sample Data) may be distinguished from an autograph hand-written in a book, by an author, owner, gift-giver, etc., when transferring ownership to another agent. If we maintain the distinction, then we would define another class hierarchy for the second category of marking, which could include marginalia, hand-written dedications and autographs, bookplates, and others. The dilemma is that some of the subclasses defined here cut across these two major types; e.g., Autograph, Stamp, and Seal can be of either type, so maintaining two disjoint class hierarchies seems artificial. How else could the distinction be made? 

Approaches that will not work:
- Use the Marking classes to encompass both types of markings, and rely on whether the related resource is an instance or item to make the distinction. This doesn’t work because, while the second type of marking is only at item-level, the first type of marking can be at either instance- or item-level.
- Use the Marking classes to encompass both types of markings, and rely on the creator to make the distinction. This doesn’t work because both can be applied by a creator: an autograph can be engraved on a binding by a binder or hand-written in pen when the author gives a book as a gift.

Possible approaches:
- Use the Marking classes to encompass both types of markings, and use different predicates to distinguish the two. E.g., the first type of Marking could use dcterms:hasPart/isPartOf, and our marks/markedBy could be for the other type. It is intuitively plausible that the first type of marking but not the second be considered a “part” of the resource. Or we could define a different predicate ourselves.
- Use the Marking model recommended here for the first type and the Web Annotation model for the second type. The hand-written autograph would be an annotation with the item or some specific location on the item as a target. The annotation body would be the autograph (or whatever) itself, and could have a more detailed description attached with a note. This approach is consistent with our current recommended use of the Web Annotation model.
