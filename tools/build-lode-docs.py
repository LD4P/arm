#!/usr/bin/env python
"""Build LODE documentation for the ARM ontologies and vocabularies.

Designed to be run from the root directory with:

> python tools/build-lode-docs.py

and assumes paths for RDF files as set in the RDF_FILES list with
paths relative to the repository root.
"""
import argparse
import logging
import os.path
import re
from requests_toolbelt import MultipartEncoder
import requests

LODE_SERVICE = 'http://www.essepuntato.it/lode'
BASE = '/arm'

RDF_FILES = [
    'award/ontology/0.1/award.rdf',
    'activity/ontology/0.1/activity.rdf',
    'core/ontology/0.1/core.rdf',
    'core/vocabularies/arrangement/0.1/arrangement.rdf',
    'core/vocabularies/handwriting_type/0.1/handwriting_type.rdf',
    'core/vocabularies/origin/0.1/origin.rdf',
    'core/vocabularies/status/0.1/status.rdf',
    'core/vocabularies/typeface/0.1/typeface.rdf',
    'custodial_history/ontology/0.1/custodial_history.rdf',
    'measurement/ontology/0.1/measurement.rdf'
]


def get_namespace(rdfxml):
    """Get ontology or vocabulary namespace from the RDF/XML.

    look for either:
      * owl:versionIRI property for the ontologies
      * else the owl:Ontology (was void:Dataset before munging)
        type definition for the vocabularies
    """
    from rdflib.graph import Graph
    from rdflib.namespace import RDF, OWL, VOID
    g = Graph()
    g.parse(data=rdfxml, format="application/rdf+xml")
    # Look for owl:versionIRI first (_assume_ only one!)
    for s, p, o in g.triples((None, OWL.versionIRI, None)):
        return str(o)
    # Look for void:Dataset second (_assume_ only one!)
    for s, p, o in g.triples((None, RDF.type, OWL.Ontology)):
        return str(s)
    # Else, oops
    raise Exception("Failed to find namespace!")


def get_lode(rdfxml):
    """Get LODE HTML document for given rdfxml.

    Returns LODE HTML as a string.

    curl -H 'Expect:'
         -F "url="
         -F "file=@award/ontology/0.1/temp.rdf;filename=temp.rdf"
         -F "module="
         -F "lang_label="
         http://www.essepuntato.it/lode
    """
    m = MultipartEncoder(
        fields={'url': '',
                'file': ('file.rdf', rdfxml, 'application/xml+rdf'),
                'module': '',
                'lang_label': ''}
    )
    r = requests.post(LODE_SERVICE, data=m,
                      headers={'Content-Type': m.content_type})
    # Get bytes back and decode as UTF-8 string
    return(r.content.decode("utf-8"))


def fix_anchors(html, namespace):
    """Fix anchors in LODE html, returns modified HTML."""
    # Pass 1 - find anchors to change
    terms = {}
    seen_anchors = set()
    for m in re.findall(r'''<a href="#([0-9a-f]+)" title="([^"]+)"''', html):
        anchor = m[0]
        uri = m[1]
        # Only want URIs in this namespace
        lmatch = re.match(namespace + r'''(\w+)$''', uri)
        if (lmatch):
            term = lmatch.group(1)
            if (term in terms):
                if (terms[term] != anchor and anchor not in seen_anchors):
                    ns = namespace if (not lmatch.group(1)) else namespace + lmatch.group(1)
                    logging.info(" - ignoring additional anchor %s, already have %s for %s%s" % (anchor, terms[term], ns, term))
                    seen_anchors.add(anchor)
            else:
                terms[term] = anchor
    # Pass 2 - implement changes
    for term, anchor in terms.items():
        logging.info(" - replacing anchor %s with %s" % (anchor, term))
        html = re.sub(' id="' + anchor + '"', ' id="' + term + '"', html)
        html = re.sub(' href="#' + anchor + '"', ' href="#' + term + '"', html)
    return html


def fix_links(html, source):
    """Fix source link in LODE HTML."""
    text = "Ontology source"
    if '/vocabularies/' in source:
        text = "Vocabulary source"
        # This is a nasty kludge to fix up the presentation of IRI
        # and versionIRI which aren't in our void:Dataset description
        # for the vocabularies. Takes the URI that LODE outputs as
        # IRI and strips version suffix, puts full version URI in
        # LODE's empty Version IRI field
        html = re.sub(r'''(<dt>IRI:</dt><dd>)(https://w3id.org/[^\d]+)(\d\.\d/)(</dd>)''',
                      r'''\1\2\4''' + '<dt>Version IRI:</dt><dd>' + r'''\2\3''' + '</dd>',
                      html)
    # <a href="http://ee....">Ontology source</a>
    html = re.sub(r'''<a href="[^"]+">Ontology source</a>''',
                  '<a href="' + source + '">' + text + '</a>',
                  html)
    # .../*.css -> /css/*.css
    html = re.sub(r'''http://eelst\.cs\.unibo\.it/apps/LODE/([\w+\.]+\.css|favicon.ico)''',
                  BASE + r'''/css/\1''',
                  html)
    # .../*.js -> /js/*.js
    html = re.sub(r'''http://eelst\.cs\.unibo\.it/apps/LODE/([\w\.]+\.js)''',
                  BASE + r'''/js/\1''',
                  html)
    return html


def create_lode_html(rdf_file):
    """Create LODE HTML for one RDF file."""
    logging.info("Creating LODE docs for %s" % (rdf_file))
    (base, filename) = os.path.split(rdf_file)
    (filebase, fileext) = os.path.splitext(filename)
    html_file = os.path.join(base, filebase + '.html')
    # Read and massage RDF/XML
    rdfxml = ''
    with open(rdf_file, 'r') as fh:
        for line in fh:
            # LODE wants to see rdfs:comment to pull out abstract
            line = re.sub('skos:definition', 'rdfs:comment', line)
            # LODE is designed to deal only with OWL ontologies and thus
            # ignores the void:Dataset description in the vocabulary
            # files. Here we recklessly change the type which means that
            # title, abstract, etc. get pulled out OK.
            line = re.sub('void:Dataset', 'owl:Ontology', line)
            rdfxml += line
    logging.debug("Massaged RDF/XML:\n" + rdfxml)
    # Extract namespace from XML
    namespace = get_namespace(rdfxml)
    logging.info(" - namespace %s" % (namespace))
    # Get LODE documentation
    html = get_lode(rdfxml)
    if re.search('LODE error', html):
        logging.warn("Error from LODE service, skipping\n\n" + html + "\n\n")
        return
    logging.debug("HTML from LODE service:\n" + html)
    # Massage HTML for our use
    html = fix_anchors(html, namespace)
    html = fix_links(html, os.path.join(namespace, filename))
    # Write out
    with open(html_file, 'w') as fh:
        fh.write(html)
    logging.info(" - written %s" % (html_file))


# If run from command line...
if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="Build LODE documentation for the ARM ontologies and vocabularies. "
                    "Will process all files to regerenate documentation unless -s option "
                    "is used to specify particular source file(s).")
    parser.add_argument('--src', '-s', action='append', default=[],
                        help="specific source file(s)")
    parser.add_argument('--verbose', '-v', action='store_true',
                        help="be more verbose")
    args = parser.parse_args()
    logging.basicConfig(level=logging.DEBUG if args.verbose else logging.INFO)
    rdf_files = args.src if (len(args.src) > 0) else RDF_FILES
    for rdf_file in rdf_files:
        create_lode_html(rdf_file)
    logging.info("Done.")
