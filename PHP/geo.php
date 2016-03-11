<?php
if(!isset($_GET["events"])){
    echo "no events";
    exit();
}

$eventIds = explode(",", $_GET["events"]);

$xmlDoc = simplexml_load_file("../xml/maps.xml");

$xmlGeoMarks = new SimpleXMLElement("<marks></marks>");
foreach($eventIds as $id){
    $eventLocation = $xmlDoc->xpath("//event[id=$id]/GeocodeResponse/result/geometry/location")[0];
    $eventGeo = $xmlGeoMarks->addChild("event");
    $eventGeo->addChild("id", $id);
    $eventGeoLocation = $eventGeo->addChild("location");
    $eventGeoLocation->addChild("lat", (string) $eventLocation->lat);
    $eventGeoLocation->addChild("lng", (string) $eventLocation->lng);
}
header('Content-Type: application/xml');
echo $xmlGeoMarks->asXML();

