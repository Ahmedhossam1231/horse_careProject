import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:login_ui_flutter/screens/home.dart';
import 'package:login_ui_flutter/screens/profile%20screens/edit_screen.dart';
import 'package:login_ui_flutter/widgets/forward_button.dart';
import 'package:login_ui_flutter/widgets/setting_item.dart';
import 'package:login_ui_flutter/widgets/setting_switch.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(
              () => const Home(),
              transition: Transition.leftToRight,
            );
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'settings'.tr,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'account'.tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Image.asset("assets/images/avatar.png",
                        width: 70, height: 70),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          'your_name'.tr, 
                          style:const  TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'your_photo'.tr,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    ForwardButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditAccountScreen(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'settings'.tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: const Icon(Ionicons.earth, color: Colors.orange),
                  title: Text('language'.tr),
                  trailing: Text(
                    Get.locale?.languageCode == 'en' ? 'english'.tr : 'arabic'.tr,
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text('english'.tr),
                            onTap: () {
                              Get.updateLocale(const Locale('en'));
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('arabic'.tr),
                            onTap: () {
                              Get.updateLocale(const Locale('ar'));
                              Navigator.pop(context);
                              print('settings'.tr);

                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: 'notifications'.tr,
                icon: Ionicons.notifications,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingSwitch(
                title: 'location'.tr,
                icon: Ionicons.earth,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: isDarkMode,
               onTap: (value) { /*
                  setState(() {
                    isDarkMode = value;
                  });*/
                },
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: 'Calander'.tr,
                icon: Ionicons.calculator_sharp,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: 'chat'.tr,
                icon: Ionicons.chatbox,
                bgColor: const Color.fromARGB(255, 202, 227, 195),
                iconColor: const Color.fromARGB(255, 33, 140, 60),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
