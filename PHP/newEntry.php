<?php

$xml = simplexml_load_file('../xml/core.xml');

$xml->registerXPathNamespace("ad", 'http://www.adnature.ch/core');

$adnature_events = $xml->xpath("//ad:adnature_events")[0];

$event = $adnature_events->addChild("event");
$event->addChild("title", $_POST["title"]);
$event->addChild("start_time", $_POST["start_time"]);
$event->addChild("end_time", $_POST["end_time"]);
$event->addChild("address", $_POST["address"]);
$event->addChild("zip", $_POST["zip"]);
$event->addChild("city", $_POST["city"]);
$event->addChild("location", $_POST["location"]);
$event->addChild("short_description", $_POST["short_description"]);
$event->addChild("description", $_POST["description"]);

$owner = $event->addChild("owner");
$owner->addChild("surname", $_POST["surname"]);
$owner->addChild("lastname", $_POST["lastname"]);
$owner->addChild("email", $_POST["email"]);
$owner->addChild("number", $_POST["number"]);

$event->addChild("homepage", $_POST["homepage"]);
$event->addChild("type", $_POST["type"]);
$event->addChild("picture", $_POST["picture"]);
$event->addChild("timestamp", time());

$xml->saveXML();


echo $adnature_events->asXML();