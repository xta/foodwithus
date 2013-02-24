$(document).ready(function() {

  $('p#login').click(function() {
    window.location.href = "/login";
  });

  $('a.explore_nearby').click(function() {
    var target_path = $(this).attr("href");
    navigator.geolocation.getCurrentPosition(function(position) {
      redirect_with_geo(position.coords.latitude, position.coords.longitude, target_path);
    });

    return false;
  });

  function redirect_with_geo(lat, lon, target){
    window.location.href = target + "?lat=" + lat + "&lon=" + lon;
  };

}); // end DOM ready