<?php

ini_set('display_errors', 1);

$filename = '../xml/core.xml';

$xml = new DOMDocument();
$xml->load($filename);

if ($xml->schemaValidate("../xml/core.xsd")) {

    $xpath = new DOMXPath($xml);
    $xpath->registerNamespace("ad", 'http://www.adnature.ch/core');

    if (isset($_GET["id"])) {
        $query = "//ad:event[ad:id=" . htmlspecialchars($_GET["id"]) . "]";
    } else {
        $query = "//ad:event";
    }

    $result = $xpath->query($query, $xml);

    $xsl = new DOMDocument;
    $xsl->load('../xml/event_detail.xsl');

    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl);

    echo $proc->transformToXML($result[0]);

} else {
    echo "XML not valid!";
}
