<?php
$xml = new DOMDocument();
$xml->load("../xml/core.xml");

if (!isset($_COOKIE["planer"])) {
    $data = array();
    setcookie("planer", serialize($data), time() + 3600);
}

if ($xml->schemaValidate("../xml/core.xsd")) {

    $xsl = new DOMDocument;
    $xsl->load('../xml/event.xsl');

    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl);

    echo $proc->transformToXML($xml);

} else {
    echo "XML not valid!";
}
