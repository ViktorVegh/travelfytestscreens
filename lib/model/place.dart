import 'visited.place.dart';

import 'location.dart';
import 'review.dart';
import 'media.dart';
import 'point.dart';
import 'region.dart';
import 'trip.dart';

class Place {
  final int id;
  final String googlePlacesId;
  final String name;
  final Location location; // Assuming you have a Location model
  final String websiteUrl;
  final String phoneNumber;
  final String imageUrl;
  final List<Review> reviews; // Assuming you have a Review model
  final List<Media> mediaList; // Assuming you have a Media model
  final List<Trip> trips; // Assuming you have a Media model
  final List<VisitedPlace> visitedPlace; // Assuming you have a Media model
  final Point point; // Assuming you have a Point model
  final List<String> tags;
  final Region region; // Assuming you have a Region model

  Place({
    required this.id,
    required this.googlePlacesId,
    required this.name,
    required this.location,
    required this.websiteUrl,
    required this.phoneNumber,
    required this.imageUrl,
    required this.reviews,
    required this.mediaList,
    required this.trips,
    required this.visitedPlace,
    required this.point,
    required this.tags,
    required this.region,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'] as int,
      googlePlacesId: json['googlePlacesId'] as String,
      name: json['name'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      websiteUrl: json['websiteUrl'] as String,
      phoneNumber: json['phoneNumber'] as String,
      imageUrl: json['imageUrl'] as String,
      reviews: (json['reviews'] as List)
          .map((review) => Review.fromJson(review))
          .toList(),
      mediaList: (json['mediaList'] as List)
          .map((media) => Media.fromJson(media))
          .toList(),
      trips:
          (json['trips'] as List).map((trips) => Trip.fromJson(trips)).toList(),
      visitedPlace: (json['visitedPlace'] as List)
          .map((visitedPlace) => VisitedPlace.fromJson(visitedPlace))
          .toList(),
      point: Point.fromJson(json['point'] as Map<String, dynamic>),
      tags: List<String>.from(json['tags']),
      region: Region.fromJson(json['region'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'googlePlacesId': googlePlacesId,
      'name': name,
      'location': location.toJson(),
      'websiteUrl': websiteUrl,
      'phoneNumber': phoneNumber,
      'reviews': reviews.map((review) => review.toJson()).toList(),
      'mediaList': mediaList.map((media) => media.toJson()).toList(),
      'point': point.toJson(),
      'tags': tags,
      'region': region.toJson(),
    };
  }
}
