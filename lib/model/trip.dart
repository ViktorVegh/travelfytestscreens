import 'visited.place.dart';

class Trip {
  final int id;
  final int userId;
  final DateTime startTime;
  final DateTime endTime;
  final List<VisitedPlace> visitedPlace;
  final int route_id;
  final bool isFinished;

  Trip(
      {required this.id,
      required this.userId,
      required this.startTime,
      required this.endTime,
      required this.visitedPlace,
      required this.route_id,
      required this.isFinished});

  factory Trip.fromJson(Map<String, dynamic> json) {
    var visitedPlaces = (json['VisitedPlace'] as List)
        .map((i) => VisitedPlace.fromJson(i))
        .toList();

    return Trip(
        id: json['id'],
        userId: json['user_id'],
        startTime: DateTime.parse(json['start_time']),
        endTime: DateTime.parse(json['end_time']),
        visitedPlace: visitedPlaces,
        route_id: json['route_id'],
        isFinished: json['isFinished']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'tripVisited': visitedPlace.map((e) => e.toJson()).toList(),
      'route_id': route_id,
      'isFinished': isFinished,
    };
  }
}
