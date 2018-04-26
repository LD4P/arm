# Generating HTML LODE documentation

TODO: Move some of this to /doc/publish.md
TODO: Also try moving this to a central location so it doesn't have to be repeated for each ontology. Might be hard to follow, though.

File and directory names used in examples:
* Original ontology file: `/award/award.owl`
* Ontology IRI: `https://w3id.org/arm/award/ontology/`
* Version IRI: `https://w3id.org/arm/award/ontology/0.1/`
* Current version: `0.1.0`
* Generated HTML file: `/award/documentation/lode/ontology.html`
* Generated accompanying CSS and Javascript files in '/award/documentation/lode/ontology_files/`
* Published OWL file: `/site/award/0.1/ontology.owl`
* Published HTML LODE file: `/site/award/0.1/ontology.owl`             
* Published CSS and JavaScript files: `/site/award/0.1/ontology_files/`


* The generated documentation remaining in `/award/documentation/lode` is always for the current (most recent) version of the ontology.


## Prepare the ontology source file

* The LODE generator recognizes only a limited number of annotation properties, including `rdfs:comment` but not `skos:definition`. Therefore, create a temporary copy of the ontology file in which `skos:definition` is replaced by `rdfs:comment`:

`$ cd /award`
`$ sed 's/skos:definition/rdfs:comment/g' award.owl > documentation/lode/award.owl`

## Generate the LODE documentation

* In a browser, navigate to `http://www.essepuntato.it/lode`, upload the temporary OWL file, and generate the documentation.
* Delete the temporary OWL file `/award/documentation/lode/award.owl` (or save in case this step needs to be redone and delete at the end)


## Save the LODE documentation

* Save the LODE output as `/award/documentation/lode/ontology.html`. Save as Webpage, Complete to save the CSS and Javascript as separate files in the directory `/award/documentation/lode/ontology_files` directory. This is required because if the LODE documentation is saved as a single HTML file, it links to CSS and Javascript on the Essepuntato site. Because the ontologies are served under HTTPS and the Essepuntato site uses HTTP, the Essepunto files cannot be accessed from the online document. 


## Fix the links in the HTML file

Internal links to ontology terms in the HTML file are of the form `http://www.essepuntato.it/lode/http://www.essepuntato.it/tmp/1500045826-ontology#` followed by a hexidecimal value, such as `http://www.essepuntato.it/lode/http://www.essepuntato.it/tmp/1500045826-ontology#d4e783`. To allow dereferencing of URLs such as `https://w3id.org/arm/award/0.1/ontology#Binding` to the ontology HTML page, the links need to be modified accordingly. This is done in three steps:

* Remove the portion of the links up to the `#` character in the HTML file:

`$ cd `/award/documentation/lode`
`$ sed -E 's%http://www.essepuntato.it/lode/http://www.essepuntato.it/tmp/[^#]+#%#%g' ontology.html > temp.html`

* Delete the original HTML file:

`$ rm ontology.html`


* Change the hexadecimal anchor values to the local name of the ontology term using the `fix-anchors.py` script. First modify hard-coded values in the script.

  * In `/award/documentation/lode/fix-anchors.py`, make sure the hard-coded input and output file names are `temp.html` and `ontology.html`, respectively.
  * In `/award/documentation/lode/fix-anchors.py`, change the prefix variable value to the new `owl:versionIRI`. For example, if the new `owl:versionIRI` is `https://w3id.org/arm/award/ontology/0.1`, the code will read `prefix = 'https://w3id.org/arm/award/ontology/0.1/'`.
  * In the `/award/documentation/lode/` directory, run `./fix-anchors.py`. This outputs a new file `ontology.html` with meaningful anchors. 
  * Delete the temporary HTML file `temp.html`.

* In `ontology.html`, find the anchor tag around "Ontology source" and change the href value to the current `owl:versionIRI`+ `ontology.owl` extension; for example, to `https://w3id.org/arm/award/ontology/0.1/ontology.owl`.

Note that the Essepuntato output will change from time to time, so check for other links to the Essepuntato site and modify as appropriate.

## Copy OWL and HTML files to the publication directory

* Copy the OWL, HTML, and accompanying directory to the publication directory in `/site`.

`$ cp /award/award.owl /site/award/0.1/ontology.owl`
`$ cp /award/documentation/lode/ontology.html /site/award/0.1/`
`$ cp /award/documentation/lode/ontology_files /site/award/0.1/`

The HTML and accompanying files should also remain in `/award/documentation/lode/` as part of the distribution package.

## Commit, push, and merge

* Commit and push all files to GitHub. Merge to master for publication.
