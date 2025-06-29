
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Map<String, dynamic> postData;
  final VoidCallback onLike;
  final Function(String) onComment;
  final VoidCallback onDelete;
  final Function(String, String?) onEdit;

  const PostCard({
    super.key,
    required this.postData,
    required this.onLike,
    required this.onComment,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();

    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(postData["userImage"])),
            title: Text(postData["username"], style: const TextStyle(fontWeight: FontWeight.bold)),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'delete') {
                  onDelete();
                } else if (value == 'edit') {
                  _showEditDialog(context);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'edit', child: Text("Edit")),
                const PopupMenuItem(value: 'delete', child: Text("Delete")),
              ],
            ),
          ),
          if (postData["postImage"] != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(postData["postImage"]),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(postData["postText"]),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  postData["isLiked"] ? Icons.favorite : Icons.favorite_border,
                  color: postData["isLiked"] ? Colors.red : Colors.grey,
                ),
                onPressed: onLike,
              ),
              Text("${postData["likes"]} likes"),
              const Spacer(),
              Icon(Icons.comment, color: Colors.grey[700]),
              Text(" ${postData["comments"].length} comments"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: const InputDecoration(
                      hintText: "Add a comment...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (commentController.text.trim().isNotEmpty) {
                      onComment(commentController.text.trim());
                      commentController.clear();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    final TextEditingController editTextController =
        TextEditingController(text: postData["postText"]);
    String? selectedImage = postData["postImage"];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Post"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: editTextController,
                maxLines: 3,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedImage,
                items: [
                  "assets/images/horse1.jpg",
                  "assets/images/horse2.jpg"
                ]
                    .map((img) => DropdownMenuItem(
                          value: img,
                          child: Text(img.split('/').last),
                        ))
                    .toList(),
                onChanged: (val) {
                  selectedImage = val;
                },
                decoration: const InputDecoration(labelText: "Choose Image"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              onEdit(editTextController.text.trim(), selectedImage);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
