import 'package:flutter/material.dart';
import 'package:maps_places/blocs/coords.dart';
import 'package:maps_places/blocs/places.dart';
import 'package:maps_places/models/place.dart';

class AppBarSearch extends StatefulWidget {

  @override
  _AppBarSearchState createState() => _AppBarSearchState();
}


class _AppBarSearchState extends State<AppBarSearch> {

  var controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      fetchResults();
    });
  }

  fetchResults(){
    var location = GoogleMapsLocation(coordsBloc.value.lat, coordsBloc.value.lng);
    placesBloc.setPlaces(location, controller.text,radius: coordsBloc.value.zoom * 1000);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: TextField(
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
              prefixIcon: IconButton(icon:const Icon(Icons.search),onPressed: fetchResults,),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                  placesBloc.clear();
                },
              ),
              hintText: 'Search...',
              border: InputBorder.none),
        ),
      ),
    );
  }


}
