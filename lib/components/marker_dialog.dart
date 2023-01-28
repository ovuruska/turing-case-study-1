import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:maps_places/models/place.dart';
import 'package:maps_places/repositories/google_maps.dart';
import 'package:transparent_image/transparent_image.dart';

/*

Expanded(
                              child: Wrap(
                            children: List<Widget>.generate(
                              options.length,
                              (int idx) {
                                return ChoiceChip(
                                  selectedColor: Color(0xFFD6D8DA),
                                  label: Text(options[idx],
                                      style: TextStyle(
                                          color: Color(0xFF989898),
                                          fontWeight: FontWeight.bold)),
                                  selected: true,
                                );
                              },
                            ).toList(),
                          ))
 */

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
    var photoReferences = widget.place.photoReferences;
    var types = widget.place.types;
    if (photo == null && photoReferences.isNotEmpty) {
      GoogleMapsRepository.instance
          .getPhoto(photoReferences[0])
          .then((value) => setState(() {
                photo = value;
              }));
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: 128,
        width: 320,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: (photo == null)
                  ? Placeholder(
                      fallbackHeight: 96,
                      fallbackWidth: 96,
                    )
                  : Image.memory(photo!),
            ),
            Flexible(
              child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(widget.place.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
                Text(widget.place.vicinity,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 9)),
                Wrap(
                  children: List<Widget>.generate(
                    max(0, min(types.length, 2)),
                    (int idx) {
                      return Padding(
                          padding: EdgeInsets.only(right: 4.0),
                          child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Color(0xFFD6D8DA),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(types[idx],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold))));
                    },
                  ).toList(),
                ),
                ElevatedButton(
                    onPressed: () => print("Button pressed."),
                    child: Text("Details"))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
