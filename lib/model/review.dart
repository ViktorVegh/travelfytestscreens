class Review {
  final int id;
  final String content;
  final int rating;
  final int placeId;
  final int userId;
  final int visitedPlaceId;
  final String authorName;
  final String authorProfilePicture;

  Review({
    required this.id,
    required this.content,
    required this.rating,
    required this.visitedPlaceId,
    required this.userId,
    required this.placeId,
    required this.authorName,
    required this.authorProfilePicture,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        id: json['id'],
        content: json['content'],
        rating: json['rating'],
        placeId: json['placeId'],
        userId: json['userId'],
        visitedPlaceId: json['visitedPlaceId'],
        authorName: json['authorName'],
        authorProfilePicture: json['authorProfilePicture']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'rating': rating,
      'placeId': placeId,
      'userId': userId,
      'countryVisited': visitedPlaceId,
      'authorName': authorName,
      'authorProfilePicture': authorProfilePicture
    };
  }
}
