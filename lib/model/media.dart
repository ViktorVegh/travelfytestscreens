// models/media.dart
import 'post.dart';
import 'place.dart';

enum MediaType { REEL, IMAGE, VIDEO }

class Media {
  final int? id;
  final MediaType type;
  final String? url;
  final String? path;
  final Post? post;
  final Place? place;

  Media(
      {this.id,
      required this.type,
      this.url,
      this.path,
      this.post,
      this.place});

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'],
      type: MediaType.values
          .firstWhere((e) => e.toString() == 'MediaType.${json['type']}'),
      url: json['url'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'url': url,
      'path': path,
    };
  }
}
