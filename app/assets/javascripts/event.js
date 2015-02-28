$(function(){
  console.log($(window).height());
  $("#map").closest('.col-md-9').css('padding-right', '0px')
  $("#map").height($(window).height() - 50);
  $("#sidebar").height($(window).height() - 50);
  $(window).resize(function(){
    $("#map").height($(window).height() - 50);
    $("#sidebar").height($(window).height() - 50);
  })
  $("nav").css('margin-bottom', '0px');
  var handler = Gmaps.build('Google');
  handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
    markers = handler.addMarkers([
      {
        "lat": 37.773306, 
        "lng": -122.429875,
        "infowindow": "hello!"
      }
    ]);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  });
});