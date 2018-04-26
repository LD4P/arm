#!/usr/bin/env python
"""Fix up anchors in the bibliotek-o LODE ontology document so that terms resolve.

The output of LODE is an HTML document with meaningless anchors which
means that we can't readily make the ontology URIs nicely resolve the
the appropriate definitions. This script goes through the HTML looking
for terms in the ontology and rewriting anchors to be the local part of
the URI.

Note that if there are cases where one ontology term is described in multiple 
places within the ontology, the rewrite of anchors takes the first occurrence
in the HTML as the anchor to change.

Before running the script, change the prefix value to the versionIRI of the
ontology: e.g., http://bibliotek-o.org/1.2/ontology for version 1.2.x.

After running this script, change the href on the "Ontology Source" link
to http://biblioteko-org/ontology.owl.

Created: Simeon Warner - 2016-01-22
Modified: Rebecca Younes - 2018-04-22
"""

import re

html = open('temp.html','r').read()
prefix = 'https://w3id.org/arm/award/ontology/0.1/'

## Pass 1 - find anchors to change
terms = {}
seen_anchors = set()
for m in re.findall(r'''<a href="#([0-9a-f]+)" title="([^"]+)"''',html):
    anchor = m[0]
    uri = m[1]
    # Only want URIs in this namespace
    lmatch = re.match(prefix+r'''(\w+)$''', uri)
    if (lmatch):
        term = lmatch.group(1)
        if (term in terms):            
            if (terms[term] != anchor and anchor not in seen_anchors):
                ns = prefix if (not lmatch.group(1)) else prefix + lmatch.group(1)
                print "Ignoring additional anchor %s, already have %s for %s%s" % (anchor, terms[term], ns, term)
                seen_anchors.add(anchor)
        else:
            terms[term] = anchor

## Pass 2 - implement changes
for term, anchor in terms.items():
    print "Replacing anchor %s with %s" % (anchor, term)
    html = re.sub(' id="'+anchor+'"',' id="'+term+'"',html)
    html = re.sub(' href="#'+anchor+'"',' href="#'+term+'"',html)

open('ontology.html','w').write(html)
