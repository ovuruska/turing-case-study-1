import 'package:maps_places/common/bloc.dart';
import 'package:maps_places/models/place.dart';

class DetailsBloc extends Bloc<GoogleMapsPlace> {
  setPlace(GoogleMapsPlace place) {
    subject.sink.add(place);
  }
}

final detailsBloc = DetailsBloc();
