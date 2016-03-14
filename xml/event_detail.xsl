<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ad="http://www.adnature.ch/core">
    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="UTF-8"/>
                <title>Little Adnature</title>
                <link rel="stylesheet" href="../css/bootstrap-yeti.min.css"/>
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
                                    <a href="../html/planer.html">Planer</a>
                                </li>
                            </ul>
                        </div>
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
            <div class="page-header">
                <h1>
                    <xsl:value-of select="ad:title"/>
                </h1>
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
                        <div>
                            <div class="left_column">Wann:</div>
                            <div class="right_column">
                                <xsl:value-of select="ad:date"/>
                            </div>
                        </div>
                        <div>
                            <div class="left_column">Start:</div>
                            <div class="right_column">
                                <xsl:value-of select="ad:start_time"/>
                            </div>
                        </div>
                        <div>
                            <div class="left_column">Ende:</div>
                            <div class="right_column">
                                <xsl:value-of select="ad:end_time"/>
                                <div/>
                            </div>
                        </div>
                        <br/>
                        <div>
                            <div class="left_column">Location:</div>
                            <div class="right_column">
                                <xsl:value-of select="ad:location"/>
                            </div>
                        </div>
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
                </div><br/>
                <xsl:apply-templates select="ad:owner">
                <xsl:sort select="ad:firstname"/>
            </xsl:apply-templates>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="ad:owner">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">Veranstalter</h3>
            </div>
            <div class="panel-body">
                <div>
                    <xsl:value-of select="ad:firstname"/>
                </div>
                <div>
                    <xsl:value-of select="ad:surname"/>
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
</xsl:stylesheet>