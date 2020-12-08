<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs arm vann owl" version="2.0"
  xmlns:arm="https://w3id.org/arm/core/ontology/0.1/"
  xmlns:dcterms="http://purl.org/dc/terms/"
  xmlns:owl="http://www.w3.org/2002/07/owl#"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:skos="http://www.w3.org/2004/02/skos/core#"
  xmlns:vann="http://purl.org/vocab/vann/"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- 
  
    Converts the RBMS Vocab XML export format to RDF/XML.
    created: 2018-05-08
    @author: timathom
  
  -->

  <xsl:strip-space elements="*"/>
  <xsl:output indent="yes" method="xml"/>

  <xsl:param name="base-uri">https://w3id.org/arm/core/vocabularies/</xsl:param>

  <!-- Current RBMS vocab -->
  <xsl:param name="rbms-vocab">rbms_relationship_designators</xsl:param>

  <!--  <rbms>
    <vocabs>
      <vocab>binding</vocab>
      <vocab>genre</vocab>
      <vocab>paper</vocab>
      <vocab>printing_and_publishing</vocab>
      <vocab>provenance</vocab>
      <vocab>relationship_designators</vocab>
      <vocab>type</vocab>
    </vocabs>
  </rbms>-->

  <!-- id.loc.gov for RBMS -->
  <xsl:param name="rbms">http://id.loc.gov/rwo/agents/n78097904</xsl:param>

  <!-- Current ontology version -->
  <xsl:param name="current-version" select="'0.1'"/>

  <!-- Current base URI -->
  <xsl:variable name="full-uri"
    select="concat($base-uri, $rbms-vocab, '/', $current-version, '/')"/>

  <!-- Key for linking BT, NT, RT -->
  <xsl:key match="CONCEPT" name="termKey" use="DESCRIPTOR"/>

  <xsl:template match="/THESAURUS">    
    <!-- Output thesaurus -->
    <rdf:RDF>
      <!-- Output skos:ConceptScheme resource -->
      <xsl:call-template name="arm:concept-scheme"/>
      <xsl:apply-templates/>
    </rdf:RDF>
  </xsl:template>

  <xsl:template name="arm:concept-scheme">
    <rdf:Description rdf:about="{$full-uri}">
      <rdf:type rdf:resource="http://www.w3.org/2004/02/skos/core#ConceptScheme"/>
      <owl:versionInfo rdf:datatype="http://www.w3.org/2001/XMLSchema#string"
        >Version 0.1.0</owl:versionInfo>
      <dcterms:issued>2018-04-27T00:00:00-04:00</dcterms:issued>
      <dcterms:modified>2018-04-27T00:00:00-04:00</dcterms:modified>
      <rdfs:label xml:lang="en">RBMS <xsl:value-of
          select="arm:vocab-name($rbms-vocab)"/> Vocabulary</rdfs:label>
      <dcterms:title xml:lang="en">RBMS <xsl:value-of
          select="arm:vocab-name($rbms-vocab)"/> Vocabulary</dcterms:title>
      <skos:definition xml:lang="en">The RBMS <xsl:value-of
          select="arm:vocab-name($rbms-vocab)"/> Vocabulary is a controlled vocabulary maintained by the Rare Books and Manuscripts Section of the Association of College and Research Libraries.</skos:definition>
      <vann:preferredNamespacePrefix>
        <xsl:value-of select="$rbms-vocab"/>
      </vann:preferredNamespacePrefix>
    </rdf:Description>
  </xsl:template>

  <!-- Match all terms -->
  <xsl:template match="CONCEPT[DESCRIPTOR]">
    <!-- Construct the concept URI, use the TNR number for uniqueness -->
    <xsl:param name="uri">
      <xsl:variable name="prefix"
        select="
          string-join(
          for $sc in SC
          return
            substring-before($sc, ' ')
          , '')"/>
      <xsl:value-of select="concat($full-uri, $prefix, TNR)"/>
    </xsl:param>
    <rdf:Description rdf:about="{$uri}">
      <rdf:type rdf:resource="http://www.w3.org/2004/02/skos/core#Concept"/>
      <skos:prefLabel xml:lang="en">
        <xsl:value-of select="DESCRIPTOR"/>
      </skos:prefLabel>
      <xsl:apply-templates select="UF"/>
      <skos:inScheme rdf:resource="{$full-uri}"/>
      <xsl:apply-templates select="BT | NT | RT"/>
      <xsl:apply-templates select="CM"/>
      <xsl:apply-templates select="SN"/>
      <xsl:apply-templates select="HN"/>
      <xsl:apply-templates select="STA"/>
      <xsl:apply-templates select="INP | APP | UPD | NVD"/>
    </rdf:Description>
  </xsl:template>

  <xsl:template match="UF">
    <skos:altLabel xml:lang="en">
      <xsl:value-of select="."/>
    </skos:altLabel>
  </xsl:template>

  <xsl:template match="BT | NT | RT">
    <xsl:variable name="node" select="key('termKey', .)"/>
    <xsl:variable name="prefix"
      select="
        string-join(
        for $sc in $node/SC
        return
          substring-before($sc, ' ')
        , '')
        "/>
    <xsl:sequence select="arm:broader-narrower($node, $prefix, name(.))"/>
  </xsl:template>

  <xsl:template match="CM">
    <skos:note xml:lang="en">
      <xsl:value-of select="."/>
    </skos:note>
  </xsl:template>

  <xsl:template match="SN">
    <skos:scopeNote xml:lang="en">
      <xsl:value-of select="."/>
    </skos:scopeNote>
  </xsl:template>

  <xsl:template match="STA">
    <skos:editorialNote xml:lang="en">
      <xsl:value-of select="."/>
    </skos:editorialNote>
  </xsl:template>

  <xsl:template match="HN">
    <skos:historyNote xml:lang="en">
      <xsl:value-of select="."/>
    </skos:historyNote>
  </xsl:template>

  <xsl:template match="INP | APP | UPD | NVD">
    <xsl:param name="uri" tunnel="yes"/>
    <xsl:call-template name="arm:admin-actions">
      <xsl:with-param name="name" select="name(.)"/>
      <xsl:with-param name="term" select="$uri"/>
      <xsl:with-param name="date" select="."/>
    </xsl:call-template>
  </xsl:template>

  <!-- Function to select broader, narrower, or related depending on context -->
  <xsl:function as="element()" name="arm:broader-narrower">
    <xsl:param as="element()" name="node"/>
    <xsl:param as="xs:string" name="prefix"/>
    <xsl:param as="xs:string" name="name"/>

    <xsl:variable name="uri" select="concat($full-uri, $prefix, $node/TNR)"/>
    <xsl:choose>
      <xsl:when test="$name = 'BT'">
        <skos:broader rdf:resource="{$uri}"/>
      </xsl:when>
      <xsl:when test="$name = 'NT'">
        <skos:narrower rdf:resource="{$uri}"/>
      </xsl:when>
      <xsl:when test="$name = 'RT'">
        <skos:related rdf:resource="{$uri}"/>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:function>

  <xsl:function as="xs:string" name="arm:vocab-name">
    <xsl:param as="xs:string" name="vocab"/>
    <xsl:value-of
      select="concat(upper-case(substring($vocab, 6, 1)), substring($vocab, 7))"
    />
  </xsl:function>

  <!-- Named template to convert admin dates to skos:changeNote elements -->
  <xsl:template name="arm:admin-actions">
    <xsl:param name="name"/>
    <xsl:param name="term"/>
    <xsl:param name="date"/>
    <skos:changeNote rdf:parseType="Resource">
      <rdf:value>
        <xsl:value-of select="$name"/>
      </rdf:value>
      <dcterms:creator rdf:resource="{$rbms}"/>
      <dcterms:date>
        <xsl:value-of select="$date"/>
      </dcterms:date>
    </skos:changeNote>
  </xsl:template>

  <xsl:template match="CONCEPT[NON-DESCRIPTOR] | TNR"/>

</xsl:stylesheet>
