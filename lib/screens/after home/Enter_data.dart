// enter_data.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_ui_flutter/controllers/horse_controller.dart';

class FamilyTreeEntryScreen extends StatefulWidget {
  final int generation;

  const FamilyTreeEntryScreen({super.key, required this.generation});

  @override
  State<FamilyTreeEntryScreen> createState() => _FamilyTreeEntryScreenState();
}

class _FamilyTreeEntryScreenState extends State<FamilyTreeEntryScreen> with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController relationController = TextEditingController();

  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _animationController.forward();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    relationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String horseName = Get.find<HorseController>().selectedHorse.value;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Family Member - Gen ${widget.generation}'),
        centerTitle: true,
        backgroundColor: const Color(0xFF80CBC4),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Horse Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: relationController,
                decoration: const InputDecoration(labelText: 'Relation'),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context, {
                    'name': nameController.text,
                    'age': ageController.text,
                    'relation': relationController.text,
                    'horse': horseName, // ربط الداتا باسم الحصان
                  });
                },
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF26A69A),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
