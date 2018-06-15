Custodial History : Provenance Ownership Model
=======
RareMat & ArtFrame, 2017-10-04

Table of Contents
=======
- [Overview](#overview)
- [Summary of the Model](#SummaryoftheModel)
- [Diagram](#Diagram)
- [RDF Sample](#RDFSample)
- [Requests to Library of Congress](#RequeststoLibraryofCongress)
- [Term Specifications](#TermSpecifications)
- [Areas for Future Research](#AreasforFutureResearch)

<a name="overview">Overview</a>
=======
Understanding the ownership or custodial history of an item is fundamental in understanding its contextual and historical importance as well as during valuation, when applicable. 

Current descriptive practice includes these data as strings. For instance:
"Unrecorded until purchased in 1893 from Agnew's by J. Pierpont Morgan; sold by him at auction in 1905; Christie's 1910; Pres. and Mrs. Nicholas Murray Butler; donated by their estate to Columbia in 1955."

In modeling ownership and custodial history, the ArtFrame and Rare Materials Ontology Extension groups wanted to leverage more queryable data afforded by an entity-focused model; this differs from both current descriptive practice as well as BIBFRAME use of bf:custodialHistory as a datatype property. As such, we recommend using object properties alongside resources for different components of custodial history.

An item's custodial history is complex and provides a rich area for querying. Through the model proposed below, we believe we can both trace individual custodial histories for items in collections while aggregating materials related to the same auction, sale or donation.

While the custodial history model was developed specifically to address the descriptive needs of bibliographic items in the art and rare materials domains, we define it as an independent model with the expectation that it could be useful in the description of the custodial history of a broad range of resources.

<a name="SummaryoftheModel">Summary of the Model</a>
=======

New resource types
------------------
The model posits two new classes for the description of a resource’s custodial history: CustodialEvent and CustodialHistory. 

A CustodialEvent represents a single event or period in the custodial history of a resource, such as a sale, donation, or period of ownership. The CustodialEvents for a specific Item are aggregated and potentially ordered in a CustodialHistory resource representing the entire custodial history of that Item. 

The CustodialEvent directly linked to the CustodialHistory of a resource (hereafter “individual CustodialEvent”) may be part of a larger CustodialEvent (hereafter “aggregate CustodialEvent”) encompassing multiple Items; e.g., a manuscript auctioned together with other manuscripts. Note that these are not distinct types of resources; rather, the distinction is maintained by direct or indirect linkage to a resource’s CustodialHistory. The individual CustodialEvent node intervening between a resource’s CustodialHistory and the aggregate CustodialEvent allows the individual events to be aggregated and sequenced independently of any other Item’s CustodialHistory. 

The CustodialHistory class is provided so that additional assertions can be made about it, distinct from assertions about specific events (the class also has conceptual appeal as a “container” of individual CustodialEvents). Whether this class is useful, as opposed to linking individual CustodialEvents directly to Items, remains to be seen through implementation and experimentation with the model (see Areas for Future Research).   

Relationships between resources
------------------------
-	Only the CustodialHistory resource is linked directly to the Item, via the predicate hasCustodialHistory. Each Item is linked to a maximum of one CustodialHistory.
-	The CustodialHistory of the Item is linked to one or more CustodialEvents via bf:hasPart (inverse bf:partOf).
-	An individual CustodialEvent may be linked to an aggregate CustodialEvent via bf:partOf (inverse bf:hasPart). 
-	Individual CustodialEvents may be sequenced in the CustodialHistory via seq:precedes, seq:follows, seq:directlyPrecedes, and seq:directlyFollows. 
> - Because seq:precedes and seq:follows do not imply immediate precedence or succession, new event assertions may be interjected between two existing events. When immediate precedence or succession is known, seq:directlyPrecedes and seq:directlyFollows can be used.
> -	The modeling of concurrent and overlapping events (e.g., when the loan of a manuscript to one institution overlaps two ownerships) is left for future research. 
> -	When two CustodialEvents belonging to two different Items are part of the same aggregrate CustodialEvent, they may well occupy different positions in the sequencing of each Item’s CustodialHistory. For example, a sale including two items may be the first event in one Item’s history and the second Event in the other Item’s history.
> -	While the model allows for sequencing of aggregate CustodialEvents, we expect this to have little utility in an implementation.
-	CustodialEvents may be linked to one or more ex:Activity objects, price subgraphs, dates (both intervals and discrete dates), locations, and so on. These relations may pertain to either individual or aggregate CustodialEvents; for example, an entire lot of manuscripts may have been purchased for $100K, but the price of a specific item in the lot was negotiated at $10K and its inclusion in the lot was brokered by an agent not related to the aggregate CustodialEvent.
-	An AccessionNumber may be linked as an Identifier to both a bf:Item (via bf:identifies/identifiedBy) and to a CustodialEvent (via ex:accessions/accessionedBy). See full AccessionNumber recommendation.

Types of custodial events and related activities
------------
The types of CustodialEvents encompassed by the provenance model include the following (and possibly others yet to be identified):
- Sale
- Gift / Bequest
- Theft
- Transfer
- Offer
- Inheritance/Descent
- Loan
- Deposit 
- Destruction 
- Loss
- Recovery / Restitution 
- Repatriation 
- Discarded
- Deaccessioned 
- Accessioned 
- Claim of ownership

Each of these event types is represented by a subclass of CustodialEvent.

Note that these types of CustodialEvents include both what are typically thought of as “events” (sale, loan, etc.) and static time periods such as ownership. The former also subclass schema:Event. As a matter of implementation, a static period may pertain to only a single Item; e.g., Items sold together in one lot may later be sold in unrelated events, so that a single ownership event could not represent all Items. On the other hand, a single library can be sold multiple times together, and buyers may wish to keep the library intact as much as possible.

Both individual and aggregate CustodialEvents may be typed, but an individual event that is part of an aggregate event should have the same type, and typing is in that case redundant.

Activities appropriate to a specific CustodialEvent type are linked to a CustodialEvent instance. For example, a sale will typically have activities such as buyer and seller, while a loan may have activities such as borrower and lender. 

Importantly, this model enhances the Activity model by providing a way to connect interrelated or interdependent activities. For example, we can assert seller and buyer activities on an item, but have no way to express the fact that specific seller and buyer activities are related to one another. If multiple such activities are related to a single item, there is no way to express the relationship of particular activities to one another. Dates may sometimes serve that purpose but cannot be relied upon.

Out-of-scope event and activity types
------
Concepts similar to but disjoint from ownership (i.e., to be represented by other models):
- Publication and production information (e.g., printer holds all items at time of printing)
- Exhibition history (handled in forthcoming Exhibits model)
- Creation activities (e.g., creator holds all items at time of creation)
- Commissions (involves works rather than items, not part of the custodial history of a resource)

<a name="Diagram">Diagram</a>
======
![Custodial History Diagram](/modeling_recommendations/modeling_diagrams/custodial_history.png)


<a name="RDFSample">RDF Sample</a>
======
This sample describes a scenario in which one item has been sold twice, with an intervening period of ownership, and a second item has been sold once, as part of a lot that included the first sale of the first item.

```
:item1 a bf:Item ;
    ex:hasCustodialHistory :history1 .

:item2 a bf:Item ;
    ex:hasCustodialHistory :history2 .

:history1 a ex:CustodialHistory ;
    bf:hasPart :individualEvent1 ; :individualEvent2 ,  :individualEvent3 .

:history2 a ex:CustodialHistory ;
    bf:hasPart :individualEvent4 .

:individualEvent1 a ex:SaleEvent ; 
    seq:precedes :individualEvent2 ;
    bf:partOf :aggregateEvent1 .

:individualEvent2 a ex:OwnershipEvent ; 
    seq:precedes :individualEvent3 .
    
:individualEvent3 a ex:SaleEvent .

:individualEvent4 a ex:CustodialEvent ;
    bf:partOf :aggregateEvent1 .

:aggregateEvent1 a ex:SaleEvent ;
    ex:hasActivity :sellerActivity1 ;
    bf:date “1984”^^edtf:edtf ;
    ex:atLocation <uri-of-location> ;
    schema:priceSpecification :price1 .

:sellerActivity1 a ex:SellerActivity ;
    ex:hasAgent <uri-of-agent> .

:price1 a schema:PriceSpecification ;
    schema:price “10” ;
    # Note: The Schema definition of priceCurrency specifies the object as
    # a 3-letter ISO 4217 format - i.e., a literal rather than a URI. This
    # is left as [an area for future research](#AreasForFutureResearch).
    schema:priceCurrency <iso-4217-code> .  
```

<a name="RequeststoLibraryofCongress">Requests to Library of Congress</a>
-----------
**bf:custodialHistory**

- Change bf:custodialHistory into an object property, as in [Term Specifications](#TermSpecifications) below.
  - If LC does not approve this request, ArtFrame/RareMat will define these terms in a namespace TBD for its Exhibition ontology.

**Define custodial history-related classes**

- Define the following classes as in [Term Specifications](#TermSpecifications) below.
- bf:CustodialHistory
- bf:CustodialEvent
  - If LC does not approve this request, ArtFrame/RareMat will define these terms in a namespace TBD for its Exhibition ontology.

**bf:Event**

- The definition of bf:Event is “Something that happens at a certain time and location, such as a performance, speech, or athletic  
  event, that is documented by a resource.” We request removal of the phrase “that is documented by a resource,” allowing events to be 
  modeled in contexts other than as the event content of a work. 
  - If this recommendation is accepted, we will use bf:Event and define a subclass ex:ExhibitionEvent. Otherwise, we will use  
    schema:Event and its subclass schema:ExhibitionEvent. 
  - In either case, we will define the [Event types detailed below](#TermSpecifications).
- Our ultimate recommendation would be to remove bf:Event and implement or use an Event ontology (so far we have not identified   
  a suitable existing one), but this is a complex project and likely far in the future.


<a name="TermSpecifications">Term Specifications</a>
========
Classes
-------

**schema:Event**
> - **Label**: Event
> - **URI**: http://schema.org/Event
> - **Definition**: An event happening at a certain time and location, such as a concert, lecture, or festival. Ticketing information may be added via the offers property. Repeated events may be structured as separate Event objects. 

**bf:Item**
> - **Label**: Item
> - **URI**: http://id.loc.gov/ontologies/bibframe/Item
> - **Definition**: Single example of an Instance. 

**ex:CustodialHistory**
> - **Label**: Custodial history
> - **URI**: http://example.org/CustodialHistory
> - **Definition**: Entity that aggregates all of the custodial events for a resource.
> - **Comment**: An Item has a single ex:CustodialHistory, which is composed of one or more ex:CustodialEvent resources. The Item is directly linked only to its CustodialHistory.


**ex:CustodialEvent**
> - **Label**: Custodial event
> - **URI**: http://example.org/CustodialEvent
> - **Definition**: A custodial event encompassing one or more Items, such as a sale or loan.
> - **Comment**: A CustodialEvent may pertain to only a single Item, in which case it is linked directly to the Item’s CustodialHistory, or it may encompass multiple Items (such as an auction lot), in which case the CustodialEvent aggregates multiple individual CustodialEvents. A CustodialEvent may be what is typically conceived of as an “event,” or a “static” event such as Ownership. Subclasses are accordingly either defined as subclasses of schema:Event or not.


CustodialEvent Subclasses
----------
Some of these classes are also defined as subclasses of schema:Event. “Static” events such as Ownership do not subclass schema:Event.


**ex:Accessioning**
> - **Label**: Accessioning
> - **URI**: http://example.org/Accessioning
> - **Definition**: The act of adding an item to the accessions records of a cultural heritage institution.
> - **Comment**: Typical associated Activities: AccessionerActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Auction**
> - **Label**: Auction
> - **URI**: http://example.org/Auction
> - **Definition**: The sale at auction of a resource. 
> - **Comment**: Refers to the transfer of ownership through auction, rather than the auction in which that occurs. Typical associated Activities: BuyerActivity, SellerActivity, DealerActivity.
> - **SubclassOf**: ex:Sale, schema:Event.

**ex:Bequest**
> - **Label**: Bequest
> - **URI**: http://example.org/Bequest
> - **Definition**: The transfer of a resource under the terms of a will.
> - **Comment**: Typical associated Activities: TestatorActivity, InheritorActivity, WitnessActivity.
> - **SubclassOf**: ex:Inheritance, schema:Event

**ex:ClaimOfOwnership**
> - **Label**: Claim of ownership
> - **URI**: http://example.org/ClaimOfOwnership
> - **Definition**: A legal claim to the right of possession of a resource.
> - **Comment**: Typical associated Activities: ClaimantActivity, DisputantActivity.
> - **SubclassOf**: ex:CustodialEvent.

**ex:Deaccessioning**
> - **Label**: Deaccessioning
> - **URI**: http://example.org/Deaccessioning
> - **Definition**: The removal of an item from the accessions records of a cultural heritage institution. 
> - **Comment**: Typical associated Activities: DeaccessionerActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Deposit**
> - **Label**: Deposit
> - **URI**: http://example.org/Deposit
> - **Definition**: The placement of an item in the collections of a cultural heritage institution.
> - **Comment**: Typical associated Activities: DepositorActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Destruction**
> - **Label**: Destruction
> - **URI**: http://example.org/Destruction
> - **Definition**: The permanent ruination of a resource.
> - **Comment**: Typical associated Activities: DestructionActivity, OwnerActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Discarding**
> - **Label**: Discarding
> - **URI**: http://example.org/Discarding
> - **Definition**: The abandonment or disposal of a resource.
> - **Comment**: Typical associated Activities: DiscarderActivity, OwnerActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Donation**
> - **Label**: Donation
> - **URI**: http://example.org/Donation
> - **Definition**: The giving of a resource, typically for charitable purposes and/or to benefit a cause.
> - **Comment**: Typical associated Activities: DonorActivity, RecipientActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Inheritance**
> - **Label**: Inheritance
> - **URI**: http://example.org/Inheritance
> - **Definition**: The transfer of a resource following the death of the previous owner, either by bequest or by the application of law.
> - **Comment**: Typical associated Activities: TestatorActivity, InheritorActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.
> - **SuperclassOf**: ex:Bequest

**ex:Loan**
> - **Label**: Loan
> - **URI**: http://example.org/Loan
> - **Definition**: The temporary transfer of a resource.
> - **Comment**: Typical associated Activities: LenderActivity, BorrowerActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Loss**
> - **Label**: Loss
> - **URI**: http://example.org/Loss
> - **Definition**: The disappearance  of a resource under unknown circumstances (e.g., not in the case of theft).
> - **Comment**: Typical associated Activities: LossActivity, OwnerActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Offer**
> - **Label**: Offer
> - **URI**: http://example.org/Offer
> - **Definition**: The provision of a resource for purchase or other form of acquisition.
> - **Comment**: Typical associated Activities: OfferActivity, RecipientActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Ownership**
> - **Label**: Ownership
> - **URI**: http://example.org/Ownership
> - **Definition**: The possession of full and complete right of control over a resource.
> - **Comment**: Typical associated Activities: OwnerActivity.
> - **SubclassOf**: ex:CustodialEvent.

**ex:Recovery**
> - **Label**: Recovery
> - **URI**: http://example.org/Recovery
> - **Definition**: The restitution or regaining possession of a resource.
> - **Comment**: Typical associated Activities: RecovererActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Repatriation**
> - **Label**: Repatriation
> - **URI**: http://example.org/Repatriation
> - **Definition**: The return of a resource to its country of origin.
> - **Comment**: Typical associated Activities: RepatriatorActivity
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Sale**
> - **Label**: Sale
> - **URI**: http://example.org/Sale
> - **Definition**: The exchange of a resource for money or other object of value.
> - **Comment**: Typical associated Activities: BuyerActivity, SellerActivity, DealerActivity.
> - **SubclassOf**: ex:CustodialEvent, bf:SaleEvent.

**ex:Theft**
> - **Label**: Theft
> - **URI**: http://example.org/Theft
> - **Definition**: The removal of a resource from the possession of the rightful owner without the latter’s consent.
> - **Comment**: Typical associated Activities: ThiefActivity, OwnerActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Transfer**
> - **Label**: Transfer
> - **URI**: http://example.org/Transfer
> - **Definition**: The passing of ownership or other right from one party to another.
> - **Comment**: Typical associated Activities: TranfererActivity, RecipientActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

--------
**ex:Activity**
> - **Label**: Activity
> - **URI**: http://example.org/Activity
> - **Definition**: An activity or contribution by a single agent that affects or alters the existence or state of a resource.

Activity Subclasses
---------- 

**ex:AccessionerActivity**
> - **Label**: Accessioner
> - **URI**: http://example.org/AccessionerActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of adding a resource to a collection.

**ex:AcquisitionActivity**
> - **Label**: Acquisition
> - **URI**: http://example.org/AcquisitionActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of gaining possession of a resource.

**ex:BorrowerActivity**
> - **Label**: Borrower
> - **URI**: http://example.org/BorrowerActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of taking possession, but not ownership, of a resource.

**ex:BuyerActivity**
> - **Label**: Broker
> - **URI**: http://example.org/BuyerActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of purchasing a resource.

**ex:ClaimantActivity**
> - **Label**: Claimant
> - **URI**: http://example.org/ClaimantActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of declaring ownership of a resource, notably when the claim is not clearly substantiated.

**ex:DeaccessionerActivity**
> - **Label**: Deaccessioner
> - **URI**: http://example.org/DeaccessionerActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of permanently removing accessioned items from a collection or repository.

**ex:DealerActivity**
> - **Label**: Dealer
> - **URI**: http://example.org/DealerActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of negotiating or arranging for a transaction.

**ex:DepositorActivity**
> - **Label**: Depositor
> - **URI**: http://example.org/DepositorActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of placing a resource into the custody of another person, family, or organization.

**ex:DestructionActivity**
> - **Label**: Destroyer
> - **URI**: http://example.org/DestructionActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of permanently destroying a resource.

**ex:DiscarderActivity**
> - **Label**: Discarder
> - **URI**: http://example.org/ex:DiscarderActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of permanently removing a resource or part of a resource from a collection for disposal.

**ex:DisputantActivity**
> - **Label**: Disputant
> - **URI**: http://example.org/DisputantActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of challenging a claim, such as a claim of ownership.

**ex:DonorActivity**
> - **Label**: Donor
> - **URI**: http://example.org/DonorActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of giving a resource to another owner without monetary exchange.

**ex:InheritorActivity**
> - **Label**: Inheritor
> - **URI**: http://example.org/InheritorActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of taking possession of a resource upon the death of the previous owner, either through bequest or application of law.

**ex:LenderActivity**
> - **Label**: Lender
> - **URI**: http://example.org/LenderActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of permitting the temporary possession of one more more Items.

**ex:LossActivity**
> - **Label**: Loss
> - **URI**: http://example.org/LossActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: Responsibility for the disappearance of a resource where the circumstances of the disappearance are unknown.

**ex:OfferActivity**
> - **Label**: Offerer
> - **URI**: http://example.org/OfferActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of providing a resource for purchase or other form of acquisition. Use for booksellers and sellers of other resources.

**ex:OwnerActivity**
> - **Label**: Owner
> - **URI**: http://example.org/OwnerActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The legal possession of a resource.

**ex:PatronActivity**
> - **Label**: Patron
> - **URI**: http://example.org/PatronActivity
> - **SubclassOf**: http://example.org/PatronActivity
> - **Definition**: The activity of commissioning a work. Usually a patron uses his or her means or influence to support the work of artists, writers, etc. This includes those who commission and pay for individual works.

**ex:RecipientActivity**
> - **Label**: Recipient
> - **URI**: http://example.org/RecipientActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of receiving a resource, via bequest, donation, etc.

**ex:RecovererActivity**
> - **Label**: Recoverer
> - **URI**: http://example.org/RecovererActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of re-assuming ownership of a resource following a period of loss, possibly due to theft.

**ex:RepatriatorActivity**
> - **Label**: Repatriator
> - **URI**: http://example.org/RepatriatorActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of returning a resource to its home country.

**ex:SellerActivity**
> - **Label**: Seller
> - **URI**: http://example.org/SellerActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of exchanging ownership of a resource for money or other object of value. 

**ex:TestatorActivity**
> - **Label**: Testator
> - **URI**: http://example.org/TestatorActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of bequeathing a resource in a will.

**ex:ThiefActivity**
> - **Label**: Thief
> - **URI**: http://example.org/ThiefActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of acquiring a resource without the consent of the legal owner.

**ex:TransfererActivity**
> - **Label**: Transferer
> - **URI**: http://example.org/TransfererActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The act of giving possession of a resource to another party, notably without a defined sale or donation.

**ex:WitnessActivity**
> - **Label**: Witness
> - **URI**: http://example.org/WitnessActivity
> - **SubclassOf**: http://example.org/Activity
> - **Definition**: The activity of verifying the truthfulness of an event or action.

**ex:AccessionNumber**
> - **Label**: Accession Number
> - **URI**: http://example.org/AccessionNumber
> - **Definition**: Numeric, alphanumeric, or other identifying code assigned when an art object, book, or other item enters the collection of a museum, library, or other repository. Such codes are unique within the set of codes, and specifically identify the particular item at hand. The numbers may be marked on the objects or not (http://vocab.getty.edu/aat/300312355)
> - **SubclassOf**: http://id.loc.gov/ontologies/bibframe/Identifier  

**bf:Agent**
> - **Label**: Agent
> - **URI**: http://id.loc.gov/ontologies/bibframe/Agent
> - **Definition**: Entity having a role in a resource, such as a person or organization.

**bf:Place**
> - **Label**: Place
> - **URI**: http://id.loc.gov/ontologies/bibframe/Place
> - **Definition**: Geographic location.

**schema:PriceSpecification**
> - **Label**: Price Specification
> - **URI**: https://schema.org/PriceSpecification
> - **Comment**: One or more detailed price specifications, indicating the unit price and delivery or payment charges.



Properties
-----------
**ex:accessions**
> - **Label**: accessions
> - **URI**: http://example.org/accessions
> - **Domain**: ex:AccessionNumber
> - **Range**: ex:CustodialEvent
> - **Definition**: 
> - **Inverse**: ex:accessionedBy

**ex:accessionedBy**
> - **Label**: accessionedBy
> - **URI**: http://example.org/accessionedBy
> - **Domain**: CustodialEvent
> - **Range**: ex:AccessionNumber
> - **Definition**: 
> - **Inverse**: ex:accessions

**ex:hasActivity**
> - **Label**: has activity
> - **URI**: http://example.org/hasActivity
> - **Domain**: unspecified
> - **Range**: http://example.org/Activity
> - **Inverse**: http://example.org/isActivityOf
> - **Definition**: Relates this resource to an activity or contribution by a single agent that affects or alters its existence or state.

**ex:isActivityOf**
> - **Label**: is activity of
> - **URI**: http://example.org/isActivityOf
> - **Domain**: http://example.org/Activity
> - **Range**: unspecified
> - **Inverse**: http://example.org/hasActivity
> - **Definition**: Relates an activity to the affected resource.

**ex:hasCustodialHistory** 
> - **Label**: has custodial history
> - **URI**: http://example.org/hasCustodialHistory
> - **Domain**: unspecified
> - **Range**: ex:CustodialHistory
> - **Inverse**: ex:isCustodialHistoryOf
> - **Definition**: Relates a resource to its custodial history.
> - **Comment**: 

**ex:isCustodialHistoryOf** 
> - **Label**: is custodial history of
> - **URI**: http://example.org/isCustodialHistoryOf
> - **Domain**: ex:CustodialHistory
> - **Range**: unspecified
> - **Inverse**: ex:hasCustodialHistory
> - **Definition**: Relates a CustodialHistory resource to the resource it belongs to.

**bf:hasPart** 
> - **Label**: Has Part
> - **URI**: http://id.loc.gov/ontologies/bibframe/hasPart
> - **Domain**: unspecified
> - **Range**: unspecified
> - **Comment**: Resource that is included either physically or logically in the described resource

**bf:partOf** 
> - **Label**: Is part of
> - **URI**: http://id.loc.gov/ontologies/bibframe/partOf
> - **Domain**: unspecified
> - **Range**: unspecified
> - **Comment**: Resource in which the described resource is physically or logically contained.

**seq:precedes**
> - **Label**: precedes
> - **URI**: http://www.ontologydesignpatterns.org/cp/owl/sequence.owl#precedes
> - **Domain**: owl:Thing
> - **Range**: owl:Thing
> - **Comment**: A relation between entities, expressing a 'sequence' schema. E.g. 'year 1999 precedes 2000', 'deciding what coffee to use' precedes 'preparing coffee', 'World War II follows World War I', 'in the Milan to Rome autoroute, Bologna precedes Florence', etc. It can then be used between tasks, processes, time intervals, spatially locate objects, situations, etc. Subproperties can be defined in order to distinguish the different uses.

**seq:follows**
> - **Label**: follows
> - **URI**: http://www.ontologydesignpatterns.org/cp/owl/sequence.owl#follows
> - **Domain**: owl:Thing
> - **Range**: owl:Thing
> - **Comment**: A relation between entities, expressing a 'sequence' schema. E.g. 'year 2000 follows 1999', 'preparing coffee' follows 'deciding what coffee to use', 'II World War follows I World War', etc. It can be used between tasks, processes or time intervals, and subproperties would fit best in order to distinguish the different uses.

**seq:directlyPrecedes**
> - **Label**: directly precedes
> - **URI**: http://www.ontologydesignpatterns.org/cp/owl/sequence.owl#directlyPrecedes
> - **Domain**: owl:Thing
> - **Range**: owl:Thing
> - **Comment**: The intransitive precedes relation. For example, Monday directly precedes Tuesday. Directness of precedence depends on the designer conceptualization.

**seq:directlyFollows**
> - **Label**: directly follows
> - **URI**: http://www.ontologydesignpatterns.org/cp/owl/sequence.owl#directlyFollows
> - **Domain**: owl:Thing
> - **Range**: owl:Thing
> - **Comment**: The intransitive follows relation. For example, Wednesday directly precedes Thursday. Directness of precedence depends on the designer conceptualization.

**bf:place** 
> - **Label**: Place
> - **URI**: http://id.loc.gov/ontologies/bibframe/place
> - **Domain**: unspecified
> - **Range**: http://id.loc.gov/ontologies/bibframe/Place
> - **Inverse**: unspecified
> - **Definition**: Geographic location or place entity associated with a resource or element of description, such as the place associated with the publication, printing, distribution, issue, release or production of a resource, place of an event.

**ex:isLocationOf** 
> - **Label**: is location of
> - **URI**: http://example.org/isLocationOf
> - **Domain**: http://id.loc.gov/ontologies/bibframe/Place
> - **Range**: unspecified
> - **Inverse**: http://id.loc.gov/ontologies/bibframe/place
> - **Definition**: The resource being described is at the specified location.

**bf:date** 
> - **Label**: Date
> - **URI**: http://id.loc.gov/ontologies/bibframe/date
> - **Domain**: unspecified 
> - **Range**: unspecified
> - **Definition**: Date designation associated with a resource or element of description, such as date of title variation; year a degree was awarded; date associated with the publication, printing, distribution, issue, release or production of a resource. May be date typed.
> - **Comment**: Date may be used to express temporal information at any level of granularity.

**schema:price**
> - **Label**: price
> - **URI**: http://schema.org/price
> - **Domain**: unspecified
> - **Used with**: schema:PriceSpecification
> - **Range**: unspecified
> - **Expected value**: Literal
> - **Definition**: The offer price of a product, or of a price component when attached to PriceSpecification and its subtypes.

**schema:priceCurrency**
> - **Label**: Price Currency
> - **URI**: https://schema.org/priceCurrency
> - **Domain**: unspecified
> - **Used with**: schema:PriceSpecification
> - **Range**: unspecified 
> - **Expected value**: Literal
> - **Definition**: The currency (in 3-letter ISO 4217 format) of the price or a price component, when attached to PriceSpecification and its subtypes.

**schema:priceSpecification**
> - **Label**: Price Specification
> - **URI**: https://schema.org/priceSpecification
> - **Domain**: unspecified
> - **Range**: unspecified 
> - **Expected value**: schema:PriceSpecification
> - **Definition**: One or more detailed price specifications, indicating the unit price and delivery or payment charges.

**bf:agent** 
> - **Label**: Associated agent
> - **URI**: http://id.loc.gov/ontologies/bibframe/agent
> - **Domain**: unspecified 
> - **Range**: bf:Agent
> - **Inverse**: 
> - **Definition**: Relates an activity to its agent.

**ex:agentOf** 
> - **Label**: agent of
> - **URI**: http://example.org/agentOf
> - **Domain**: bf:Agent
> - **Range**: unspecified 
> - **Inverse**: http://id.loc.gov/ontologies/bibframe/agent
> - **Definition**: Relates an agent to the activity it participated in.

<a name="AreasforFutureResearch">Areas for Future Research</a>
========
- Public versus private data in this model is left as an implementation issue. Given that this model contains potentially sensitive data (e.g.: donors, value, etc.), implementers must consider how sensitive data are handled in their application. Note that the public/private issue is not specific to provenance data and extends into other library and non-library data as well.
- Modeling of confidence level. This also applies beyond the provenance domain.
- Consider defining two subclasses of CustodialEvent, one for individual (single Item) and one for aggregate (multi-Item) events. 
    - Originally the custodial history model distinguished aggregate from individual custodial events formally, using two different classes. We then decided that the types of resources would be profiled similarly, with properties and relationships such as activities, dates, locations, price, etc, and we collapsed them into a single class.
    - In working on the application profiles for [VitroLib](https://github.com/ld4l-labs/vitrolib), it now appears to me that the distinction both (a) is important, perhaps *_defining_*, and (b) facilitates application functionality. In general it is not good practice to bend the ontology to suit the application, but in this case the difficulty posed for applications may well suggest a deficiency in the model.
    - The primary difference between the two is that the individual event attaches directly to an item, whereas the aggregate event does not, and attaches only to individual custodial events. This is a fundamental distinction in the semantics and the behavior. The difficulty in the application is that when the user wants to add a bf:partOf relationship between an individual and an aggregate event, he/she should be presented with choices of only the aggregate type - which has no definition in the model other than it is *_not_* attached directly to any items, and is attached directly to a custodial event that *_is_* attached to an item.
    - The proposal would be to define a CustodialEvent class, with two subclasses, IndividualCustodialEvent and AggregateCustodialEvent. This both provides for the common profiling of the two types of custodial events and also models the important distinctions between them.
    - Note also that the aggregate CustodialEvent cannot have an accession number.
- Currently the only hierarchical relationship among CustodialEvent subclasses is that Auction is defined as a subclass of Sale. Consider implementing a deeper class hierarchy in terms of the CustodialEvent subclasses. E.g., Transfer could be a superclass of Bequest, Donation, Sale, etc. Similar remarks apply to the Activity class hierarchy (e.g., ComposerActivity and AuthorActivity should be subclasses of CreatorActivity; all should be subclasses of ContributorActivity), if the Activity model is retained rather than being replaced by the BIBFRAME Contribution model.
- Concurrent and overlapping events. The lending use case, for example, will raise issues of sequencing, overlapping, and concurrency. We should not rely on dates to provide this type of nuanced sequencing since dates (even approximate dates) may not be known.
- Consider use of a predicate such as frapo:hasOutput (also used in the PhysicalCondition model) to express a causal relationship to another event or state (e.g., a sale results in an ownership). This cannot always be determined from sequencing, since there can be gaps in the sequence. 
- How strong is the case for the CustodialHistory class? It is essentially a container for the various CustodialEvent pertaining to a resource. However, there may be assertions on the history as a whole that do not apply to a specific event, such as an annotation. We expect this question to be addressed by implementation of and experimentation with the model, and leave open the possibility of future deprecation.
    - In the particular case of [VitroLib](https://github.com/ld4l-labs/vitrolib) implementation, it was noted that the CustodialHistory node caused some implementation difficulties which also highlighted a probably lack of utility. Since there is a 1-1, immutable relationship between Item and CustodialHistory, there is no point to it _unless_ other attributes may be assigned. (This is not to suggest that the
    model should be constructed to fit particular applications, but is perhaps suggestive of a redundancy in the model.)
- Would there be value in defining a superclass of “static” events such as ownership, parallel to the use of schema:Event? - Would it be a subclass of CustodialEvent, or orthogonal to it, like schema:Event? Are there existing terms for this concept?
- Consider augmenting the Activity class hierarchy by capturing general concepts of “giver” and “recipient” (for the latter, the RecipientActivity is already defined), and defining more specific activities such as SellerActivity, LenderActivity, TestatorActivity, etc. as “givers” and BuyerActivity, BorrowerActivity, InheritorActivity, etc. as subclasses of RecipientActivity.
- The modeling of unary events (with only one associated Activity, such as AccessionerActivity) involves some redundancy. Should the model be made more concise by eliminating the event and allowing an activity to link directly to the CustodialHistory? (Note that this would require keeping the CustodialHistory class in order to fully reconstruct a resource’s custodial history; see above on the value of the CustodialHistory class.) On the other hand, maintaining the Event-Activity distinction allows for other activities related to such an event, not currently apparent, to easily be added.
- Extend the Event-to-Activity model to other modeling areas, and bibliotek-o as a whole, where relevant. Consider renaming Activity to “Role” to clearly differentiate it from an event. The Activity is really the reification of an agent’s role in a resource, whether that be a bibliographic resource or an event, etc.
- Consider expanding CustodialHistory to include non-provenance-related events, such as rebinding. Considerations:
  - May want to replace CustodialHistory with the broader term History, though "custody" defined as “the protective care or guardianship of someone or something" may be broad enough to encompass conservation activities as well. There might be other events in the history of a resource that do not fit under the definition of "custody," however.  
  - What are the pros and cons of including non-custodial and custodial events in the same timeline? 
  - Could provide another argument for allowing Activities to attach directly to the History, rather than requiring an intervening custodial or other event; otherwise, one would need to define events for all the activities in the physical condition model (and perhaps other models): condition assessment activity, conservator activity, etc. Or, as above, do away with the history aggregator node altogether and attach individual events and activities directly to the item. The history would then be reconstructed from the various events and activities rather than provided as a unit in a container node.
  - Would require confronting the issue of overlapping and concurrent events, since conservation activities provide a strong use case (e.g., rebinding during a period of ownership).
- schema:priceSpecification takes a literal value in 3-letter ISO 4217 format as its object; whereas we would like to use URIs if possible. Determine whether an RDF vocabulary for currencies exists, and consider whether it is appropriate to use as object of schema:priceSpecification.