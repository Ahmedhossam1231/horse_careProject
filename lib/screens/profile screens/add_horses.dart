/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_ui_flutter/controllers/horse_controller.dart';
import 'package:login_ui_flutter/screens/profile%20screens/horse_screen.dart';

class CustomHorseDrawer extends StatelessWidget {
  const CustomHorseDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final horseController = Get.find<HorseController>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.brown),
            child: Text('Horse Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add New Horse'),
            onTap: () async {
              final newHorse = await Navigator.push<Map<String, dynamic>>(
                context,
                MaterialPageRoute(builder: (_) => const Horse()),
              );
              if (newHorse != null) {
                horseController.horseList.add(newHorse);
                horseController.selectedHorse.value = newHorse['name'];
              }
            },
          ),
          // Add other items here if needed
        ],
      ),
    );
  }
}
*/