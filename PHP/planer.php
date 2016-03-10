<?php

$chosenId = $_GET['chosen'];
if (!isset($chosenId)) {
    $chosenId = 1;
}

$xmlDoc = simplexml_load_file("../xml/core.xml");
$xmlDoc->registerXPathNamespace("ad", 'http://www.adnature.ch/core');

$xmlEmpty = simplexml_load_file("../xml/core_empty.xml");
$xmlEmpty->registerXPathNamespace("ad", 'http://www.adnature.ch/core');

$chosenEvent = $xmlDoc->xpath("//ad:event[ad:id=$chosenId]");
$adnature_events = $xmlEmpty->xpath("//ad:adnature_events")[0];
$event = $adnature_events->addChild("event");
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


$xmlEmpty->saveXML("../xml/core_empty.xml");

$xslDoc = new DOMDocument();
$xslDoc->load("../xml/event.xsl");

$proc = new XSLTProcessor();
$proc->importStylesheet($xslDoc);
echo $proc->transformToXML($xmlEmpty);
