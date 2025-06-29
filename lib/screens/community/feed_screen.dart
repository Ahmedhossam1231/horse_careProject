//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:login_ui_flutter/screens/community/notification_screen.dart';
import 'add_post_screen.dart';
import 'comment_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<Map<String, dynamic>> posts = [];
  List<String> notifications = [];
  bool hasNewNotification = false;

  void addPost(Map<String, dynamic> post) {
    setState(() {
      posts.insert(0, post);
      notifications.add("New post added");
      hasNewNotification = true;
    });
  }

  void toggleLike(int index) {
    setState(() {
      bool isLiked = posts[index]["isLiked"];
      posts[index]["isLiked"] = !isLiked;
      posts[index]["likes"] += isLiked ? -1 : 1;
      notifications.add("Someone ${isLiked ? 'unliked' : 'liked'} your post");
      hasNewNotification = true;
    });
  }

  void addComment(int index, String comment) {
    setState(() {
      posts[index]["comments"].add(comment);
      notifications.add("New comment on your post");
      hasNewNotification = true;
    });
  }

  void openComments(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CommentScreen(
          post: posts[index],
          onAddComment: (comment) => addComment(index, comment),
        ),
      ),
    );
  }

  void openNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NotificationScreen(
          notifications: notifications,
          onClear: () {
            setState(() {
              notifications.clear();
              hasNewNotification = false;
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _editPost(int index) async {
    final editedPost = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => AddPostScreen(
          onPostAdded: (_) {},
          existingPost: posts[index],
        ),
      ),
    );

    if (editedPost != null) {
      setState(() {
        posts[index] = editedPost;
        notifications.add("Post updated");
        hasNewNotification = true;
      });
    }
  }

  void _deletePost(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Post"),
        content: const Text("Are you sure you want to delete this post?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                posts.removeAt(index);
                notifications.add("Post deleted");
                hasNewNotification = true;
              });
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F4),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Community", style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(FeatherIcons.bell, color: hasNewNotification ? Colors.red : Colors.brown.shade300),
            onPressed: openNotifications,
          )
        ],
      ),
      body: posts.isEmpty
          ? Center(
              child: Text("No posts yet. Add one!",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 18)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Animate(
                  effects: const [FadeEffect(duration: Duration(milliseconds: 400)), ScaleEffect()],
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    shadowColor: Colors.grey.shade300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top-right edit/delete
                        Align(
                          alignment: Alignment.topRight,
                          child: PopupMenuButton<String>(
                            icon: const Icon(FeatherIcons.moreVertical),
                            onSelected: (value) {
                              if (value == 'edit') _editPost(index);
                              if (value == 'delete') _deletePost(index);
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(FeatherIcons.edit2, size: 18),
                                    SizedBox(width: 8),
                                    Text('Edit')
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(FeatherIcons.trash2, size: 18, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text('Delete')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (post["postImage"] != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(post["postImage"],
                                height: 220, width: double.infinity, fit: BoxFit.cover),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            post["postText"] ?? "",
                            style: const TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  post["isLiked"] ? FeatherIcons.heart : FeatherIcons.heart,
                                  color: post["isLiked"] ? Colors.red : Colors.grey,
                                  size: 20,
                                ),
                                onPressed: () => toggleLike(index),
                              ),
                              Text("${post["likes"]}"),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(FeatherIcons.messageCircle, color: Colors.brown),
                                onPressed: () => openComments(index),
                              ),
                              Text("${post["comments"].length}"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddPostScreen(onPostAdded: addPost),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
