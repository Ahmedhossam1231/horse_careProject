import 'package:flutter/material.dart';
import 'package:login_ui_flutter/controllers/horse_controller.dart';
import 'package:login_ui_flutter/screens/after%20home/Calander.dart';
//import 'package:login_ui_flutter/screens/after%20home/DailyLogScreen.dart';
import 'package:login_ui_flutter/screens/after%20home/E-commerce.dart';
import 'package:login_ui_flutter/screens/after%20home/achievement_screen.dart';
import 'package:login_ui_flutter/screens/after%20home/home_daily_data.dart';
import 'package:login_ui_flutter/screens/after%20home/horse_book_screen.dart';
import 'package:login_ui_flutter/screens/after%20home/horse_gallery_screen.dart';
import 'package:login_ui_flutter/screens/after%20home/horse_treatments.dart';
import 'package:login_ui_flutter/screens/after%20home/ocr_scanner_screen.dart';
import 'package:login_ui_flutter/screens/after%20home/family_tree_screen.dart';
import 'package:login_ui_flutter/screens/before_Home/login.dart';
import 'package:login_ui_flutter/screens/community/feed_screen.dart';
import 'package:login_ui_flutter/screens/profile%20screens/account_screen.dart';
import 'package:login_ui_flutter/screens/profile%20screens/horse_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_ui_flutter/utils/constanst.dart';
import 'package:get/get.dart';
//import 'package:animate_do/animate_do.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  List<String> horses = [];

  final horseName = Get.find<HorseController>().selectedHorse.value;


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
           /* ListTile(
              leading: const Icon(Icons.data_saver_off_sharp),
              title: const Text('daily data '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DailyLogScreen()),
                );
              },
            ),*/
            ListTile(
              leading: const Icon(Icons.data_saver_off_sharp),
              title: const Text(' Medical Care '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MedicalRecordScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text(' Shop'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HorseEcommerceScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.star_border_purple500_outlined),
              title: const Text(' achievements'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AchievementScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_album),
              title: const Text(' gallery'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HorseGalleryScreen(
                            horseName: '',
                          )),
                );
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.tree),
              title: const Text('family tree'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FamilyTreeScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text('calendar'.tr),
              onTap: () {
                Get.to(() => const CalendarScreen());
              },
            ),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('scanner'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OcrScannerScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_rounded),
              title: const Text('book'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HorseBookScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
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
          
          title: Text(
            '$horseName Health'.tr,
            style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0)),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 108, 111, 113), Color(0xFFC0D6DF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const DailyDataScreen(), // هنا بنستدعي التصميم اللي جهزناه فوق
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });

          if (index == 1) {
            _showHorseList(context);
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FeedScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AccountScreen()),
            );
          }
        },
        backgroundColor: t1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Horses'),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget buildDataContainer(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      height: 200,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 1, 13, 42),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  void _showHorseList(BuildContext context) {
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
              const Text(
                "Select a Horse",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: horses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.pets),
                    title: Text(horses[index]),
                    onTap: () {
                      Get.find<HorseController>().setHorse(horses[index]);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Horse(
                            horseName: horses[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text("Add New Horse"),
                onTap: () async {
                  Navigator.pop(context);

                  final newHorseName = await Navigator.push<String>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Horse(),
                    ),
                  );

                  if (newHorseName != null && newHorseName.isNotEmpty) {
                    setState(() {
                      horses.add(newHorseName);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
