import 'package:flutter/material.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:maps_places/pages/main.dart';

import 'package:maps_places/repositories/api_key.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// MapsDemo is the Main Application.

void main() async {
  await dotenv.load(fileName: "assets/.env");
  APIKeyRepository.instance.setKey(dotenv.env['MAPS_API_KEY']!);
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }
  runApp(
      const MaterialApp(debugShowCheckedModeBanner: false, home: MainView()));
}
