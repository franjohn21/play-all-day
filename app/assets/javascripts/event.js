$(function(){
  var map, markerList = {}, infoList = {};
  $("#map").closest('.col-md-9').css('padding-right', '0px')
  $("#map").height($(window).height() - 50);
  $("#sidebar").height($(window).height() - 50);
  $(window).resize(function(){
    $("#map").height($(window).height() - 50);
    $("#sidebar").height($(window).height() - 50);
  })

  $(".event-node").mouseover(function(){
    var id = $(this).attr("id").match(/\d+/);
    infoList[id].open(map, markerList[id]);
    map.panTo(markerList[id].getPosition());
  });
  $(".event-node").mouseout(function(){
    var id = $(this).attr("id").match(/\d+/);
    infoList[id].close();
  })

  $('body').on('click', '.rsvp', rsvp)

  function initialize() {
    var mapOptions = {
      center: { lat: 37.352886, lng: -121.957388},
      zoom: 13
    };
    map = new google.maps.Map(document.getElementById('map'),
      mapOptions);

    var events = $.parseJSON($("#event_info").attr("data-events"));

    for(var i = 0; i < events.length; i++){
      addMarker(events[i]);
      addInfoWindow(events[i]);
    }
  }

  function addMarker(data){
    var evt = data.event;
    var marker_location = new google.maps.LatLng(evt.latitude,evt.longitude);

    var marker = new google.maps.Marker({
        position: marker_location,
        map: map,
        title: evt.location_name,
        animation: google.maps.Animation.DROP
    });
    markerList[evt.id] = marker;

    google.maps.event.addListener(markerList[evt.id], 'click', function(data){
      if(infoList[evt.id].getMap())
        infoList[evt.id].close();
      else
        infoList[evt.id].open(map, markerList[evt.id]);
    })


  }

  function addInfoWindow(data){
    var evt = data.event
    var content = [
      '<div class="info-window" id='+evt.id+ '>',
      "<a href='/events/" + evt.id + "'><h5>" + evt.title + "</h5></a>",
      '<p>' + evt.location_name + '</p>',
      '<p class="num-going"> <span class="num">' + data.num_going + '</span>/' + evt.num_people + ' going </p>',
      "<button class='btn btn-primary rsvp'> Say I'm going! </button>",
      '</div>'
    ].join('')

    infoList[evt.id] = new google.maps.InfoWindow({ content: content })

  }


  function rsvp(e){
    e.preventDefault();
    $.post('/rsvp', {event_id: $(this).closest('.info-window').attr('id')})
    $num = $(this).siblings('.num-going').find('.num');
    $secondnum = $("#event-" + $(this).closest('.info-window').attr('id')).find('.num_going')
    $secondnum.text(parseInt($num.text()) + 1);
    $num.text(parseInt($num.text()) + 1);
  }



  initialize();
});