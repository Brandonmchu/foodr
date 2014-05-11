var geocoder;
var map;
function initialize() {
  geocoder = new google.maps.Geocoder();
  var lat = document.getElementById("init_lat").value;
  var lng = document.getElementById("init_lng").value;
  var latlng = new google.maps.LatLng(lat,lng);
  var mapOptions = {
    zoom: 12,
    center: latlng
  }
  map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
}

function codeAddress() {
  var address = document.getElementById("address").value;
  console.log(address)
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      $("#init_lat").val(results[0].geometry.location.k);
      $("#init_lng").val(results[0].geometry.location.A);
      $("#last_address").val(address)
      $("#yelp-form").submit();
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });
    } else {
      alert("Geocode was not successful for the following reason: " + status);
    }
  });
}

function localFilter(distance) {
  $('#yelp_results .yelp-row .yelp-row-dist').each(function(){
    if (distance*1000 < $(this).text()){
      $(this).parent().hide();
    }
    else {
      $(this).parent().show();
    }
  })

}

$( document ).ready(function() {
  
  $("#distance_slider").slider();
  $("#distance_slider").on('slide', function(slideEvt) {
    $("#ex6SliderVal").text(slideEvt.value);
    localFilter(slideEvt.value);
  });

  $("#yelp_results").tablesorter();
});
