<?php
ini_set('display_errors', 0);

$filename = '../xml/core.xml';

$xml = simplexml_load_file($filename);

$xml_file = new DOMDocument();
$xml_file = dom_import_simplexml($xml)->ownerDocument;

if (!($xml_file->schemaValidate("../xml/core.xsd"))) {
    echo "Fehler beim Einlesen der XML Datei. Kontaktieren Sie ihren Administrator.";
}

$xml->registerXPathNamespace("ad", 'http://www.adnature.ch/core');

$adnature_events = $xml->xpath("//ad:adnature_events")[0];
$id = (int)$xml->xpath("//ad:event[ad:id][last()]/ad:id/text()")[0];

$event = $adnature_events->addChild("event");
$event->addChild("id", $id + 1);
$event->addChild("title", htmlspecialchars($_POST["title"]));
$event->addChild("date", htmlspecialchars($_POST["date"]));
$event->addChild("start_time", htmlspecialchars($_POST["start_time"]).":00");
$event->addChild("end_time", htmlspecialchars($_POST["end_time"]).":00");
$event->addChild("address", htmlspecialchars($_POST["address"]));
$event->addChild("zip", htmlspecialchars($_POST["zip"]));
$event->addChild("city", htmlspecialchars($_POST["city"]));
$event->addChild("location", "location");
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

if (date("g", time()) < 10) {
    $event->addChild("timestamp", date("Y-m-d\T0g:i:s", time()));
} else {
    $event->addChild("timestamp", date("Y-m-d\Tg:i:s", time()));
}

$xml_file = new DOMDocument();
$xml_file = dom_import_simplexml($xml)->ownerDocument;

if ($xml_file->schemaValidate("../xml/core.xsd")) {
    $xml->saveXML($filename);

    header("Refresh:0; url=../php/index.php");
}else
{
    echo "Eingabefehler, Bitte Eingabe überprüfen und korrigieren.";
    echo "<br><button onclick=\"goBack()\">Go Back</button>";
    echo "  <script>
                function goBack() {
                window.history.back();
            }
            </script>";
    //header("Refresh:10; url=../html/newEntry.html");
}
