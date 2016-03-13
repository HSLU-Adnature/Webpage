<?php

function addEventToXmlDoc($chosenEvent, $xmlDoc){
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



$data = array();

$xmlDoc = simplexml_load_file("../xml/core.xml");
$xmlDoc->registerXPathNamespace("ad", 'http://www.adnature.ch/core');

$xmlEmpty = simplexml_load_file("../xml/core_empty.xml");
$xmlEmpty->registerXPathNamespace("ad", 'http://www.adnature.ch/core');



if (!isset($_COOKIE["planer"])) {
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



if (!empty($data)) {
    $adnature_events = $xmlEmpty->xpath("//ad:adnature_events")[0];
    foreach ($data as $value) {

        $chosenEvent = $xmlDoc->xpath("//ad:event[ad:id=$value]");

        if (!empty($chosenEvent)) {
            $adnature_events = addEventToXmlDoc($chosenEvent, $adnature_events);
        }
    }


    $xslDoc = new DOMDocument();
    $xslDoc->load("../xml/planer.xsl");

    $proc = new XSLTProcessor();
    $proc->importStylesheet($xslDoc);
    echo $proc->transformToXML($xmlEmpty);
}




