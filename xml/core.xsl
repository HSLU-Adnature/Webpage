<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="UTF-8"/>
                <title>Adnature</title>
                <link rel="stylesheet" href="../css/bootstrap-yeti.min.css"/>
            </head>
            <body>
                <div class="navbar navbar-default navbar-static-top">
                    <div class="container">
                        <a href="index.html"><img class="navbar-brand" src="../pics/logo.png"/></a>
                        <div id="navbar-main" class="navbar-collapse collapse">
                            <ul class="nav navbar-nav">
                                <li><a href="index.html">Events</a></li>
                                <li><a href="planer.html">Planer</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="container">
                    <div class="page-header">
                        <h1>Events</h1>
                    </div>
                </div>
                <div class="container">
                    <div class="row">
                        <xsl:apply-templates/>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="event">
        <div class="container">
            <div class="jumbotron">
                <div class="row">
                    <div class="col-md-6 col-xs-6 col-lg-6 col-sm-6">
                        <h2><xsl:value-of select="title"/></h2>
                        <p><xsl:value-of select="short_description"/></p>
                    </div>
                    <div class="col-md-6 col-xs-6 col-lg-6 col-sm-6">
                        <img class="img-rounded">
                            <xsl:attribute name="src">
                                <xsl:value-of select="picture"/>
                            </xsl:attribute>
                        </img>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>