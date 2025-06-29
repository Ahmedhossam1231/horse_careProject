import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onPostAdded;
  final Map<String, dynamic>? existingPost;

  const AddPostScreen({super.key, required this.onPostAdded, this.existingPost});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  late TextEditingController _controller;
  File? _image;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.existingPost?['postText'] ?? "");
    _image = widget.existingPost?['postImage'];
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  void _submitPost() {
    final text = _controller.text.trim();
    if (text.isEmpty && _image == null) return;

    final updatedPost = {
      "postText": text,
      "postImage": _image,
      "likes": widget.existingPost?['likes'] ?? 0,
      "isLiked": widget.existingPost?['isLiked'] ?? false,
      "comments": widget.existingPost?['comments'] ?? [],
    };

    widget.onPostAdded(updatedPost);
    Navigator.pop(context, updatedPost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingPost != null ? "Edit Post" : "Add Post"),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "What's on your mind?",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            _image != null
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(_image!, height: 180, width: double.infinity, fit: BoxFit.cover),
                      ),
                      Positioned(
                        top: 6,
                        right: 6,
                        child: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            icon: Icon(Icons.close, color: Colors.white, size: 18),
                            onPressed: () => setState(() => _image = null),
                          ),
                        ),
                      ),
                    ],
                  )
                : ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: const Text("Add Image"),
                  ),
            const Spacer(),
            ElevatedButton(
              onPressed: _submitPost,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
              child: Text(widget.existingPost != null ? "Update" : "Post"),
            )
          ],
        ),
      ),
    );
  }
}
