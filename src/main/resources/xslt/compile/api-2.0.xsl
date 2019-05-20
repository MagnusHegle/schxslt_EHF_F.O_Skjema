<xsl:transform version="2.0"
               xmlns="http://www.w3.org/1999/XSL/TransformAlias"
               xmlns:sch="http://purl.oclc.org/dsdl/schematron"
               xmlns:schxslt-api="https://doi.org/10.5281/zenodo.1495494#api"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
    <desc>
      <p>SchXslt Callback API Specification</p>
      <p>
        The parts of the validation stylesheet that create reporting output are created by calls to the named templates
        defined herein. You can override these templates to customize the output. The compiler expects the instructions
        of the validation stylesheet to live in the default namespace.
      </p>
    </desc>
  </doc>
  
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>Create part of the validation stylesheet that creates the report</p>
      <p>
        This template is called after the report has been gathered. The content of the report is available in the
        variable <i>schxslt:report</i>.
      </p>
    </desc>
    <param name="schema">Schematron schema</param>
    <param name="phase">Validation phase</param>
  </doc>
  <xsl:template name="schxslt-api:report">
    <xsl:param name="schema" as="element(sch:schema)" required="yes"/>
    <xsl:param name="phase" as="xs:string" required="yes"/>
  </xsl:template>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>Create part of the validation stylesheet that reports an active pattern</p>
    </desc>
    <param name="pattern">Schematron element of the active pattern</param>
  </doc>
  <xsl:template name="schxslt-api:active-pattern">
    <xsl:param name="pattern" as="element(sch:pattern)" required="yes"/>
  </xsl:template>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>Create part of the validation stylesheet that reports a fired rule</p>
    </desc>
    <param name="rule">Schematron element of the fired rule</param>
  </doc> 
  <xsl:template name="schxslt-api:fired-rule">
    <xsl:param name="rule" as="element(sch:rule)" required="yes"/>
  </xsl:template>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>Create part of the validation stylesheet that reports a failed assert</p>
    </desc>
    <param name="assert">Schematron element of the failed assert</param>
  </doc>
  <xsl:template name="schxslt-api:failed-assert">
    <xsl:param name="assert" as="element(sch:assert)" required="yes"/>
  </xsl:template>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>Create part of the validation stylesheet that reports a successful report</p>
    </desc>
    <param name="report">Schematron element of the successful report</param>
  </doc>
  <xsl:template name="schxslt-api:successful-report">
    <xsl:param name="report" as="element(sch:report)" required="yes"/>
  </xsl:template>

  <xsl:function name="schxslt-api:location" as="xs:string">
    <xsl:param name="node" as="node()"/>
    <xsl:variable name="segments" as="xs:string*">
      <xsl:for-each select="($node/ancestor-or-self::node())">
        <xsl:variable name="position">
          <xsl:number level="single"/>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test=". instance of element()">
            <xsl:value-of select="concat(name(.), '[', $position, ']')"/>
          </xsl:when>
          <xsl:when test=". instance of attribute()">
            <xsl:value-of select="concat('@', name(.))"/>
          </xsl:when>
          <xsl:when test=". instance of processing-instruction()">
            <xsl:value-of select="concat('processing-instruction(&quot;', name(.), '&quot;)[', $position, ']')"/>
          </xsl:when>
          <xsl:when test=". instance of comment()">
            <xsl:value-of select="concat('comment()[', $position, ']')"/>
          </xsl:when>
          <xsl:when test=". instance of text()">
            <xsl:value-of select="concat('text()[', $position, ']')"/>
          </xsl:when>
          <xsl:otherwise/>
        </xsl:choose>
      </xsl:for-each>
    </xsl:variable>

    <xsl:value-of select="concat('/', string-join($segments, '/'))"/>
  </xsl:function>

</xsl:transform>
