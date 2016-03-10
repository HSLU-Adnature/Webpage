<?php
ini_set('display_errors', 1);
$xml = new DOMDocument();
$xml->load("../xml/core.xml");

if ($xml->schemaValidate("../xml/core.xsd")) {

    $xsl = new DOMDocument;
    $xsl->load('../xml/event.xsl');

    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl);

    echo $proc->transformToXML($xml);

} else {
    echo "XML not valid!";
}
