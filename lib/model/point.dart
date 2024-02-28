class Point {
  final int id;
  final int longitude;
  final int latitude;

  Point({required this.id, required this.longitude, required this.latitude});

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
        id: json['id'],
        latitude: json['latitude'],
        longitude: json['longitude']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
