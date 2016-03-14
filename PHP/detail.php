<?php

function addEventToXmlDoc($chosenEvent, $xmlDoc)
{
    $event = $xmlDoc->addChild("event");
    $event->addChild("id", $chosenEvent[0]->id);
    $event->addChild("title", $chosenEvent[0]->title);
    $event->addChild("date", $chosenEvent[0]->date);
    $event->addChild("start_time", $chosenEvent[0]->start_time);
    $event->addChild("end_time", $chosenEvent[0]->end_time);
    $event->addChild("address", $chosenEvent[0]->address);
    $event->addChild("zip", $chosenEvent[0]->zip);
    $event->addChild("city", $chosenEvent[0]->city);
    $event->addChild("location", $chosenEvent[0]->location);
    $event->addChild("short_description", $chosenEvent[0]->short_description);
    $event->addChild("description", $chosenEvent[0]->description);
    $owner = $event->addChild("owner");
    $owner->addChild("firstname", $chosenEvent[0]->owner->firstname);
    $owner->addChild("surname", $chosenEvent[0]->owner->surname);
    $owner->addChild("email", $chosenEvent[0]->owner->email);
    $owner->addChild("number", $chosenEvent[0]->owner->number);
    $event->addChild("homepage", $chosenEvent[0]->homepage);
    $event->addChild("type", $chosenEvent[0]->type);
    $event->addChild("picture", $chosenEvent[0]->picture);
    $event->addChild("timestamp", $chosenEvent[0]->timestamp);
    return $xmlDoc;
}

$filename = '../xml/core.xml';

$xml_file = simplexml_load_file($filename);
$xml_file->registerXPathNamespace("ad", 'http://www.adnature.ch/core');

$xml = new DOMDocument();
$xml->load($filename);

$xmlEmpty = simplexml_load_file("../xml/core_empty.xml");

if ($xml->schemaValidate("../xml/core.xsd")) {

    if (isset($_GET["id"])) {
        $adnature_events = $xml_file->xpath("//ad:event[ad:id=" . $_GET["id"] . "]")[0];
        $adnature_events = addEventToXmlDoc($adnature_events, $xmlEmpty);
    } else {
        $adnature_events = $xml_file->xpath("//ad:event")[0];
        $adnature_events = addEventToXmlDoc($adnature_events, $xmlEmpty);

    }

    $result = $xpath->query($query, $xml);

    $xsl = new DOMDocument;
    $xsl->load('../xml/event_detail.xsl');

    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl);

    echo $proc->transformToXml($adnature_events);

} else {
    echo "XML not valid!";
}
