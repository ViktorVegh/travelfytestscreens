class VisitedPlace {
  final int id;
  final int userId;
  final int tripId;
  final int placeId;
  final DateTime visitTime;

  VisitedPlace(
      {required this.id,
      required this.userId,
      required this.tripId,
      required this.placeId,
      required this.visitTime});

  factory VisitedPlace.fromJson(Map<String, dynamic> json) {
    return VisitedPlace(
      id: json['id'] as int,
      userId: json['userId'] as int,
      placeId: json['placeId'] as int,
      tripId: json['tripId'] as int,
      visitTime: DateTime.parse(json['visitTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'tripId': tripId,
      'placeId': placeId,
      'visitTime': visitTime.toIso8601String(),
    };
  }
}
