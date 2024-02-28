import 'visited.place.dart';

import 'post.dart';
import 'trip.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String? profilePicture;
  final List<Post>? posts;
  final List<Trip>? trips;
  final List<VisitedPlace>? visitedPlaces;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      this.profilePicture,
      this.posts,
      this.trips,
      this.visitedPlaces});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        profilePicture: json['profilePicture'],
        posts: json['posts'] != null
            ? (json['posts'] as List).map((e) => Post.fromJson(e)).toList()
            : null,
        trips: json['trips'] != null
            ? (json['trips'] as List).map((e) => Trip.fromJson(e)).toList()
            : null,
        visitedPlaces: json['visitedPlaces'] != null
            ? (json['visitedPlaces'] as List)
                .map((e) => VisitedPlace.fromJson(e))
                .toList()
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
      'posts': posts?.map((e) => e.toJson()).toList(),
      'trips': trips?.map((e) => e.toJson()).toList(),
      'visitedPlaces': visitedPlaces?.map((e) => e.toJson()).toList()
    };
  }
}
