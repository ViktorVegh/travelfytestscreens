import '../model/post.dart';
import '../model/media.dart';
import '../model/location.dart';

class MockPost {
  List<Post> posts = [];

  MockPost() {
    posts = generateMockPosts();
  }

  List<Post> generateMockPosts() {
    Location mockLocation = Location(
      id: 1,
      address_id: 123,
      point_id: 456,
      region_id: 789,
      tags: ["tag1", "tag2"],
    );

    List<Media> mockMediaList = [
      Media(
        id: 1,
        type: MediaType.IMAGE,
        url: 'https://example.com/image1.jpg',
      ),
      Media(
        id: 2,
        type: MediaType.IMAGE,
        url: 'https://example.com/image2.jpg',
      ),
    ];

    return [
      Post(
        id: 1,
        mediaList: mockMediaList,
        timestamp: DateTime.now(),
        location: mockLocation,
        userId: 1,
        likeCount: 10,
        isLikedByCurrentUser: false,
      ),
      Post(
        id: 2,
        mediaList: mockMediaList,
        timestamp: DateTime.now().subtract(Duration(days: 1)),
        location: mockLocation,
        userId: 2,
        likeCount: 5,
        isLikedByCurrentUser: true,
      ),
    ];
  }

  void addPost(Post post) {
    posts.add(post);
  }
}
