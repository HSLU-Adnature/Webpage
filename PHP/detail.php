<?php

ini_set('display_errors', 1);

$filename = '../xml/core.xml';
$xml_file = simplexml_load_file($filename);

$xml = new DOMDocument();
$xml = dom_import_simplexml($xml_file)->ownerDocument;

if ($xml->schemaValidate("../xml/core.xsd")) {

    $xml_file->registerXPathNamespace("ad", 'http://www.adnature.ch/core');

    if (isset($_GET["id"])) {
        $adnature_events = $xml_file->xpath("//ad:event[ad:id=" . htmlspecialchars($_GET["id"]) . "]");
    } else {
        $adnature_events = $xml_file->xpath("//ad:event");
    }

    $xsl = new DOMDocument;
    $xsl->load('../xml/event_detail.xsl');

    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl);

    echo $proc->transformToXML(dom_import_simplexml($adnature_events[0])->ownerDocument);

} else {
    echo "XML not valid!";
}
