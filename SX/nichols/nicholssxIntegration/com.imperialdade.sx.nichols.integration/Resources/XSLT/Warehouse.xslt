<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

  <xsl:template match="/">
    <Warehouses>
      <xsl:for-each select="tokenize(Warehouse, '|')">
        <Warehouse>
          <xsl:value-of select="." />
        </Warehouse>
      </xsl:for-each>
    </Warehouses>
  </xsl:template>

</xsl:stylesheet>