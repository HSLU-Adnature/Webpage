<?php

$filename = '../xml/core.xml';

$xml = simplexml_load_file($filename);

$xml->registerXPathNamespace("ad", 'http://www.adnature.ch/core');

$adnature_events = $xml->xpath("//ad:adnature_events")[0];
$id = (int)$xml->xpath("//ad:event[ad:id][last()]/ad:id/text()")[0];

$event = $adnature_events->addChild("event");
$event->addChild("id", $id+1);
$event->addChild("title", htmlspecialchars($_POST["title"]));
$event->addChild("date", htmlspecialchars($_POST["date"]));
$event->addChild("start_time", htmlspecialchars($_POST["start_time"]));
$event->addChild("end_time", htmlspecialchars($_POST["end_time"]));
$event->addChild("address", htmlspecialchars($_POST["address"]));
$event->addChild("zip", htmlspecialchars($_POST["zip"]));
$event->addChild("city", htmlspecialchars($_POST["city"]));
$event->addChild("location", htmlspecialchars($_POST["location"]));
$event->addChild("short_description", htmlspecialchars($_POST["short_description"]));
$event->addChild("description", htmlspecialchars($_POST["description"]));

$owner = $event->addChild("owner");
$owner->addChild("firstname", htmlspecialchars($_POST["firstname"]));
$owner->addChild("surname", htmlspecialchars($_POST["surname"]));
$owner->addChild("email", htmlspecialchars($_POST["email"]));
$owner->addChild("number", htmlspecialchars($_POST["number"]));

$event->addChild("homepage", htmlspecialchars($_POST["homepage"]));
$event->addChild("type", htmlspecialchars($_POST["type"]));
$event->addChild("picture", htmlspecialchars($_POST["picture"]));
$event->addChild("timestamp", date("Y-m-d\TG:i:s",time()));

$xml->saveXML($filename);

header("Refresh:0; url=../php/index.php");
