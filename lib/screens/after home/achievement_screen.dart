
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
//import 'package:collection/collection.dart';
import 'package:login_ui_flutter/controllers/horse_controller.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({super.key});

  @override
  State<AchievementScreen> createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  final HorseController horseController = Get.find();
  List<Map<String, dynamic>> achievements = [];

  @override
  void initState() {
    super.initState();
    _addSystemAchievements();
  }

  void _addSystemAchievements() {
    achievements.addAll([
      {
        "title": "5 Days of Training",
        "desc": "Completed 5 consecutive days of training.",
        "icon": Icons.directions_run,
        "type": "Training",
        "badge": "bronze",
        "date": DateTime.now().subtract(const Duration(days: 1)),
      },
      {
        "title": "Excellent Sleep Streak",
        "desc": "Great sleep recorded for 3 days straight.",
        "icon": Icons.bedtime,
        "type": "Health",
        "badge": "silver",
        "date": DateTime.now().subtract(const Duration(days: 2)),
      },
    ]);
  }

  void addAchievement() {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    String selectedType = "Training";
    final types = ["Training", "Health", "Competition", "Custom"];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            final isValid = titleController.text.isNotEmpty && descController.text.isNotEmpty;

            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '🎖️ Add Achievement',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        prefixIcon: const Icon(Icons.title),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descController,
                      decoration: InputDecoration(
                        labelText: 'Details',
                        prefixIcon: const Icon(Icons.description),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedType,
                      items: types.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                      onChanged: (val) => setState(() => selectedType = val!),
                      decoration: InputDecoration(
                        labelText: "Type",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.category),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                        ),
                        ElevatedButton.icon(
                          onPressed: isValid
                              ? () {
                                  setState(() {
                                    achievements.add({
                                      "title": titleController.text,
                                      "desc": descController.text,
                                      "icon": Icons.star,
                                      "type": selectedType,
                                      "badge": _autoBadge(selectedType),
                                      "date": DateTime.now(),
                                    });
                                  });
                                  Navigator.pop(ctx);
                                }
                              : null,
                          icon: const Icon(Icons.save),
                          label: const Text("Save",style: TextStyle(color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            disabledBackgroundColor: Colors.brown.shade200,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _autoBadge(String type) {
    switch (type) {
      case "Training":
        return "bronze";
      case "Health":
        return "silver";
      case "Competition":
        return "gold";
      default:
        return "custom";
    }
  }

  int get level => (achievements.length / 3).ceil();

  Widget badgeIcon(String badge) {
    Color color;
    IconData icon;
    switch (badge) {
      case "gold":
        color = Colors.amber;
        icon = Icons.workspace_premium;
        break;
      case "silver":
        color = Colors.grey;
        icon = Icons.military_tech;
        break;
      case "bronze":
        color = Colors.brown;
        icon = Icons.emoji_events;
        break;
      default:
        color = Colors.blueGrey;
        icon = Icons.star_border;
    }
    return Icon(icon, color: color, size: 26);
  }

  @override
  Widget build(BuildContext context) {
    final horseName = horseController.selectedHorse.value;
    final horse = horseController.horseList.firstWhereOrNull((h) => h['name'] == horseName);
    final imageFile = (horse != null && horse['image'] is File) ? horse['image'] as File : null;
    final displayName = (horse != null && horse['name'] is String) ? horse['name'] as String : 'Unnamed Horse';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Horse Achievements'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: addAchievement,
        child: const Icon(Icons.add),
      ),
      body: horse == null
          ? const Center(child: Text("Please select a horse first."))
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.brown.shade50,
                    boxShadow: [BoxShadow(color: Colors.brown.shade100, blurRadius: 6)],
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage: imageFile != null ? FileImage(imageFile) : null,
                        child: imageFile == null ? const Icon(Icons.pets, color: Colors.brown, size: 28) : null,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(displayName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text("Level $level", style: TextStyle(color: Colors.brown.shade400)),
                        ],
                      ),
                      const Spacer(),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(
                              value: (achievements.length % 3) / 3,
                              color: Colors.brown,
                              backgroundColor: Colors.brown.shade100,
                              strokeWidth: 4,
                            ),
                          ),
                          Text("${achievements.length}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: achievements.isEmpty
                      ? const Center(child: Text("No achievements yet!"))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: achievements.length,
                          itemBuilder: (context, index) {
                            final item = achievements[index];
                            return Animate(
                              effects: const [FadeEffect(), SlideEffect()],
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.brown.shade100,
                                      child: Icon(item['icon'], color: Colors.brown),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  item['title'],
                                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              badgeIcon(item['badge']),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(item['desc']),
                                          const SizedBox(height: 4),
                                          Text(
                                            "🏷 ${item['type']}   📅 ${item['date'].toString().split(' ')[0]}",
                                            style: TextStyle(color: Colors.brown.shade300, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
