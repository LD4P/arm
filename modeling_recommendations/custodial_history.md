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
"Unrecorded until purchased in 1893 from Agnew's by J. Pierpont Morgan; sold by him at auction in 1905; Christie's 1910; Pres. and Mrs. Nicholas Murray Butler; donated by their estate to Columbia in 1955"

In modeling ownership and custodial history, the ArtFrame and Rare Materials Ontology Extension (RareMat) groups wanted to leverage more queryable data afforded by an entity-focused model; this differs from both current descriptive practice as well as BIBFRAME use of bf:custodialHistory as a datatype property. As such, we recommend using object properties alongside resources for different components of custodial history.

An item's custodial history is complex and provides a rich area for querying. Through the model proposed below, we believe we can both trace individual custodial histories for items in collections while aggregating materials related to the same auction, sale or donation.


<a name="SummaryoftheModel">Summary of the Model</a>
=======

New resource types
------------------
The model posits two new classes for the description of an Item’s custodial history: CustodialEvent and CustodialHistory. 

A CustodialEvent represents a single event or period in the custodial history of an Item, such as a sale, donation, or period of ownership. The CustodialEvents for a specific Item are aggregated and potentially ordered in a CustodialHistory resource representing the entire custodial history of that Item. 

The CustodialEvent directly linked to the CustodialHistory of an Item (hereafter “individual CustodialEvent”) may be part of a larger CustodialEvent (hereafter “aggregate CustodialEvent”) encompassing multiple Items; e.g., a manuscript auctioned together with other manuscripts. Note that these are not distinct types of resources; rather, the distinction is maintained by direct or indirect linkage to an Item’s CustodialHistory. The individual CustodialEvent node intervening between an Item’s CustodialHistory and the aggregate CustodialEvent allows the individual events to be aggregated and sequenced independently of any other Item’s CustodialHistory. 

The CustodialHistory class is provided so that additional assertions can be made about it, distinct from assertions about specific events (the class also has conceptual appeal as a “container” of individual CustodialEvents). Whether this class is useful, as opposed to linking individual CustodialEvents directly to Items, remains to be seen through implementation and experimentation with the model (see Areas for Future Research).   

Relationships between resources
------------------------
-	Only the CustodialHistory resource is linked directly to the Item, via the predicate hasCustodialHistory. Each Item is linked to a maximum of one CustodialHistory.
-	The CustodialHistory of the Item is linked to one or more CustodialEvents via dcterms:hasPart (inverse dcterms:isPartOf).
-	An individual CustodialEvent may be linked to an aggregate CustodialEvent via dcterms:isPartOf (inverse dcterms:hasPart). 
-	Individual CustodialEvents may be sequenced in the CustodialHistory via seq:precedes and seq:follows. 
> -	The modeling of concurrent and overlapping events (e.g., when the loan of a manuscript to one institution overlaps two ownerships) is left for future research. 
> -	Note that seq:precedes and seq:follows do not imply immediate precedence or succession. This allows new event assertions to be interjected between two existing events.
> -	When two CustodialEvents belonging to two different Items are part of the same aggregrate CustodialEvent, they may well occupy different positions in the sequencing of each Item’s CustodialHistory. For example, a sale including two items may be the first event in one Item’s history and the second Event in the other Item’s history.
> -	While the model allows for sequencing of aggregate CustodialEvents, we expect this to have little utility in an implementation.
-	CustodialEvents may be linked to one or more bib:Activity objects, price subgraphs, dates (both intervals and discrete dates), locations, and so on. These relations may pertain to either individual or aggregate CustodialEvents; for example, an entire lot of manuscripts may have been purchased for $100K, but the price of a specific item in the lot was negotiated at $10K and its inclusion in the lot was brokered by an agent not related to the aggregate CustodialEvent.
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

Importantly, this model enhances the bibliotek-o Activity model by providing a way to connect interrelated or interdependent activities. For example, in bibliotek-o we can assert seller and buyer activities on an item, but have no way to express the fact that specific seller and buyer activities are related to one another. If multiple such activities are related to a single item, there is no way to express the relationship of particular activities to one another. Dates may sometimes serve that purpose but cannot be relied upon.

Out-of-scope event and activity types
------
Concepts similar to but disjoint from ownership (i.e., to be represented by other models):
- Publication and production information (e.g., printer holds all items at time of printing)
- Exhibition history (handled in forthcoming Exhibits model)
- Creation activities (e.g., creator holds all items at time of creation)
- Commissions (involves Works rather than Items, not part of the custodial history of an Item)

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
    dcterms:hasPart :individualEvent1 ; :individualEvent2 ,     :individualEvent3 .

:history2 a ex:CustodialHistory ;
    dcterms:hasPart :individualEvent4 .

:individualEvent1 a ex:SaleEvent ; 
    seq:precedes :individualEvent2 ;
    dcterms:isPartOf :aggregateEvent1 .

:individualEvent2 a ex:OwnershipEvent ; 
    seq:precedes :individualEvent3 ;
    
:individualEvent3 a ex:SaleEvent .

:individualEvent4 a ex:CustodialEvent ;
    dcterms:isPartOf :aggregateEvent1 .

:aggregateEvent1 a ex:SaleEvent ;
    bib:hasActivity :sellerActivity1 ;
    dcterms:date “1984”^^edtf:edtf ;
    bib:atLocation <uri-of-location> ;
    schema:priceSpecification :price1 .

:sellerActivity1 a bib:SellerActivity ;
    bib:hasAgent <uri-of-agent> .

:price1 a schema:PriceSpecification ;
    schema:price “10” ;
    schema:priceCurrency <iso-4217-code> .  
```

<a name="RequeststoLibraryofCongress">Requests to Library of Congress</a>
-----------
- Change bf:custodialHistory into an object property
- Define the following classes:
> - bf:CustodialHistory
> - bf:CustodialEvent

If LC does not approve these requests, RareMat/ArtFrame will define these terms in a namespace TBD. In either case, we will define:
- Event types (detailed below)
- Activity types (detailed below)


<a name="TermSpecifications">Term Specifications</a>
========
Classes
-------

**bf:Item**
> - **Label**: Item
> - **URI**: http://id.loc.gov/ontologies/bibframe/Item
> - **Definition**: Single example of an Instance. 

**ex:CustodialHistory**
> - **Label**: Custodial history
> - **URI**: TBD
> - **Definition**: Entity that aggregates all of the custodial events for an Item.
> - **Comment**: An Item has a single ex:CustodialHistory, which is composed of one or more ex:CustodialEvent resources. The Item is directly linked only to its CustodialHistory.


**ex:CustodialEvent**
> - **Label**: Custodial event
> - **URI**: TBD
> - **Definition**: A custodial event encompassing one or more Items, such as a sale or loan.
> - **Comment**: A CustodialEvent may pertain to only a single Item, in which case it is linked directly to the Item’s CustodialHistory, or it may pertain to multiple items (such as an auction lot), in which case the CustodialEvent aggregates multiple CustodialEvents linked directly to an Item’s CustodialHistory. A CustodialEvent may be what is typically conceived of as an “event,” or a “static” event such as Ownership. Subclasses are accordingly either defined as subclasses of schema:Event or not.


CustodialEvent Subclasses
----------
Some of these classes are also defined as subclasses of schema:Event. “Static” events such as Ownership do not subclass schema:Event.

**ex:Accessioning**
> - **Label**: Accessioning
> - **URI**: TBD
> - **Definition**: The act of adding an Item to the accessions records of a cultural heritage institution.
> - **Comment**: Typical associated Activities: AccessionerActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Auction**
> - **Label**: Auction
> - **URI**: TBD
> - **Definition**: The sale at auction of an Item. 
> - **Comment**: Refers to the transfer of ownership through auction, rather than the auction in which that occurs. Typical associated Activities: BuyerActivity, SellerActivity, BrokerActivity.
> - **SubclassOf**: ex:Sale, schema:Event.

**ex:Bequest**
> - **Label**: Bequest
> - **URI**: TBD
> - **Definition**: The transfer of an Item under the terms of a will.
> - **Comment**: Typical associated Activities: TestatorActivity, InheritorActivity.
> - **SubclassOf**: ex:Inheritance, schema:Event

**ex:ClaimOfOwnership**
> - **Label**: Claim of ownership
> - **URI**: TBD
> - **Definition**: A legal claim to the right of possession of an Item.
> - **Comment**: Typical associated Activities: ClaimantActivity, DisputantActivity.
> - **SubclassOf**: ex:CustodialEvent.

**ex:Deaccessioning**
> - **Label**: Deaccessioning
> - **URI**: TBD
> - **Definition**: The removal of an Item from the accessions records of a cultural heritage institution. 
> - **Comment**: Typical associated Activities: DeaccessionerActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Deposit**
> - **Label**: Deposit
> - **URI**: TBD
> - **Definition**: The placement of an Item in the collections of a cultural heritage institution.
> - **Comment**: Typical associated Activities: DepositorActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Destruction**
> - **Label**: Destruction
> - **URI**: TBD
> - **Definition**: The permanent ruination of an Item.
> - **Comment**: Typical associated Activities: DestructionActivity, OwnershipActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Discarding**
> - **Label**: Discarding
> - **URI**: TBD
> - **Definition**: The abandonment or disposal of an Item.
> - **Comment**: Typical associated Activities: DiscarderActivity, OwnershipActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Donation**
> - **Label**: Donation
> - **URI**: TBD
> - **Definition**: The giving of an Item, typically for charitable purposes and/or to benefit a cause.
> - **Comment**: Typical associated Activities: bib:DonorActivity, RecipientActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Inheritance**
> - **Label**: Inheritance
> - **URI**: TBD
> - **Definition**: The transfer of an Item following the death of the previous owner, either by bequest or by the application of law.
> - **Comment**: Typical associated Activities: TestatorActivity, InheritorActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.
SuperclassOf**: ex:Bequest

**ex:Loan**
> - **Label**: Loan
> - **URI**: TBD
> - **Definition**: The temporary transfer of an Item.
> - **Comment**: Typical associated Activities: LenderActivity, BorrowerActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Loss**
> - **Label**: Loss
> - **URI**: TBD
> - **Definition**: The disappearance  of an Item under unknown circumstances (e.g., not in the case of theft).
> - **Comment**: Typical associated Activities: LossActivity, OwnershipActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Offer**
> - **Label**: Offer
> - **URI**: TBD
> - **Definition**: The provision of an Item for purchase or other form of acquisition.
> - **Comment**: Typical associated Activities: OfferActivity, RecipientActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Ownership**
> - **Label**: Ownership
> - **URI**: bib:OwnerActivity
> - **Definition**: The possession of full and complete right of control over an Item.
> - **Comment**: Typical associated Activities: OwnerActivity.
> - **SubclassOf**: ex:CustodialEvent.

**ex:Recovery**
> - **Label**: Recovery
> - **URI**: TBD
> - **Definition**: The restitution or regaining possession of an Item.
> - **Comment**: Typical associated Activities: RecovererActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Repatriation**
> - **Label**: Repatriation
> - **URI**: TBD
> - **Definition**: The return of an Item to its country of origin.
> - **Comment**: Typical associated Activities: RepatriatorActivity
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Sale**
> - **Label**: Sale
> - **URI**: TBD
> - **Definition**: The exchange of an Item for money or other object of value.
> - **Comment**: Typical associated Activities: BuyerActivity, SellerActivity, BrokerActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:SaleEvent.

**ex:Theft**
> - **Label**: Theft
> - **URI**: TBD
> - **Definition**: The removal of an Item from the possession of the rightful owner without the latter’s consent.
> - **Comment**: Typical associated Activities: ThiefActivity, OwnerActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

**ex:Transfer**
> - **Label**: Transfer
> - **URI**: TBD
> - **Definition**: The passing of ownership or other right from one party to another.
> - **Comment**: Typical associated Activities: TranfererActivity, RecipientActivity.
> - **SubclassOf**: ex:CustodialEvent, schema:Event.

--------
**bib:Activity**
> - **Label**: Activity
> - **URI**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: An activity or contribution by a single agent that affects or alters the existence or state of a resource.

Activity Subclasses
---------- 

**ex:AccessionerActivity**
> - **Label**: Accessioner
> - **URI**: TBD
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of adding an item to a collection.

**bib:AcquisitionActivity**
> - **Label**: Acquisition
> - **URI**: http://bibliotek-o.org/1.1/ontology/AcquisitionActivity
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of gaining possession of a resource.

**ex:BorrowerActivity**
> - **Label**: Borrower
> - **URI**: TBD
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of taking possession, but not ownership, of an Item.

**ex:BrokerActivity**
> - **Label**: Broker
> - **URI**: TBD
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of negotiating or arranging for a transaction.

**ex:ClaimantActivity**
> - **Label**: Claimant
> - **URI**: TBD
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of declaring ownership for an Item, notably when the claim is not clearly substantiated.

**ex:DeaccessionerActivity**
> - **Label**: Deaccessioner
> - **URI**: TBD
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of permanently removing accessioned items from a collection or repository.

**bib:DepositorActivity**
> - **Label**: Depositor
> - **URI**: http://bibliotek-o.org/1.1/ontology/DepositorActivity
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of placing an item into the custody of another person, family, or organization.

**ex:DestructionActivity**
> - **Label**: Destroyer
> - **URI**: TBD
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of permanently destroying an Item.

**ex:DiscarderActivity**
> - **Label**: Discarder
> - **URI**: TBD
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of permanently removing an item or part of an item from a collection for disposal.

**ex:DisputantActivity**
> - **Label**: Disputant
> - **URI**: TBD
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of challenging a claim, such as a claim of ownership.

**bib:DonorActivity**
> - **Label**: Donor
> - **URI**: http://bibliotek-o.org/1.1/ontology/DonorActivity
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of giving an Item to another owner without monetary exchange.

**ex:InheritorActivity**
> - **Label**: Inheritor
> - **URI**: TBD
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of taking possession of an Item upon the death of the previous owner, either through bequest or application of law.

**bib:LenderActivity**
> - **Label**: Lender
> - **URI**: http://bibliotek-o.org/1.1/ontology/LenderActivity
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of permitting the temporary possession of one more more Items.

**ex:LossActivity**
> - **Label**: Loss
> - **URI**: Tbd
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: Responsibility for the disappearance of an Item where the circumstances of the disappearance are unknown.

**bib:OfferActivity**
> - **Label**: Offerer
> - **URI**: http://bibliotek-o.org/1.1/ontology/OfferActivity
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of providing an Item for purchase or other form of acquisition. Use for booksellers and sellers of other resources.

**bib:OwnerActivity**
> - **Label**: Owner
> - **URI**: http://bibliotek-o.org/1.1/ontology/OwnerActivity
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The legal possession of an Item..

**ex:RecipientActivity**
> - **Label**: Recipient
> - **URI**: TBD
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of receiving an Item, via bequest, donation, etc.

**ex:RecovererActivity**
> - **Label**: Recoverer
> - **URI**: TBD
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of re-assuming ownership of an Item following a period of loss, possibly due to theft.

**ex:RepatriatorActivity**
> - **Label**: Repatriator
> - **URI**: TBD
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of returning an item to its home country.

**bib:SellerActivity**
> - **Label**: Seller
> - **URI**: http://bibliotek-o.org/1.1/ontology/SellerActivity
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of exchanging ownership of an Item for money or other object of value. 

**ex:TestatorActivity**
> - **Label**: Testator
> - **URI**: TBD
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of bequeathing an Item in a will.

**ex:ThiefActivity**
> - **Label**: Thief
> - **URI**: TBD
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of acquiring an Item without the consent of the legal owner.

**ex:TransfererActivity**
> - **Label**: Transferer
> - **URI**: TBD
> - **SubclassOf**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Definition**: The act of giving possession of an Item to another party, notably without a defined sale or donation.

**ex:AccessionNumber**
> - **Label**: AccessionNumber
> - **URI**: TBD
> - **Definition**: Numeric, alphanumeric, or other identifying codes assigned when an art object, book, or other item enters the collection of a museum, library, or other repository. Such codes are unique within the set of codes, and specifically identify the particular item at hand. The numbers may be marked on the objects or not. (http://vocab.getty.edu/aat/300312355)
> - **SubclassOf**: http://id.loc.gov/ontologies/bibframe/Identifier  

**foaf:Agent**
> - **Label**: Agent
> - **URI**: http://xmlns.com/foaf/0.1/Agent
> - **Definition**: An agent (eg. person, group, software or physical artifact).

**prov:Location**
> - **Label**: Location
> - **URI**: http://www.w3.org/ns/prov#Location
> - **Definition**: A location can be an identifiable geographic place (ISO 19112), but it can also be a non-geographic place such as a directory, row, or column. As such, there are numerous ways in which location can be expressed, such as by a coordinate, address, landmark, and so forth.

**schema:PriceSpecification**
> - **Label**: Price Specification
> - **URI**: https://schema.org/PriceSpecification
> - **Comment**: One or more detailed price specifications, indicating the unit price and delivery or payment charges.



Properties
-----------
**ex:accessions**
> - **Label**: accessions
> - **URI**: TBD
> - **Domain**: ex:AccessionNumber
> - **Range**: unspecified
> - **Definition**: 
> - **Inverse**: ex:accessionedBy

**ex:accessionedBy**
> - **Label**: accessionedBy
> - **URI**: TBD
> - **Domain**: unspecified
> - **Range**: ex:AccessionNumber
> - **Definition**: 
> - **Inverse**: ex:accessions

**bib:hasActivity**
> - **Label**: has activity
> - **URI**: http://bibliotek-o.org/1.1/ontology/hasActivity
> - **Domain**: unspecified
> - **Range**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Inverse**: http://bibliotek-o.org/1.1/ontology/isActivityOf
> - **Definition**: Relates this resource to an activity or contribution by a single agent that affects or alters its existence or state.

**bib:isActivityOf**
> - **Label**: is activity of
> - **URI**: http://bibliotek-o.org/1.1/ontology/isActivityOf
> - **Domain**: http://bibliotek-o.org/1.1/ontology/Activity
> - **Range**: unspecified
> - **Inverse**: http://bibliotek-o.org/1.1/ontology/hasActivity
> - **Definition**: Relates an activity to the affected resource.

**ex:hasCustodialHistory** 
> - **Label**: has custodial history
> - **URI**: TBD
> - **Domain**: bf:Item
> - **Range**: ex:CustodialHistory
> - **Inverse**: ex:isCustodialHistoryOf
> - **Definition**: Relates a bf:Item to its ex:CustodialHistory resource.
> - **Comment**: 

**ex:isCustodialHistoryOf** 
> - **Label**: is custodial history of
> - **URI**: TBD
> - **Domain**: ex:CustodialHistory
> - **Range**: bf:Item
> - **Inverse**: ex:hasCustodialHistory
> - **Definition**: Relates a bf:Item to its ex:CustodialHistory resource.

**dcterms:hasPart** 
> - **Label**: Has Part
> - **URI**: http://purl.org/dc/terms/hasPart
> - **Domain**: unspecified
> - **Range**: unspecified
> - **Comment**: A related resource that is included either physically or logically in the described resource.

**dcterms:isPartOf** 
> - **Label**: Is Part Of
> - **URI**: http://purl.org/dc/terms/isPartOf
> - **Domain**: unspecified
> - **Range**: unspecified
> - **Comment**: A related resource in which the described resource is physically or logically included.

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
> - **Comment**: "A relation between entities, expressing a 'sequence' schema. E.g. 'year 2000 follows 1999', 'preparing coffee' follows 'deciding what coffee to use', 'II World War follows I World War', etc. It can be used between tasks, processes or time intervals, and subproperties would fit best in order to distinguish the different uses."

**bib:atLocation** 
> - **Label**: at location
> - **URI**: http://bibliotek-o.org/1.1/ontology/atLocation
> - **Domain**: unspecified
> - **Range**: http://www.w3.org/ns/prov#Location
> - **Inverse**: http://bibliotek-o.org/1.1/ontology/isLocationOf
> - **Definition**: The resource being described is at the specified location.

**bib:isLocationOf** 
> - **Label**: isLocationOf
> - **URI**: http://bibliotek-o.org/1.1/ontology/isLocationOf
> - **Domain**: http://www.w3.org/ns/prov#Location
> - **Range**: unspecified
> - **Inverse**: http://bibliotek-o.org/1.1/ontology/atLocation
> - **Definition**: The resource being described is at the specified location.

**dcterms:date** 
> - **Label**: date
> - **URI**: http://purl.org/dc/terms/date
> - **Domain**: unspecified 
> - **Range**: unspecified
> - **Definition**: A point or period of time associated with an event in the lifecycle of the resource.
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

**bib:hasAgent** 
> - **Label**: has agent
> - **URI**: http://bibliotek-o.org/1.1/ontology/hasAgent
> - **Domain**: unspecified 
> - **Range**: foaf:Agent
> - **Inverse**: http://bibliotek-o.org/1.1/ontology/isAgentOf
> - **Definition**: Relates an activity to its agent.

**bib:isAgentOf** 
> - **Label**: is agent of
> - **URI**: http://bibliotek-o.org/1.1/ontology/isAgentOf
> - **Domain**: foaf:Agent
> - **Range**: unspecified 
> - **Inverse**: http://bibliotek-o.org/1.1/ontology/hasAgent
> - **Definition**: Relates an agent to the activity it participated in.

<a name="AreasforFutureResearch">Areas for Future Research</a>
========
- Public versus private data in this model is left as an implementation issue. Given that this model contains potentially sensitive data (e.g.: donors, value, etc.), implementers must consider how sensitive data are handled in their application. Note that the public/private issue is not specific to provenance data and extends into other library and non-library data as well.
- Modeling of confidence level. This also applies beyond the provenance domain.
- Concurrent and overlapping events. The lending use case, for example, will raise issues of sequencing, overlapping, and concurrency. We should not rely on dates to provide this type of nuanced sequencing since dates (even approximate dates) may not be known.
- Consider use of a predicate such as frapo:hasOutput (also used in the PhysicalCondition model) to express a causal relationship to another event or state (e.g., a sale results in an ownership). This cannot always be determined from sequencing, since there can be gaps in the sequence. 
- How strong is the case for the CustodialHistory class? It is essentially a container for the various CustodialEvent pertaining to an Item. However, there may be assertions on the history as a whole that do not apply to a specific event, such as an annotation. We expect this question to be addressed by implementation of and experimentation with the model, and leave open the possibility of future deprecation.
- Would there be value in defining a superclass of “static” events such as ownership, parallel to the use of schema:Event? - Would it be a subclass of CustodialEvent, or orthogonal to it, like schema:Event? Are there existing terms for this concept?
- Consider augmenting the Activity class hierarchy by capturing general concepts of “giver” and “recipient” (for the latter, the RecipientActivity is already defined), and defining more specific activities such as SellerActivity, LenderActivity, TestatorActivity, etc. as “givers” and BuyerActivity, BorrowerActivity, InheritorActivity, etc. as subclasses of RecipientActivity.
- The modeling of unary events (with only one associated Activity, such as AccessionerActivity) involves some redundancy. Should the model be made more concise by eliminating the event and allowing an activity to link directly to the CustodialHistory? (Note that this would require keeping the CustodialHistory class in order to fully reconstruct an Item’s custodial history; see above on the value of the CustodialHistory class.) On the other hand, maintaining the Event-Activity distinction allows for other activities related to such an event, not currently apparent, to easily be added.
- Extend the Event-to-Activity model to other modeling areas, and bibliotek-o as a whole, where relevant. Consider renaming Activity to “Role” to clearly differentiate it from an event. The Activity is really the reification of an agent’s role in a resource, whether that be a bibliographic resource or an event, etc.
- Consider expanding CustodialHistory to include non-provenance-related events, such as rebinding. Considerations:
  - May want to replace CustodialHistory with the broader term History, though "custody" defined as “the protective care or guardianship of someone or something" may be broad enough to encompass conservation activities as well. There might be other events in the history of an item that do not fit under the definition of "custody," however.  
  - What are the pros and cons of including non-custodial and custodial events in the same timeline? 
  - Could provide another argument for allowing Activities to attach directly to the History, rather than requiring an intervening custodial or other event; otherwise, one would need to define events for all the activities in the physical condition model (and perhaps other models): condition assessment activity, conservator activity, etc. Or, as above, do away with the history aggregator node altogether and attach individual events and activities directly to the item. The history would then be reconstructed from the various events and activities rather than provided as a unit in a container node.
  - Would require confronting the issue of overlapping and concurrent events, since conservation activities provide a strong use case (e.g., rebinding during a period of ownership).