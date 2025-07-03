import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:login_ui_flutter/controllers/horse_controller.dart';
import 'package:login_ui_flutter/screens/after home/Calander.dart';
import 'package:login_ui_flutter/screens/after home/E-commerce.dart';
import 'package:login_ui_flutter/screens/after home/achievement_screen.dart';
import 'package:login_ui_flutter/screens/after home/home_daily_data.dart';
import 'package:login_ui_flutter/screens/after home/horse_book_screen.dart';
import 'package:login_ui_flutter/screens/after home/horse_gallery_screen.dart';
import 'package:login_ui_flutter/screens/after home/horse_treatments.dart';
import 'package:login_ui_flutter/screens/after home/ocr_scanner_screen.dart';
import 'package:login_ui_flutter/screens/after home/family_tree_screen.dart';
import 'package:login_ui_flutter/screens/before_Home/login.dart';
import 'package:login_ui_flutter/screens/community/feed_screen.dart';
import 'package:login_ui_flutter/screens/profile screens/account_screen.dart';
import 'package:login_ui_flutter/screens/profile screens/horse_screen.dart';
import 'package:login_ui_flutter/utils/constanst.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final horseController = Get.find<HorseController>();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.6,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [t1, Color(0xFFC0D6DF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.person_2_outlined, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text("User Name",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add New Horse'),
              onTap: () async {
                final newHorse = await Navigator.push<Map<String, dynamic>>(
                  context,
                  MaterialPageRoute(builder: (_) => const Horse()),
                );
                if (newHorse != null && newHorse['name'] != null) {
                  horseController.addHorse(newHorse);
                  horseController.setHorse(newHorse);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.data_saver_off_sharp),
              title: const Text('Medical Care'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MedicalRecordScreen())),
            ),
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('Shop'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const HorseEcommerceScreen())),
            ),
            ListTile(
              leading: const Icon(Icons.star_border_purple500_outlined),
              title: const Text('Achievements'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AchievementScreen())),
            ),
            ListTile(
              leading: const Icon(Icons.photo_album),
              title: const Text('Gallery'),
              onTap: () {
                final horse = horseController.selectedHorse;
                final horseName = horse['name']?.toString() ?? '';
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => HorseGalleryScreen(horseName: horseName)));
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.tree),
              title: const Text('Family Tree'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const FamilyTreeScreen())),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text('calendar'.tr),
              onTap: () => Get.to(() => const CalendarScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('Scanner'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const OcrScannerScreen())),
            ),
            ListTile(
              leading: const Icon(Icons.book_rounded),
              title: const Text('Book'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const HorseBookScreen())),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const LoginScreen())),
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
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
          title: Obx(() {
            final selected = horseController.selectedHorse;
            final name = selected['name']?.toString() ?? 'Unnamed Horse';
            return Text(
              '$name Health',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            );
          }),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6C6F71), Color(0xFFC0D6DF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Obx(() {
          final name = horseController.selectedHorse['name']?.toString() ?? '';
          return DailyDataHomeScreen(horseName: name);
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (int index) {
          if (index == 1) {
            _showHorseList(context);
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const Horse()));
          } else if (index == 3) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const FeedScreen()));
          } else if (index == 4) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AccountScreen()));
          }
        },
        backgroundColor: t1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Horses'),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Icon(Icons.h_plus_mobiledata, size: 30),
            ),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  void _showHorseList(BuildContext context) {
    final horseController = Get.find<HorseController>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select a Horse",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: horseController.horseList.length,
                itemBuilder: (context, index) {
                  final horse = horseController.horseList[index];
                  return ListTile(
                    leading: const Icon(Icons.pets),
                    title: Text(horse['name'] ?? 'Unnamed'),
                    onTap: () {
                      horseController.setHorse(horse);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
