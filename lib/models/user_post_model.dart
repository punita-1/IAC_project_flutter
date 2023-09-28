class UserPostModel {
  final String name;
  final String connections;
  final String Description;
  final String headline;
  final String profileUrl;
  final String Video;
  final String image;
  final String comments;
  final String likes;
  final String tags;
  final bool isOnline;
  final bool isVideoPost;

  UserPostModel({
    required this.name,
    required this.headline,
    required this.connections,
    required this.profileUrl,
    required this.comments,
    required this.image,
    required this.Description,
    required this.isOnline,
    required this.Video,
    required this.isVideoPost,
    required this.likes,
    required this.tags,
  });
}
