<?php

    $xslDoc = new DOMDocument();
    $xslDoc->load("../xml/event.xsl");

    $xmlDoc = new DOMDocument();
    $xmlDoc->load("../xml/core.xml");

    $proc = new XSLTProcessor();
    $proc->importStylesheet($xslDoc);
    echo $proc->transformToXML($xmlDoc);

?>