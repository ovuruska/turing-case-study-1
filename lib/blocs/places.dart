import 'package:maps_places/common/bloc.dart';
import 'package:maps_places/models/place.dart';
import 'package:maps_places/repositories/google_maps.dart';

class PlacesModel {
  List<GoogleMapsPlace> places = [];

  setPlaces(List<GoogleMapsPlace> places) {
    this.places = places;
    return this;
  }

  clear(){
    this.places = [];
    return this;
  }
}

class PlacesBloc extends Bloc<PlacesModel> {
  PlacesBloc() {
    subject.add(PlacesModel());
  }

  void setPlaces(GoogleMapsLocation location, String keyword,{double radius = 50000 }) {
    GoogleMapsRepository.instance
        .nearbySearch(GoogleMapsLocation(location.lat, location.lng), keyword,radius: radius)
        .then((places) => subject.add(value.setPlaces(places!)));
  }

  clear(){
    subject.add(value.clear());
  }
}

final placesBloc = PlacesBloc();
