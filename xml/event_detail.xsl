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
                    <div class="row">
                        <xsl:apply-templates></xsl:apply-templates>
                    </div>
                </div>
                <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCtxiB_gzEsuW95lH1xY5zo3Nre1XKhQUE">
                    &#160;</script>
                <script src="../JS/planer.js">&#160;</script>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="ad:event">
        <div class="container">
            <div class="page-header border-header">
                <div class="row"></div>
                <h1 style="float:left">
                    <xsl:value-of select="ad:title"/>
                </h1>
                <a class="btn detail">
                    <xsl:attribute name="href">planer.php?chosen=<xsl:value-of select="ad:id"/>
                    </xsl:attribute>
                    Plan it!
                </a>
                <div id="mapInfos" style="visibility: hidden">
                    <xsl:value-of select="ad:id"/>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="jumbotron">
                <div class="row">
                    <div class="col-md-6 col-xs-6 col-lg-6 col-sm-6">
                        <style>
                            div.left_column {
                            float:left;
                            width:10em;
                            }

                            div.right_column {
                            margin-left:10em;
                            }
                        </style>
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h2 class="panel-title"><xsl:apply-templates select="ad:date"/></h2>
                            </div>
                        </div>
                        <div>
                            <div class="left_column">Start:</div>
                            <div class="right_column">
                                <xsl:apply-templates select="ad:start_time"/>
                            </div>
                        </div>
                        <div>
                            <div class="left_column">Ende:</div>
                            <div class="right_column">
                                <xsl:apply-templates select="ad:end_time"/>
                                <div/>
                            </div>
                        </div>
                        <br/>
                        <div>
                            <div class="left_column">Homepage:</div>
                            <div class="right_column">
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="ad:homepage"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="ad:homepage"/>
                                </a>
                            </div>
                        </div>
                        <br/>
                        <div>
                            <xsl:value-of select="ad:description"/>
                        </div>
                        <br/>
                        <br/>
                    </div>
                    <div class="col-md-6 col-xs-6 col-lg-6 col-sm-6">
                        <img class="img-rounded" style="max-width: 500px">
                            <xsl:attribute name="src">
                                <xsl:value-of select="ad:picture"/>
                            </xsl:attribute>
                        </img>
                    </div>
                </div>
                <br/>
                <xsl:apply-templates select="ad:owner">
                    <xsl:sort select="ad:firstname"/>
                </xsl:apply-templates>
                <div id="map" class="container" style="height: 500px"/>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="ad:owner">
        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">Veranstalter</h3>
            </div>
            <div class="panel-body">
                <div>
                    <xsl:value-of select="ad:firstname"/>&#160;<xsl:value-of select="ad:surname"/>
                </div>
                <div>
                    <a>
                        <xsl:attribute name="href">
                            mailto:<xsl:value-of select="ad:email"/>
                        </xsl:attribute>
                        <xsl:value-of select="ad:email"/>
                    </a>
                </div>
                <div>
                    <xsl:value-of select="ad:number"/>
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