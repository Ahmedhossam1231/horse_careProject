/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_ui_flutter/controllers/horse_controller.dart';
import 'package:login_ui_flutter/screens/profile%20screens/add_horses.dart';

class HorseMainScreen extends StatefulWidget {
  const HorseMainScreen({super.key});

  @override
  State<HorseMainScreen> createState() => _HorseMainScreenState();
}

class _HorseMainScreenState extends State<HorseMainScreen> {
  int currentIndex = 0;
  final horseController = Get.find<HorseController>();

  void showHorseSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Obx(() {
          final horses = horseController.horseList;
          return horses.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("No horses available."),
                )
              : ListView.builder(
                  itemCount: horses.length,
                  itemBuilder: (context, index) {
                    final horse = horses[index];
                    final isSelected = horse['name'] == horseController.selectedHorse.value;

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: horse['image'] != null ? FileImage(horse['image']) : null,
                        child: horse['image'] == null ? const Icon(Icons.pets) : null,
                      ),
                      title: Text(horse['name'] ?? 'Unnamed Horse'),
                      trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
                      onTap: () {
                        horseController.selectedHorse.value = horse['name'];
                        Navigator.pop(context);
                        setState(() {});
                      },
                    );
                  },
                );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Center(child: Text("Home screen for ${horseController.selectedHorse.value}")),
      const Center(child: Text("Another feature screen")),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Horse App")),
      drawer: const CustomHorseDrawer(),
      body: Obx(() => screens[currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            showHorseSelector();
          } else {
            setState(() => currentIndex = index);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: "Horses"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        ],
      ),
    );
  }
}
*/