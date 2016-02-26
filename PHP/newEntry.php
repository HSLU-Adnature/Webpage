<?php

$xml = simplexml_load_file("../core.xml");

echo $xml->asXML();

foreach ($xml->xpath('//title/text()') as $character) {
    echo $character;
}