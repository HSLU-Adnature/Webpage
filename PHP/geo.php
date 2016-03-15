<?php

function urlencodeEvent($event){
    $eventEnc = new stdClass();
    $eventEnc->address = urlencode($event->address);
    $eventEnc->zip = $event->zip;
    $eventEnc->city = urlencode($event->city);
    return $eventEnc;
}

function getGeoLocation($event){
    $eventUrl = urlencodeEvent($event);
    $data = file_get_contents
    ("https://maps.googleapis.com/maps/api/geocode/xml?address=$eventUrl->address+$eventUrl->zip+$eventUrl->city&key=AIzaSyCtxiB_gzEsuW95lH1xY5zo3Nre1XKhQUE");
    $googleXmlAnswer = simplexml_load_string($data);
    return $googleXmlAnswer->xpath("//geometry/location")[0];
}

if(!isset($_GET["events"])){
    echo "no events";
    exit();
}

$eventIds = explode(",", $_GET["events"]);

$xmlDoc = simplexml_load_file("../xml/core.xml");
$xmlDoc->registerXPathNamespace("ad", 'http://www.adnature.ch/core');

$xmlGeoMarks = new SimpleXMLElement("<marks></marks>");
foreach($eventIds as $id){
    $event = $xmlDoc->xpath("//ad:event[ad:id=$id]")[0];
    $eventLocation = getGeoLocation($event);
    $eventGeo = $xmlGeoMarks->addChild("event");
    $eventGeo->addChild("id", $id);
    $eventGeoLocation = $eventGeo->addChild("location");
    $eventGeoLocation->addChild("lat", $eventLocation->lat);
    $eventGeoLocation->addChild("lng", $eventLocation->lng);
    $eventGeo->addChild("title", $event->title);
}
header('Content-Type: application/xml');
echo $xmlGeoMarks->asXML();

