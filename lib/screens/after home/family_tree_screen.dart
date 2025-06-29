import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_ui_flutter/controllers/horse_controller.dart';
import 'package:login_ui_flutter/utils/constanst.dart';
import 'enter_data.dart';

class FamilyTreeScreen extends StatefulWidget {
  const FamilyTreeScreen({super.key});

  @override
  State<FamilyTreeScreen> createState() => _FamilyTreeScreenState();
}

class _FamilyTreeScreenState extends State<FamilyTreeScreen> {
  final Map<String, List<List<Map<String, String>>>> horseGenerations = {};
final String horseName = Get.find<HorseController>().selectedHorse.value;

  @override
  void initState() {
    super.initState();
    Obx(() {
  final horseName = Get.find<HorseController>().selectedHorse.value;
  return Text("Selected horse: $horseName");
});
    horseGenerations.putIfAbsent(horseName, () => List.generate(6, (_) => []));
  }

  List<List<Map<String, String>>> get generations => horseGenerations[horseName]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7EFF1),
      appBar: AppBar(
        title: Text("family tree - $horseName"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [t1, Color(0xFFC0D6DF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: generations.length,
        itemBuilder: (context, index) {
          final currentGen = generations[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  child: ListTile(
                    leading: const Icon(Icons.family_restroom, color: Colors.teal, size: 32),
                    title: Text(
                      "Generation ${index + 1}\n ${currentGen.length} members",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.green),
                      onPressed: currentGen.length >= (index + 1) * 2
                          ? null
                          : () async {
                              final result = await Navigator.push<Map<String, String>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FamilyTreeEntryScreen(generation: index + 1),
                                ),
                              );
                              if (result != null) {
                                setState(() {
                                  generations[index].add(result);
                                });
                              }
                            },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: currentGen.map((data) => _buildHorseCard(data)).toList(),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: t1,
        onTap: (index) {
          if (index == 0) {
            // Save
            for (int i = 0; i < generations.length; i++) {
              debugPrint("Gen ${i + 1}:");
              for (var horse in generations[i]) {
                debugPrint(horse.toString());
              }
            }
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Data Saved (printed in debug console)')),
            );
          } else if (index == 1) {
            // Delete
            setState(() {
              for (int i = 0; i < generations.length; i++) {
                if (generations[i].isNotEmpty) {
                  generations[i].removeLast();
                  break;
                }
              }
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Last horse deleted')),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.save_alt_sharp, color: Color.fromARGB(255, 72, 69, 69)),
            label: 'Save',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete_outline_outlined, color: Color.fromARGB(255, 72, 69, 69)),
            label: 'Delete',
          ),
        ],
      ),
    );
  }

  Widget _buildHorseCard(Map<String, String> data) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF80CBC4), Color(0xFF26A69A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.shade100.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.pets, size: 40, color: Colors.white),
          const SizedBox(height: 8),
          Text(data['name'] ?? 'Unknown',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          Text(data['age'] ?? 'Unknown',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          Text(data['relation'] ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
}
