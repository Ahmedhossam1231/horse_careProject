//import 'dart:io';
import 'package:get/get.dart';

class PostController extends GetxController {
  var posts = <Map<String, dynamic>>[].obs;
  var notifications = <String>[].obs;
  var hasNewNotifications = false.obs;

  void addPost(Map<String, dynamic> post) {
    posts.insert(0, post);
    addNotification("New post added");
  }

  void toggleLike(int index) {
    posts[index]["isLiked"] = !(posts[index]["isLiked"] ?? false);
    posts[index]["likes"] += posts[index]["isLiked"] ? 1 : -1;
    addNotification("Someone liked your post");
    posts.refresh();
  }

  void addComment(int index, String comment) {
    posts[index]["comments"].add(comment);
    addNotification("New comment on your post");
    posts.refresh();
  }

  void addNotification(String message) {
    notifications.add(message);
    hasNewNotifications.value = true;
  }

  void clearNotifications() {
    hasNewNotifications.value = false;
  }
}
