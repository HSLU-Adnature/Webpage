<?php

require_once 'fop_service_client.php';

$input_document = "../xml/core.xml";
$output_fo = "print.fo";

$xml = new DOMDocument();
$xml->load($input_document);

if ($xml->schemaValidate("../xml/core.xsd")) {

    $xsl = new DOMDocument;
    $xsl->load('../xml/print.xsl');

    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl);

    $proc->transformToDoc($xml)->save($output_fo);

    $serviceClient = new FOPServiceClient();
    $pdfFile = $serviceClient->processFile($output_fo);

    header("Refresh:0; url=" . $pdfFile);

} else {
    echo "XML not valid!";
}
