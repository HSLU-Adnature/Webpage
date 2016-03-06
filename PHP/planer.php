<?php

    $chosenId = $_GET['chosen'];
    if (!isset($chosenId)) {
        $chosenId = 1;
    }

    $xmlDoc = new DOMDocument();
    $xmlDoc->load("../xml/core.xml");

    $xmlEmpty = new DOMDocument();
    $xmlEmpty->load("../xml/core_empty.xml");

    $xpath = new DOMXPath($xmlDoc);
    $chosenEvent = $xpath->query("//event[id = $chosenId]");
    echo $chosenEvent->length;
    $xmlEmpty->appendChild($chosenEvent->item(0));

    $xslDoc = new DOMDocument();
    $xslDoc->load("../xml/event.xsl");

    $proc = new XSLTProcessor();
    $proc->importStylesheet($xslDoc);
    echo $proc->transformToXML($xmlEmpty);
?>