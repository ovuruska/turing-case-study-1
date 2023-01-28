
/*
"business_status": "OPERATIONAL",
            "geometry": {
                "location": {
                    "lat": -33.866489,
                    "lng": 151.1958561
                },
                "viewport": {
                    "northeast": {
                        "lat": -33.86551042010727,
                        "lng": 151.1971164798927
                    },
                    "southwest": {
                        "lat": -33.86821007989272,
                        "lng": 151.1944168201073
                    }
                }
            },
            "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/generic_business-71.png",
            "icon_background_color": "#7B9EB0",
            "icon_mask_base_uri": "https://maps.gstatic.com/mapfiles/place_api/icons/v2/generic_pinlet",
            "name": "Google Workplace 6",
            "opening_hours": {
                "open_now": false
            },
            "photos": [
                {
                    "height": 2268,
                    "html_attributions": [
                        "<a href=\"https://maps.google.com/maps/contrib/115735146488851991578\">Helen Marquis</a>"
                    ],
                    "photo_reference": "AfLeUgOX1UJwHfQ-FvQZgEapb1RMQd79g7Cn9dK1HeV5oBntbIA7BB0-z6mfL85t89I1b821ryxULykAvQxWNqqG_7Gr5KtmdxWTZfjhNugIYMdgoOkdKeLxTRODduAExOVnYKMdXCEyPjO21qjPocWPKPf7cMg7IEcixKMksk6G5nwAx9z6",
                    "width": 4032
                }
            ],
            "place_id": "ChIJN1t_tDeuEmsRUsoyG83frY4",
            "plus_code": {
                "compound_code": "45MW+C8 Pyrmont, New South Wales, Australia",
                "global_code": "4RRH45MW+C8"
            },
            "rating": 4,
            "reference": "ChIJN1t_tDeuEmsRUsoyG83frY4",
            "scope": "GOOGLE",
            "types": [
                "point_of_interest",
                "establishment"
            ],
            "user_ratings_total": 965,
            "vicinity": "48 Pirrama Rd, Pyrmont"
 */
class GoogleMapsLocation {
  final double lat;
  final double lng;

  GoogleMapsLocation(this.lat, this.lng);
  @override
  String toString() {
    return "$lat,$lng";
  }


}

class GoogleMapsPlace {
  final GoogleMapsLocation location;
  final String name;
  final String vicinity;
  final String placeId;

  GoogleMapsPlace({required this.location,required this.name,required this.vicinity,required this.placeId});

  factory GoogleMapsPlace.fromJson(Map<String, dynamic> json) {
    return GoogleMapsPlace(
        location:GoogleMapsLocation(json["geometry"]["location"]["lat"],
            json["geometry"]["location"]["lng"]),
        name:json["name"],
      vicinity:json["vicinity"],
      placeId: json["place_id"]
    );
  }


}