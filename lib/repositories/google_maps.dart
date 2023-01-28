import 'dart:convert';
import 'dart:typed_data';

import 'package:maps_places/models/place.dart';
import 'package:http/http.dart' as http;
import 'package:maps_places/repositories/api_key.dart';

class GoogleMapsRepository {
  static final instance = GoogleMapsRepository._();

  GoogleMapsRepository._();

  Future<Uint8List> getPhoto(String photoReference,
      {int maxWidth = 64,int maxHeight=64}) async {
    Map<String, dynamic> queryParams = {
      "photo_reference": photoReference,
      "key": APIKeyRepository.instance.key,
      "maxHeight":maxHeight.toString(),
      "maxWidth":maxWidth.toString()
    };

    var url = Uri.https(
        'maps.googleapis.com','/maps/api/place/photo',queryParams);
    var response = await http.get(url);
    return response.bodyBytes;
  }

  Future<List<GoogleMapsPlace>?> nearbySearch(
      GoogleMapsLocation location, String keyword ,{double radius = 50000}) async {
    Map<String, dynamic> queryParams = {
      "location": location.toString(),
      "key": APIKeyRepository.instance.key,
      "keyword":keyword,
      "radius":"50000"
    };

    var uri = Uri.https("maps.googleapis.com",
        "/maps/api/place/nearbysearch/json", queryParams);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var respJson = await jsonDecode(response.body);
      return respJson["results"]
          .map<GoogleMapsPlace>((e) => GoogleMapsPlace.fromJson(e))
          .toList();
    }

    return null;
  }
}
