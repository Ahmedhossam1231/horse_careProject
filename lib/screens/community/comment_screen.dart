//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CommentScreen extends StatefulWidget {
  final Map<String, dynamic> post;
  final Function(String) onAddComment;

  const CommentScreen({super.key, required this.post, required this.onAddComment});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F4),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Comments", style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.brown),
      ),
      body: Animate(
        effects: const [FadeEffect(), SlideEffect(begin: Offset(0, 0.1))],
        child: Column(
          children: [
            if (widget.post["postImage"] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.file(
                  widget.post["postImage"],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(widget.post["postText"], style: const TextStyle(fontSize: 16)),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: widget.post["comments"].length,
                itemBuilder: (context, index) => Animate(
                  effects: const [FadeEffect(), ScaleEffect()],
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.person, color: Colors.brown),
                        const SizedBox(width: 10),
                        Expanded(child: Text(widget.post["comments"][index]))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: "Write a comment...",
                        filled: true,
                        fillColor: const Color(0xFFF3F2F0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.brown),
                    onPressed: () {
                      if (_commentController.text.trim().isNotEmpty) {
                        widget.onAddComment(_commentController.text.trim());
                        _commentController.clear();
                        setState(() {});
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
