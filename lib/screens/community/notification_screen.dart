import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NotificationScreen extends StatelessWidget {
  final List<String> notifications;
  final VoidCallback onClear;

  const NotificationScreen({
    super.key,
    required this.notifications,
    required this.onClear,
  });

  IconData _getIcon(String message) {
    if (message.toLowerCase().contains('liked')) return Icons.favorite;
    if (message.toLowerCase().contains('comment')) return Icons.comment;
    if (message.toLowerCase().contains('post')) return Icons.notifications;
    return Icons.info;
  }

  Color _getColor(String message) {
    if (message.toLowerCase().contains('liked')) return Colors.redAccent;
    if (message.toLowerCase().contains('comment')) return Colors.blueAccent;
    return Colors.brown;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.brown),
        title: const Text("Notifications", style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_outlined),
            onPressed: onClear,
            tooltip: "Clear All",
          )
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text("No notifications yet!", style: TextStyle(color: Colors.grey, fontSize: 16)),
            )
          : ListView.builder(
              itemCount: notifications.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) => Animate(
                effects: const [FadeEffect(), SlideEffect(begin: Offset(0.1, 0))],
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(_getIcon(notifications[index]), color: _getColor(notifications[index])),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notifications[index],
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatTime(DateTime.now()),
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }
}
