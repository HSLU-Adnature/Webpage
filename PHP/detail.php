<?php

ini_set('display_errors', 1);

$filename = '../xml/core.xml';
$xml_file = simplexml_load_file($filename);

$xml = new DOMDocument();
$xml = dom_import_simplexml($xml_file)->ownerDocument;

if ($xml->schemaValidate("../xml/core.xsd")) {

    $xml_file->registerXPathNamespace("ad", 'http://www.adnature.ch/core');

    if (isset($_POST["id"])) {
        $adnature_events = $xml->xpath("//ad:event[ad:id=" . $_POST["id"] . "]");
    } else {
        $adnature_events = $xml;
    }

    $xsl = new DOMDocument;
    $xsl->load('../xml/event_detail.xsl');

    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl);

    echo $proc->transformToXML($adnature_events);

} else {
    echo "XML not valid!";
}
