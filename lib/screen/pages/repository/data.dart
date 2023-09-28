import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_app/models/user_post_model.dart';

class Data {
  static final List<UserPostModel> postList = [
    UserPostModel(
      name: "Parmina Gaba",
      profileUrl: "assets/random_profile.jpg",
      headline: "webdeveloper, flutter developer",
      tags: "#positivity #motivation #learing #progress #develpoment",
      Description: "latest news is cute",
      isVideoPost: false,
      comments: "345",
      Video: "",
      isOnline: false,
      image: "assets/random_profile.jpg",
      likes: "197",
      connections: '456',
    ),
    UserPostModel(
        name: "simran",
        headline: "misson sucessful",
        connections: "2367",
        profileUrl: "assets/random_profile.jpg",
        comments: "1k",
        image: "assets/random_profile.jpg",
        Description: "Stay Focussed",
        isOnline: true,
        Video: "",
        isVideoPost: false,
        likes: "1k",
        tags: "#DCRUST University"),
    UserPostModel(
        name: "simran",
        headline: "misson sucessful",
        connections: "2367",
        profileUrl: "assets/random_profile.jpg",
        comments: "1k",
        image: "assets/random_profile.jpg",
        Description: "Stay Focussed",
        isOnline: true,
        Video: "",
        isVideoPost: false,
        likes: "1k",
        tags: "#DCRUST University"),
    UserPostModel(
        name: "simran",
        headline: "misson sucessful",
        connections: "2367",
        profileUrl: "assets/random_profile.jpg",
        comments: "1k",
        image: "assets/random_profile.jpg",
        Description: "Stay Focussed",
        isOnline: true,
        Video: "",
        isVideoPost: false,
        likes: "1k",
        tags: "#DCRUST University"),
  ];
  static final userProfile = UserModel(
      name: "Punita Gaba",
      headline: "Software Engineer",
      connections: "9657",
      profileUrl: "assets/random_profile.jpg",
      viewProfile: "900");
}
