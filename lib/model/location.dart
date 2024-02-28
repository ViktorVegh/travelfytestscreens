class Location {
  final int id;
  final int address_id;
  final int point_id;
  final int region_id;
  final List<String> tags;
  Location({
    required this.id,
    required this.address_id,
    required this.point_id,
    required this.region_id,
    required this.tags,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      address_id: json['address_id'],
      point_id: json['ponit_id'],
      region_id: json['region_id'],
      tags: json['tags'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address_id': address_id,
      'ponit_id': point_id,
      'region_id': region_id,
      'tags': tags,
    };
  }
}
