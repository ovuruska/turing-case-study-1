import 'package:flutter/material.dart';
import 'package:maps_places/components/map.dart';

import '../components/appbar_search.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

            // The search area here
            title: AppBarSearch()),
        body: GoogleMapView());
  }
}
