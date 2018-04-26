# Generating bibliotek-o LODE documentation

## Generate the LODE documentation
* The LODE generator recognizes only a limited number of annotation properties; `rdfs:comment` but not `skos:definition` is recognized. Therefore, create a temporary copy of the ontology file in which `skos:definition` is replaced by `rdfs:comment`:

`sed s/skos:definition/rdfs:comment/g' bibliotek-o.owl > temp.owl`

* In a browser, navigate to `http://www.essepuntato.it/lode`, upload the temporary OWL file, and generate the documentation.


## Save the LODE documentation

* Save the result as `/doc/lode/ontology.html`. Save as Webpage, Complete to save the CSS and Javascript as separate files in an `ontology_files` directory. This is required because when the LODE documentation is saved as a single HTML file, it links to CSS and Javascript on the Essepuntato site. Because bibliotek-o is served under HTTPS and the Essepuntato site uses HTTP, the files cannot be accessed from the bibliotek-o site. 
* Delete the temporary OWL file.

## Fix the links in the HTML file

Internal links to ontology terms in the HTML file are of the form `http://www.essepuntato.it/lode/http://www.essepuntato.it/tmp/1500045826-ontology#` followed by a hexidecimal value, such as `http://www.essepuntato.it/lode/http://www.essepuntato.it/tmp/1500045826-ontology#d4e783`. To allow dereferencing of URLs such as `http://bibliotek-o.org/ontology#AuthorActivity` to the ontology HTML page, the links need to be modified accordingly. This is done in three steps:

* Remove the portion of the links up to the `#` character:

`sed -E 's%http://www.essepuntato.it/lode/http://www.essepuntato.it/tmp/[^#]+#%#%g' ontology.html > bibliotek-o.html`

* Change the hexadecimal anchor values to the local name of the ontology term using the `fix-anchors.py` script.

  * In `/doc/lode/fix-anchors.py`, change the prefix variable value to the new `owl:versionIRI`. For example, if the new `owl:versionIRI` is `http://bibliotek-o.org/1.1/ontology/`, the code will read `prefix = 'http://bibliotek-o.org/1.1/ontology/'`.
  * In the `/doc/lode/` directory, run `./fix-anchors.py`. This outputs a new file `/doc/lode/ontology.html` with meaningful anchors. Note that the name and location of both the input and output HTML files are hard-coded into the script.
  * Delete the `/doc/lode/bibliotek-o.html` file.

* In `ontology.html`, find the anchor around "Ontology source" and change the href value to the current `owl:versionIRI`+ `.owl` extension; for example, to `http://bibliotek-o.org/1.1/ontology.owl`.

* In `ontology.html`, delete the link tag and text "(visualise it with LODE)":

`(<a href="http://www.essepuntato.it/lode/owlapi/http://bibliotek-o.org/1.0/ontology/">visualise it with LODE</a>)`

* Delete /doc/lode/bibliotek-o.html`.

Note that the Essepuntato ouput will change from time to time, so check for other links to the Essepuntato site and modify as appropriate.

## Copy, commit, and push

* Copy the file `ontology.html` and directory `ontology_files` to the appropriate subdirectory of `/site/`; in this example, `/site/1.1/`, leaving the original files in `/doc/lode/`.
* Commit and push all files to GitHub.
