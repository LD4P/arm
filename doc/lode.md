# Generating HTML LODE documentation

TODO: Move some of this to /doc/publish.md
TODO: Also try moving this to a central location so it doesn't have to be repeated for each ontology. Might be hard to follow, though.

File and directory names used in examples:
* Original ontology file: `/award/award.rdf`
* Ontology IRI: `https://w3id.org/arm/award/ontology/`
* Version IRI: `https://w3id.org/arm/award/ontology/0.1/`
* Generated HTML file: `/award/documentation/lode/award.html`
* Generated accompanying CSS and Javascript files in '/award/documentation/lode/award_files/`

* TBD Where previous versions will reside

## Prepare the ontology source file

* The LODE generator recognizes only a limited number of annotation properties, including `rdfs:comment` but not `skos:definition`. Therefore, create a temporary copy of the ontology file in which `skos:definition` is replaced by `rdfs:comment`:

`$ cd /award`
`$ sed 's/skos:definition/rdfs:comment/g' award.rdf > documentation/lode/award.rdf`

## Generate the LODE documentation

* In a browser, navigate to `http://www.essepuntato.it/lode`, upload the temporary OWL file, and generate the documentation.
* Delete the temporary OWL file `/award/documentation/lode/award.rdf` (or save in case this step needs to be redone and delete at the end)


## Save the LODE documentation

* Save the LODE output as `/award/documentation/lode/award.html`. Save as Webpage, Complete to save the CSS and Javascript as separate files in the directory `/award/documentation/lode/award_files` directory. This is required because if the LODE documentation is saved as a single HTML file, it links to CSS and Javascript on the Essepuntato site. Because the ontologies are served under HTTPS and the Essepuntato site uses HTTP, the Essepunto files cannot be accessed from the online document. 


## Fix the links in the HTML file

Internal links to ontology terms in the HTML file are of the form `http://www.essepuntato.it/lode/http://www.essepuntato.it/tmp/1500045826-ontology#` followed by a hexidecimal value, such as `http://www.essepuntato.it/lode/http://www.essepuntato.it/tmp/1500045826-ontology#d4e783`. To allow dereferencing of URLs such as `https://w3id.org/arm/award/0.1/ontology#Binding` to the ontology HTML page, the links need to be modified accordingly. This is done in three steps:

* Remove the portion of the links up to the `#` character in the HTML file:

`$ cd `/award/documentation/lode`
`$ sed -E 's%http://www.essepuntato.it/lode/http://www.essepuntato.it/tmp/[^#]+#%#%g' award.html > temp.html`

* Delete the original HTML file:

`$ rm award.html`

* Change the hexadecimal anchor values to the local name of the ontology term using the `fix-anchors.py` script. First modify hard-coded values in the script.

  * In `/award/documentation/lode/fix-anchors.py`, make sure the hard-coded input and output file names are `temp.html` and `award.html`, respectively.
  * In `/award/documentation/lode/fix-anchors.py`, change the prefix variable value to the new `owl:versionIRI`. For example, if the new `owl:versionIRI` is `https://w3id.org/arm/award/ontology/0.1`, the code will read `prefix = 'https://w3id.org/arm/award/ontology/0.1/'`.
  * In the `/award/documentation/lode/` directory, run `./fix-anchors.py`. This outputs a new file `award.html` with meaningful anchors. 
  * Delete the temporary HTML file `temp.html`.

* Change the link to the rdf source file: In `award.html`, find the anchor tag around "Ontology source" and change the href value to the current `owl:versionIRI`+ `award.rdf` extension; for example, to `https://w3id.org/arm/award/ontology/0.1/award.rdf`. For vocabularies (as opposed to ontologies) change the link text from "Ontology source" to "Vocabulary source".

Note that the Essepuntato output will change from time to time, so check for other links to the Essepuntato site and modify as appropriate.

## Commit, push, and merge

* If you did not already delete temporary files in the preceding steps, delete them before committing to git:

`$ cd /award/documentation/lode`
`$ rm temp.html award.rdf`

* Commit and push all files to GitHub. Merge to master for publication.
