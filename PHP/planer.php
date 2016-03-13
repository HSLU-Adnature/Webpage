<?php

function arrayRecursiveDiff($aArray1, $aArray2) {
    $aReturn = array();

    foreach ($aArray1 as $mKey => $mValue) {
        if (array_key_exists($mKey, $aArray2)) {
            if (is_array($mValue)) {
                $aRecursiveDiff = arrayRecursiveDiff($mValue, $aArray2[$mKey]);
                if (count($aRecursiveDiff)) { $aReturn[$mKey] = $aRecursiveDiff; }
            } else {
                if ($mValue != $aArray2[$mKey]) {
                    $aReturn[$mKey] = $mValue;
                }
            }
        } else {
            $aReturn[$mKey] = $mValue;
        }
    }
    return $aReturn;
}

function addEventToXmlDoc($chosenEvent, $xmlDoc, $eventAttribute){
    $event = $xmlDoc->addChild("event");
    $event->addAttribute('type', $eventAttribute);
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

function eleminateTimeoverlap($possibleEvents, $chosenEvents) {
    $notPossibleEvents = array();
    foreach($possibleEvents as $possibleEvent){
        foreach($chosenEvents as $chosenEvent) {
            if(new DateTime($possibleEvent->start_time) < new DateTime($chosenEvent->end_time)
                || new DateTime($possibleEvent->end_time) < new DateTime($chosenEvent->start_time)) {
                array_push($notPossibleEvents, $possibleEvent);
            }
        }
    }
    return arrayRecursiveDiff($possibleEvents, $notPossibleEvents);
}

function urlencodeEvent($event){
    $eventEnc = new stdClass();
    $eventEnc->address = urlencode($event->address);
    $eventEnc->zip = $event->zip;
    $eventEnc->city = urlencode($event->city);
    return $eventEnc;
}


function getDistanceInKm($eventStart, $eventTarget){
    $eventStartUrl = urlencodeEvent($eventStart);
    $eventTargetUrl = urlencodeEvent($eventTarget);
    $data = file_get_contents
    ("https://maps.googleapis.com/maps/api/distancematrix/xml?origins=$eventStartUrl->address+$eventStartUrl->zip+$eventStartUrl->city&destinations=$eventTargetUrl->address+$eventTargetUrl->zip+$eventTargetUrl->city&key=AIzaSyCtxiB_gzEsuW95lH1xY5zo3Nre1XKhQUE");
    $googleXmlAnswer = simplexml_load_string($data);
    $xmlDuration = $googleXmlAnswer->xpath("//duration");
    return $xmlDuration[0]->value;
}

function calcNearest($possibleEvents, $chosenEvents) {
    $bestMatch = [
        "event" => null,
        "distance" => PHP_INT_MAX
    ];
    foreach ($chosenEvents as $chosenEvent) {
        foreach ($possibleEvents as $possibleEvent) {
            if(new DateTime($possibleEvent->start_time) < new DateTime($chosenEvent->end_time)){
                $distance = getDistanceInKm($possibleEvent, $chosenEvent);
                if($bestMatch["distance"] > $distance){
                    $bestMatch["distance"] = $distance;
                    $bestMatch["event"] = $possibleEvent;
                }
            }elseif(new DateTime($possibleEvent->start_time) > new DateTime($chosenEvent->end_time)){
                $distance = getDistanceInKm($chosenEvent, $possibleEvent);
                if($bestMatch["distance"] > $distance){
                    $bestMatch["distance"] = $distance;
                    $bestMatch["event"] = $possibleEvent;
                }
            }
        }
    }
    return $bestMatch["event"];
}

function calcMatch ($events, $chosenEvents, $thrownEvents){
    $possibleEvents = arrayRecursiveDiff($events, $chosenEvents);
    $possibleEvents = arrayRecursiveDiff($possibleEvents, $thrownEvents);
    $possibleEvents = eleminateTimeoverlap($possibleEvents, $chosenEvents);
    return calcNearest($possibleEvents, $chosenEvents);
}


$data = array();

$xmlDoc = simplexml_load_file("../xml/core.xml");
$xmlDoc->registerXPathNamespace("ad", 'http://www.adnature.ch/core');

$xmlEmpty = simplexml_load_file("../xml/core_empty.xml");
$xmlEmpty->registerXPathNamespace("ad", 'http://www.adnature.ch/core');



/*if (!isset($_COOKIE["planer"])) {
    setcookie("planer", serialize($data), time() + 3600);
} else {
    $data = unserialize($_COOKIE['planer']);
}


if (isset($_GET['chosen'])) {
    $data = unserialize($_COOKIE['planer']);
    $chosenID = $_GET['chosen'];
    if (!in_array($chosenID, $data)) {
        array_push($data, $_GET['chosen']);
        setcookie("planer", serialize($data), time() + 3600);
    }
}

if (isset($_GET['deleted'])) {
    $data = unserialize($_COOKIE['planer']);
    $deletedID = $_GET['deleted'];
    if (in_array($deletedID, $data)) {
        unset($data[array_search($deletedID, $data)]);
        setcookie("planer", serialize($data), time() + 3600);
    }
}
*/
$data[0] = $_GET['chosen'];
$events = $xmlDoc->xpath("//ad:event");
$chosenEvents = array();
$thrownEvents = array();
if (!empty($data)) {
    $adnature_events = $xmlEmpty->xpath("//ad:adnature_events")[0];
    foreach ($data as $value) {
        $chosenEvent = $xmlDoc->xpath("//ad:event[ad:id=$value]")[0];
        array_push($chosenEvents, $chosenEvent);
    }

    $match = calcMatch($events, $chosenEvents, $thrownEvents);

    $adnature_events = $xmlEmpty->xpath("//ad:adnature_events")[0];
    $adnature_events = addEventToXmlDoc($match, $adnature_events, "match");
    foreach ($chosenEvents as $chosenEvent) {
        $adnature_events = addEventToXmlDoc($chosenEvent, $adnature_events, "chosen");
    }

    $xslDoc = new DOMDocument();
    $xslDoc->load("../xml/planer.xsl");

    $proc = new XSLTProcessor();
    $proc->importStylesheet($xslDoc);
    echo $proc->transformToXML($adnature_events);
}




