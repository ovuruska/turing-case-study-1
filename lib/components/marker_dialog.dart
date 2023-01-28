import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:maps_places/blocs/details.dart';
import 'package:maps_places/models/place.dart';
import 'package:maps_places/repositories/google_maps.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'maps_image.dart';

class MarkerDialog extends StatefulWidget {
  final GoogleMapsPlace place;

  MarkerDialog({required this.place});

  @override
  _MarkerDialogState createState() => _MarkerDialogState();
}

class _MarkerDialogState extends State<MarkerDialog> {
  Uint8List? photo;

  @override
  Widget build(BuildContext context) {
    var types = widget.place.types;

    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        //this right here
        child: SizedBox(
            width: 320,
            height: 360,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    child: CachedNetworkImage(
                        width: 320,
                        height: 160,
                        fit: BoxFit.cover,
                        imageUrl: GoogleMapsRepository.instance.getUrl(
                          widget.place.photoReferences[0],
                        ))),
                Container(height: 8),
                Text(widget.place.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                Container(height: 8),
                Text(widget.place.vicinity,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
                Container(height: 8),
                Wrap(
                  children: List<Widget>.generate(
                    max(0, min(types.length, 2)),
                    (int idx) {
                      return Padding(
                          padding: EdgeInsets.only(right: 4.0),
                          child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(types[idx],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))));
                    },
                  ).toList(),
                ),
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                      ElevatedButton(
                          onPressed: () {
                            detailsBloc.setPlace(widget.place);
                            Navigator.pushNamed(context, '/details');
                          },
                          child: Text("Details"))
                    ])),
                Container(height: 8)
              ],
            )));
  }
}
