import 'package:flutter/material.dart';
import 'package:maps_places/blocs/details.dart';
import 'package:maps_places/common/stream_listenable_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:maps_places/repositories/google_maps.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

const imageWidth = 320.0;
const imageHeight = 320.0;

class DetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamListenableBuilder(
      stream: detailsBloc.stream,
      listener: (value) {},
      builder: (context, snapshot) => _build(context));

  Widget _build(BuildContext context) {
    var place = detailsBloc.subject.value;
    var rating = place.rating;
    var types = place.types;
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop()),
            title: Text(
              place.name,
            )),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(height: 32),
          Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Text(place.vicinity,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 16))),
          Container(height: 8),
          Wrap(
            children: List<Widget>.generate(
              place.types.length,
              (int idx) {
                return Padding(
                    padding: EdgeInsets.only(right: 4.0, bottom: 8.0),
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(place.types[idx],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold))));
              },
            ).toList(),
          ),
          Container(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(width: 16),
              RatingStars(
                value: rating,
                starBuilder: (index, color) => Icon(
                  Icons.star,
                  color: color,
                ),
                starCount: 5,
                starSize: 24,
                starSpacing: 4,
                starOffColor: Colors.grey,
                starColor: Colors.blue,
              ),
              Container(width: 8),
              Text(place.userRatingsTotal.toString() + " ratings"),
              Container(width: 16),
            ],
          ),
          Container(height:32),
              Text(
            "Photos",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Column(
              children: place.photoReferences
                  .map<Widget>((photoReference) => Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: imageWidth,
                              height: imageHeight,
                              imageUrl: GoogleMapsRepository.instance.getUrl(
                                photoReference,
                              )))))
                  .toList())
        ])));
  }
}
