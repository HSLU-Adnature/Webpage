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
                <xsl:apply-templates select="ad:adnature_events/ad:event[@type='match']"/>
                <div class="container">
                    <div class="page-header">
                        <h1>Timeline</h1>
                    </div>
                </div>
                <div class="container">
                    <xsl:apply-templates select="ad:adnature_events/ad:event[@type='chosen']">
                        <xsl:sort select="ad:start_time"/>
                    </xsl:apply-templates>
                </div>
                <div class="container">
                    <div class="page-header">
                        <h1>Map</h1>
                    </div>
                </div>
                <div id="mapInfos" style="visibility: hidden">
                    <xsl:apply-templates select="ad:adnature_events/ad:idList"/>
                </div>
                <div id="map" class="container" style="height: 500px"/>
                <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCtxiB_gzEsuW95lH1xY5zo3Nre1XKhQUE">
                    &#160;</script>
                <script src="../JS/planer.js">&#160;</script>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="ad:event[@type='match']">
        <div class="container">
            <div class="page-header">
                <h1>Vorschlag</h1>
            </div>
        </div>
        <div class="container">
            <div class="panel panel-success">
                <div class="panel-heading">
                    <h3 class="panel-title"><xsl:value-of select="ad:date"/></h3>
                </div>
                <div class="panel-body background-color">
                    <div class="row">
                        <div class="col-md-6 col-xs-6 col-lg-6 col-sm-6">
                            <h2>
                                <xsl:value-of select="ad:title"/>
                            </h2>
                            <p>
                                <xsl:value-of select="ad:short_description"/>
                            </p>
                        </div>
                        <div class="col-md-6 col-xs-6 col-lg-6 col-sm-6">
                            <img class="img-rounded" style="max-width: 500px">
                                <xsl:attribute name="src">
                                    <xsl:value-of select="ad:picture"/>
                                </xsl:attribute>
                            </img>
                        </div>
                    </div>
                    <div class="row planerRow">
                        <a class="col-lg-6 col-md-6 col-xs-6 col-sm-6 btn btn-success">
                            <xsl:attribute name="href">planer.php?chosen=<xsl:value-of select="ad:id"/>
                            </xsl:attribute>
                            Planen
                        </a>
                        <a class="col-lg-6 col-md-6 col-xs-6 col-sm-6 btn btn-danger">
                            <xsl:attribute name="href">planer.php?thrown=<xsl:value-of select="ad:id"/>
                            </xsl:attribute>
                            Ablehnen
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="ad:adnature_events/ad:event[@type='chosen']">
        <div class="row">
            <div class="col-lg-3, col-md-3, col-xs-3, col-sm-3 border-right">&#160;</div>
        </div>
        <div class="row">
            <div class="col-lg-3, col-md-3, col-xs-3, col-sm-3 border-right">&#160;</div>
            <div class="col-lg-3, col-md-3, col-xs-3, col-sm-3 col-lg-offset-1 col-md-offset-1 col-xs-offset-1 col-lg-offset-1">
                <xsl:value-of select="ad:title"/>
            </div>
            <div class="col-lg-1 col-md-1 col-xs-1 col-sm-1">
                <xsl:copy>
                    <xsl:call-template name="formatstart">
                    </xsl:call-template>
                </xsl:copy>
            </div>
            <div class="col-lg-1 col-md-1 col-xs-1 col-sm-1">
                <xsl:copy>
                    <xsl:call-template name="formatend">
                    </xsl:call-template>
                </xsl:copy>
            </div>
            <a class="col-lg-1 col-md-1 col-xs-1 col-sm-1 btn-danger">
                <xsl:attribute name="href">planer.php?deleted=<xsl:value-of select="ad:id"/>
                </xsl:attribute>
                Entfernen
            </a>
        </div>
        <div class="row">
            <div class="col-lg-3, col-md-3, col-xs-3, col-sm-3 border-right">&#160;</div>
        </div>
    </xsl:template>
    <xsl:template match="ad:idList">
        <xsl:value-of select="ad:list"/>
    </xsl:template>
    <xsl:template name="formatstart">
        <xsl:variable name="hh">
            <xsl:value-of select="substring(ad:start_time,1,2)"/>
        </xsl:variable>
        <xsl:variable name="mm">
            <xsl:value-of select="substring(ad:start_time,4,2)"/>
        </xsl:variable>
        <xsl:value-of select="concat($hh,':', $mm)"/>
    </xsl:template>
    <xsl:template name="formatend">
        <xsl:variable name="hh">
            <xsl:value-of select="substring(ad:end_time,1,2)"/>
        </xsl:variable>
        <xsl:variable name="mm">
            <xsl:value-of select="substring(ad:end_time,4,2)"/>
        </xsl:variable>
        <xsl:value-of select="concat($hh,':', $mm)"/>
    </xsl:template>
</xsl:stylesheet>