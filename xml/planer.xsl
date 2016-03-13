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
                    <div class="page-header">
                        <h1>Planer</h1>
                    </div>
                </div>
                <div class="container">
                    <div class="page-header">
                        <h1>Match</h1>
                    </div>
                </div>
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h3 class="panel-title">Possible</h3>
                    </div>
                    <div class="panel-body jumbotron">
                        <div class="row">
                            <xsl:apply-templates select="ad:adnature_events/ad:event[@ad:type='match']">
                                <xsl:sort select="ad:date"/>
                            </xsl:apply-templates>
                        </div>
                    </div>
                </div>
                <div class="container">
                    <div class="page-header">
                        <h1>Timeline</h1>
                    </div>
                </div>
                <div class="container">

                </div>
                <div class="container">
                    <div class="page-header">
                        <h1>Map</h1>
                    </div>
                </div>
                <div id="mapInfos" style="visibility: hidden">
                    1,2,3
                </div>
                <div id="map" class="container" style="height: 500px"/>
                <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCtxiB_gzEsuW95lH1xY5zo3Nre1XKhQUE">
                    &#160;</script>
                <script src="../JS/planer.js">&#160;</script>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="ad:event[@ad:type='match']">
        <div class="panel-body jumbotron">
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
        </div>
    </xsl:template>
</xsl:stylesheet>