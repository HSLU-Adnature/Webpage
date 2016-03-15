<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:ad="http://www.adnature.ch/core">

    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="event_print" page-height="29.7cm" page-width="21cm" margin-top="1cm"
                                       margin-bottom="2cm" margin-left="2.5cm" margin-right="2.5cm">
                    <fo:region-body margin-top="1cm"/>
                    <fo:region-before extent="2cm"/>
                    <fo:region-after extent="3cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="event_print">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block text-align="right">
                        <fo:external-graphic src="http://taxml.enterpriselab.ch/team04/pics/logo.png" border-width="0cm" content-height="scale-to-fit" content-width="3cm"  scaling="uniform"/>
                    </fo:block>
                    <fo:block font-size="19pt" font-family="sans-serif" line-height="24pt" space-after.optimum="20pt"
                              background-color="green" color="white" text-align="center" padding-top="5pt"
                              padding-bottom="5pt">
                        Adnature Events
                    </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block text-align="center" font-size="8pt">
                        -
                        <fo:page-number/>
                        -
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block margin-top="60pt">
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="ad:adnature_events/ad:event">
        <fo:block text-align="left" font-size="8pt" margin-top="20pt">
            <fo:block font-size="16pt">
                <xsl:value-of select="ad:title"/>
            </fo:block>

            <fo:block>
                <fo:table space-after.optimum="5pt" width="5cm" font-size="11pt">
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>
                                    Datum:
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="ad:date"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>
                                    Start:
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="ad:start_time"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>
                                    Ende:
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="ad:end_time"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
                <fo:block>
                    <xsl:value-of select="ad:description"/>
                </fo:block>
                <fo:block margin-top="7pt">
                    <xsl:value-of select="ad:homepage"/>
                </fo:block>
            </fo:block>
            <xsl:apply-templates select="ad:owner"/>
        </fo:block>
    </xsl:template>
    <xsl:template match="ad:owner">
        <fo:block margin-top="10pt">
            <fo:block>
                <fo:table width="3cm">
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="ad:firstname"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="ad:surname"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </fo:block>
            <fo:block>
                <xsl:value-of select="ad:email"/>
            </fo:block>
            <fo:block>
                <xsl:value-of select="ad:number"/>
            </fo:block>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>