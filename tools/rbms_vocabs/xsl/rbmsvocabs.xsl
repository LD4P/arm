<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs arm" version="3.0"
  xmlns:arm="https://w3id.org/arm/core/vocabularies/rbms_binding/0.1#"
  xmlns:dcterms="http://purl.org/dc/terms/"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:skos="http://www.w3.org/2004/02/skos/core#"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- 
  
    Converts the RBMS Vocab XML export format to RDF/XML.
    created: 2018-05-08
    @author: timathom
  
  -->

  <xsl:strip-space elements="*"/>
  <xsl:output indent="yes" method="xml"/>

  <!-- Current base URI -->
  <xsl:param name="base-uri"
    >https://w3id.org/arm/core/vocabularies/rbms_binding/0.1</xsl:param>

  <!-- id.loc.gov for RBMS -->
  <xsl:param name="rbms">http://id.loc.gov/rwo/agents/n78097904</xsl:param>

  <!-- Key for linking BT, NT, RT -->
  <xsl:key match="CONCEPT" name="termKey" use="DESCRIPTOR"/>

  <xsl:template match="/THESAURUS">
    <rdf:RDF>
      <xsl:apply-templates/>
    </rdf:RDF>
  </xsl:template>

  <!-- Match all terms -->
  <xsl:template match="CONCEPT[DESCRIPTOR]">
    <!-- Construct the concept URI, use the TNR number for uniqueness -->
    <xsl:param name="uri">
      <xsl:value-of
        select="concat($base-uri, concat('/', substring-before(SC, ' '), TNR))"
      />
    </xsl:param>
    <rdf:Description rdf:about="{$uri}">
      <rdf:type rdf:resource="http://www.w3.org/2004/02/skos/core#Concept"/>
      <skos:prefLabel xml:lang="en">
        <xsl:value-of select="DESCRIPTOR"/>
      </skos:prefLabel>
      <xsl:apply-templates select="UF"/>
      <skos:inScheme rdf:resource="{$base-uri}"/>
      <xsl:apply-templates select="BT | NT | RT"/>
      <xsl:apply-templates select="CM"/>
      <xsl:apply-templates select="SN"/>
      <xsl:apply-templates select="HN"/>
      <xsl:apply-templates select="STA"/>
      <xsl:apply-templates select="INP | APP | UPD | NVD">
        <!-- Pass the concept URI to the skos:changeNote template -->
        <xsl:with-param name="uri" select="$uri" tunnel="yes"/>
      </xsl:apply-templates>
    </rdf:Description>
  </xsl:template>

  <xsl:template match="UF">
    <skos:altLabel xml:lang="en">
      <xsl:value-of select="."/>
    </skos:altLabel>
  </xsl:template>

  <xsl:template match="BT | NT | RT">
    <xsl:variable name="node" select="key('termKey', .)"/>
    <xsl:sequence select="arm:broader-narrower($node, name(.))"/>
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
    <xsl:param as="xs:string" name="name"/>
    <xsl:variable name="uri"
      select="concat($base-uri, '/', concat(substring-before($node/SC, ' '), $node/TNR))"/>
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
