import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_ui_flutter/controllers/horse_controller.dart';
import 'package:login_ui_flutter/screens/after home/achievement_screen.dart';
import 'package:login_ui_flutter/screens/after home/horse_treatments.dart';
import 'package:login_ui_flutter/screens/after home/calander.dart';
import 'package:login_ui_flutter/screens/after home/fullDailyData_screen.dart';
import 'package:login_ui_flutter/screens/profile screens/horse_screen.dart';

class DailyDataHomeScreen extends StatelessWidget {
  DailyDataHomeScreen({super.key, required this.horseName});
  final String horseName;
  final HorseController horseController = Get.find<HorseController>();

  Widget buildBlurCard({
    required String title,
    required String imagePath,
    required Color overlayColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                overlayColor.withOpacity(0.4), BlendMode.darken),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(2, 6),
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                  blurRadius: 4, color: Colors.black54, offset: Offset(1, 2)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Obx(() {
            final horses = horseController.horseList;
            return SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: horses.length + 1,
                itemBuilder: (context, index) {
                  if (index == horses.length) {
                    return GestureDetector(
                      onTap: () async {
                        final newHorse =
                            await Navigator.push<Map<String, dynamic>>(
                          context,
                          MaterialPageRoute(builder: (_) => const Horse()),
                        );
                        if (newHorse != null && newHorse['name'] != null) {
                          horseController.addHorse(newHorse);
                          horseController.setHorse(newHorse);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.teal.withOpacity(0.1),
                          border: Border.all(color: Colors.teal, width: 2),
                        ),
                        child:
                            const Icon(Icons.add, size: 28, color: Colors.teal),
                      ),
                    );
                  }

                  final horse = horses[index];
                  final selectedName =
                      horseController.selectedHorse['name']?.toString() ?? '';
                  final isSelected = selectedName == horse['name'];

                  return GestureDetector(
                    onTap: () => horseController.setHorse(horse),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: const Offset(1, 10),
                          )
                        ],
                        border: Border.all(
                          color: isSelected ? Colors.teal : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: (horse['image'] != null)
                            ? FileImage(File(horse['image']))
                            : null,
                        backgroundColor: Colors.white,
                        child: horse['image'] == null
                            ? const Icon(Icons.pets, color: Colors.brown)
                            : null,
                      ),
                    ),
                  );
                },
              ),
            );
          }),
          const SizedBox(height: 20),
          buildBlurCard(
            title: 'Daily Data',
            imagePath: 'assets/horse_data.jpg',
            overlayColor: Colors.teal,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const FullDailyDataScreen(),
              ),
            ),
          ),
          buildBlurCard(
            title: 'Medical Record',
            imagePath: 'assets/horse_medical.jpg',
            overlayColor: Colors.deepPurple,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MedicalRecordScreen()),
            ),
          ),
          buildBlurCard(
            title: 'Achievements',
            imagePath: 'assets/horse_awards.jpg',
            overlayColor: Colors.orange,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AchievementScreen()),
            ),
          ),
          buildBlurCard(
            title: 'Calendar',
            imagePath: 'assets/horse_calendar.jpg',
            overlayColor: Colors.blueGrey,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CalendarScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
