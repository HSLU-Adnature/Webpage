/**
 * Created by dario on 12.03.16.
 */


function drawMap(xmlEvents){
    var switzerland = {lat : 46.818188, lng : 8.227511999999999};

    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 8,
        center: switzerland
    });

    var events = xmlEvents.getElementsByTagName("event");

    for (var i = 0; i < events.length; i++) {
        var position = {
            lat: parseFloat(events[i].childNodes[1].childNodes[0].textContent),
            lng: parseFloat(events[i].childNodes[1].childNodes[1].textContent)
        };
        var marker = new google.maps.Marker({
            position: position,
            map: map
        });
    }

}

function getMapInfos() {
    var infoDiv = document.getElementById("mapInfos");
    console.log(infoDiv.innerHTML.trim());
    return infoDiv.innerHTML.trim();
}

function initMap() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (xhttp.readyState == 4 && xhttp.status == 200) {
            drawMap(xhttp.responseXML);
        }
    };
    xhttp.open("GET", "../PHP/geo.php?events=" + getMapInfos(), true);
    xhttp.send();
}

initMap();