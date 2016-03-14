<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ad="http://www.adnature.ch/core">
    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="UTF-8"/>
                <title>Little Adnature</title>
                <link rel="stylesheet" href="../css/bootstrap-yeti.min.css"/>
                <link rel="stylesheet" href="../css/planer.css"/>
                <link rel="shortcut icon" href="../pics/favicon.ico" type="image/x-icon"/>
                <link rel="icon" href="../pics/favicon.ico" type="image/x-icon"/>
            </head>
            <body>
                <div class="navbar navbar-default navbar-static-top">
                    <div class="container">
                        <a href="../php/index.php">
                            <img class="navbar-brand" src="../pics/logo.png"/>
                        </a>
                        <div id="navbar-main" class="navbar-collapse collapse">
                            <ul class="nav navbar-nav">
                                <li>
                                    <a href="../php/index.php">Events</a>
                                </li>
                                <li>
                                    <a href="../php/planer.php">Planer</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="container">
                    <div class="page-header">
                        <h1 style="float:left">Events</h1>
                        <a href="../html/newEntry.html">
                            <img style="width:50px; padding-top:20px" src="../pics/new.png"/>
                        </a>
                    </div>
                </div>
                <div class="container">
                    <div class="row">
                        <xsl:apply-templates select="ad:adnature_events/ad:event">
                            <xsl:sort select="ad:date"/>
                        </xsl:apply-templates>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="ad:event">
        <div class="container">
            <xsl:attribute name="onclick">location.href='detail.php?id=<xsl:value-of select="ad:id"/>'
            </xsl:attribute>
            <div class="jumbotron clickable">
                <div class="row">
                    <div class="col-md-6 col-xs-6 col-lg-6 col-sm-6">
                        <h2>
                            <xsl:value-of select="ad:title"/>
                        </h2>
                        <p class="page-header">
                            <xsl:value-of select="ad:short_description"/>
                        </p>
                        <h4><xsl:apply-templates select="ad:date"/></h4>
                        <h5 class="italic"><xsl:apply-templates select="ad:start_time"/> - <xsl:apply-templates select="ad:end_time"/></h5>
                    </div>
                    <div class="col-md-6 col-xs-6 col-lg-6 col-sm-6">
                        <img class="img-rounded" style="max-width: 500px">
                            <xsl:attribute name="src">
                                <xsl:value-of select="ad:picture"/>
                            </xsl:attribute>
                        </img>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="ad:date">
        <xsl:copy>
            <xsl:call-template name="formatdate">
                <xsl:with-param name="DateTimeStr" select="."/>
            </xsl:call-template>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="ad:start_time">
        <xsl:copy>
            <xsl:call-template name="formattime">
                <xsl:with-param name="TimeStr" select="."/>
            </xsl:call-template>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="ad:end_time">
        <xsl:copy>
            <xsl:call-template name="formattime">
                <xsl:with-param name="TimeStr" select="."/>
            </xsl:call-template>
        </xsl:copy>
    </xsl:template>
    <xsl:template name="formatdate">
        <xsl:param name="DateTimeStr"/>
        <xsl:variable name="mm">
            <xsl:value-of select="substring($DateTimeStr,6,2)"/>
        </xsl:variable>
        <xsl:variable name="dd">
            <xsl:value-of select="substring($DateTimeStr,9,2)"/>
        </xsl:variable>
        <xsl:variable name="yyyy">
            <xsl:value-of select="substring($DateTimeStr,1,4)"/>
        </xsl:variable>
        <xsl:value-of select="concat($dd,'.', $mm, '.', $yyyy)"/>
    </xsl:template>
    <xsl:template name="formattime">
        <xsl:param name="TimeStr"/>
        <xsl:variable name="hh">
            <xsl:value-of select="substring($TimeStr,1,2)"/>
        </xsl:variable>
        <xsl:variable name="mm">
            <xsl:value-of select="substring($TimeStr,4,2)"/>
        </xsl:variable>
        <xsl:value-of select="concat($hh,':', $mm, ' Uhr')"/>
    </xsl:template>
</xsl:stylesheet>