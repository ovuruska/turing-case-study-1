import 'dart:convert';

import 'package:maps_places/models/place.dart';
import 'package:http/http.dart' as http;
import 'package:maps_places/repositories/api_key.dart';

class GoogleMapsRepository {
  static final instance = GoogleMapsRepository._();

  GoogleMapsRepository._();

  Future<List<GoogleMapsPlace>?> nearbySearch(
      GoogleMapsLocation location, String keyword ,{double radius = 50000}) async {
    Map<String, dynamic> queryParams = {
      "location": location.toString(),
      "key": APIKeyRepository.instance.key,
      "keyword":keyword,
      "radius":radius.toString()
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
