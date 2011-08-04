$(function() {
    var myLatlng = new google.maps.LatLng(-21.761525, -41.336829);
    var myOptions = {
            zoom: 14,
            center: myLatlng,
            mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("map_div"), myOptions);
    var marker = new google.maps.Marker({
        position: myLatlng,
        map: map,
        title: "IF Fluminense"
    });
    var infoWindow = new google.maps.InfoWindow({
        content: "Instituto Federal de Educação, Ciência e Tecnologia Fluminense - Campus Campos-Centro",
        maxWidth: 400
    });
    infoWindow.open(map, marker);
});

