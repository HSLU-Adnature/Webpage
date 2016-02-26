<?php

if (file_exists('../xml/core.xml')) {
    $xml = simplexml_load_file('../xml/core.xml');
    foreach ($xml->event as $event) {
        echo($event->title);
    }
} else {
    exit('Konnte core.xml nicht öffnen.');
}