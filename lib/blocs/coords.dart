import 'package:maps_places/common/bloc.dart';
import 'package:maps_places/repositories/google_maps.dart';

import '../models/place.dart';

class CoordsModel {
  double lat = 41.17213067781112;
  double lng = 29.008942097425457;
  double zoom = 11.0;

  setCoords(double lat, double lng,double zoom) {
    this.lat = lat;
    this.lng = lng;
    this.zoom = zoom;
    return this;
  }


}

class CoordsBloc extends Bloc<CoordsModel> {
  CoordsBloc() {
    subject.add(CoordsModel());
  }

  setCoords(double lat, double lng,double zoom) {
    subject.add(value.setCoords(lat, lng,zoom));
  }


}
final coordsBloc = CoordsBloc();