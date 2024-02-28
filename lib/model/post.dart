import 'media.dart';
import 'location.dart';

class Post {
  final int? id;
  final List<Media>? mediaList;
  final DateTime timestamp;
  final Location? location;
  final int userId;
  final int likeCount;
  final bool isLikedByCurrentUser;

  Post({
    this.id,
    required this.mediaList,
    required this.timestamp,
    required this.location,
    required this.userId,
    required this.likeCount,
    required this.isLikedByCurrentUser,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      mediaList: (json['mediaList'] as List?)
              ?.map((i) => Media.fromJson(i))
              .toList() ??
          [],
      timestamp: DateTime.parse(json['timestamp']),
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      userId: json['userId'],
      likeCount: json['likeCount'],
      isLikedByCurrentUser: json['isLikedByCurrentUser'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mediaList': mediaList?.map((e) => e.toJson()).toList(),
      'timestamp': timestamp.toIso8601String(),
      'location': location?.toJson(),
      'userId': userId,
      'likeCount': likeCount,
      'isLikedByCurrentUser': isLikedByCurrentUser,
    };
  }
}
