$(document).ready(function() {

  $('a.explore_nearby').click(function() {
    navigator.geolocation.getCurrentPosition( ModifyAddNewLink );
    return false;
  });

  function ModifyAddNewLink( location ) {
    var latitude = location.coords.latitude;
    var longitude = location.coords.longitude;
    var addressValue = $('a.explore_nearby').attr("href");

    window.location.href = addressValue + "?lat=" + latitude + "&lon=" + longitude;
  };

}); // end DOM ready