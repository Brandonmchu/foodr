  var geocoder;
  var map;
  function initialize() {
    geocoder = new google.maps.Geocoder();
    var lat = document.getElementById("init_lat").value;
    var lng = document.getElementById("init_lng").value;
    var latlng = new google.maps.LatLng(lat,lng);
    var mapOptions = {
      zoom: 8,
      center: latlng
    }
    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
  }

  function codeAddress() {
    var address = document.getElementById("address").value;
    geocoder.geocode( { 'address': address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        // $("#latitude").val(results[0].geometry.location.k);
        // $("#longitude").val(results[0].geometry.location.A);
        // $("#yelp-form").submit();
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