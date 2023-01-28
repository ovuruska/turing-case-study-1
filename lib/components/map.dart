import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_places/blocs/coords.dart';
import 'package:maps_places/blocs/places.dart';
import 'package:maps_places/common/stream_listenable_builder.dart';

import 'marker_dialog.dart';


class GoogleMapView extends StatelessWidget {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) => StreamListenableBuilder(
    stream:placesBloc.stream,
    listener: (value) async {

    },
    builder: (context, snapshot) {
      return _build(context);
    },
  );
  Widget _build(BuildContext context) {

    Set<Marker> _markers = {};
    placesBloc.value.places.forEach((place) {
      _markers.add(Marker(
        onTap: (){
          print("asdfasd");
          showDialog(context: context, builder: (context){
            return MarkerDialog(place: place);
          });
        },
          markerId: MarkerId(place.placeId),
          position: LatLng(place.location.lat, place.location.lng),
          infoWindow: InfoWindow(
            title: place.name,
            snippet: place.vicinity,
          )));
    });


    return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(coordsBloc.value.lat, coordsBloc.value.lng),
          zoom: coordsBloc.value.zoom,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onCameraMove: (CameraPosition position) {
         coordsBloc.setCoords(position.target.latitude, position.target.longitude,position.zoom);
        },
        markers: _markers,
        gestureRecognizers: //
            <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        });
  }
}
