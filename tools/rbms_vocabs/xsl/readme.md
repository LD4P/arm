RBMS XML-to-RDF Vocabulary Converter
===================

The stylesheet `rbms_vocabs.xsl` converts the RBMS vocabulary XML exports (see `../data`) to RDF. It accepts three parameters used
to construct the vocabulary namespace:
 
* `base_uri` (default "https://w3id.org/arm/core/vocabularies/") 
* `rbms_vocab` (e.g., "rbms_binding") 
* `current_version` (default "0.1")

The values shown above result in the vocabulary namespace "https://w3id.org/arm/core/vocabularies/rbms_binding/0.1/".