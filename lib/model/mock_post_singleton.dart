import '../provider/mock_posts.dart';

class MockPostSingleton {
  static final MockPostSingleton _singleton = MockPostSingleton._internal();

  factory MockPostSingleton() {
    return _singleton;
  }

  MockPostSingleton._internal();

  final MockPost mockPost = MockPost();
}
