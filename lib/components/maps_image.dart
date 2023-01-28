import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:maps_places/repositories/google_maps.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GoogleMapsImage extends StatelessWidget {
  final String? photoReference;
  final double width;
  final double height;

  GoogleMapsImage(
      {required this.photoReference, this.width = 96, this.height = 96});


  @override
  Widget build(BuildContext context) {


    return (photoReference == null)
        ? Placeholder(
            fallbackHeight: height,
            fallbackWidth: width,
          )
        : ClipRRect(
      borderRadius: BorderRadius.circular(20), // Image border
            child: SizedBox.fromSize(
                size: Size.fromRadius(192),
                child: CachedNetworkImage(
                    height: height,
                    width: width,
                    fit: BoxFit.fitWidth, imageUrl: GoogleMapsRepository.instance.getUrl(photoReference!,maxWidth:width.toInt(),maxHeight:height.toInt()),)),
          );
  }
}
