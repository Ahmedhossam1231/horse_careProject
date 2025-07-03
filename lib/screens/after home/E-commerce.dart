import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animations/animations.dart';
import 'package:login_ui_flutter/controllers/horse_controller.dart';

class HorseEcommerceScreen extends StatefulWidget {
  const HorseEcommerceScreen({super.key});

  @override
  State<HorseEcommerceScreen> createState() => _HorseEcommerceScreenState();
}

class _HorseEcommerceScreenState extends State<HorseEcommerceScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> marketItems = [];
  Map<String, dynamic>? selectedHorse;
  File? selectedImage;

  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final PageTransitionSwitcherTransitionBuilder transitionBuilder =
      (child, animation, secondaryAnimation) => FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Load horses from HorseController into marketItems initially
   /* final horseController = Get.find<HorseController>();
    for (var horse in horseController.horseList) {
      marketItems.add({
        'name': horse['name'],
        'price': horse['price'],
        'desc': horse['description'],
        'image': horse['image'],
        'type': 'Horse',
      });
    }*/
  }

  @override
  void dispose() {
    _tabController.dispose();
    priceController.dispose();
    descController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => selectedImage = File(pickedFile.path));
    }
  }

  void addItemToMarket() {
    if (selectedHorse != null && priceController.text.isNotEmpty) {
      marketItems.add({
        'name': selectedHorse!['name'],
        'price': priceController.text,
        'desc': descController.text,
        'image': selectedImage ?? selectedHorse!['image'],
        'type': 'Horse',
      });
      // Reset form
      selectedHorse = null;
      priceController.clear();
      descController.clear();
      selectedImage = null;
      setState(() {});
      _tabController.animateTo(0);
    } else {
      Get.snackbar('Error', 'Please select a horse and enter a price');
    }
  }

  Widget buildMarketCard(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ScaleTransition(
        scale: CurvedAnimation(
            parent: AnimationController(
              duration: const Duration(milliseconds: 600),
              vsync: this,
            )..forward(),
            curve: Curves.easeOutBack),
        child: OpenContainer(
          closedElevation: 6,
          openElevation: 0,
          transitionDuration: const Duration(milliseconds: 600),
          closedColor: Colors.white,
          openColor: Colors.white,
          closedBuilder: (context, action) => ListTile(
            onTap: action,
            leading: CircleAvatar(
              backgroundImage: item['image'] == null
                  ? AssetImage('assets/images/default_avatar.png')
                  : (item['image'] is File
                      ? FileImage(item['image'])
                      : NetworkImage(item['image']) as ImageProvider),
              radius: 28,
            ),
            title: Text(item['name'] ?? 'No Name',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item['desc'] ?? ''),
            trailing: Text('\$${item['price'] ?? '0'}'),
          ),
          openBuilder: (context, _action) => Scaffold(
            appBar: AppBar(title: Text(item['name'] ?? 'No Name')),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: item['image'] is File
                        ? Image.file(item['image'], height: 200)
                        : Image.network(item['image'], height: 200),
                  ),
                  const SizedBox(height: 20),
                  Text("Category: ${item['type']}",
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text("Price: \$${item['price']}",
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  const Text("Description:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(item['desc'] ?? 'No description')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAddForm() {
    final horseController = Get.find<HorseController>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          DropdownButtonFormField<Map<String, dynamic>>(
            value: selectedHorse,
            items: horseController.horseList.map((horse) {
              return DropdownMenuItem<Map<String, dynamic>>(
                value: horse,
                child: Text(horse['name']),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                selectedHorse = val;
                // Clear previous inputs except horse name
                priceController.clear();
                descController.clear();
                selectedImage = null;
              });
            },
            decoration: const InputDecoration(labelText: 'Select Horse'),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Price'),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: descController,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          const SizedBox(height: 14),
          selectedImage == null
              ? OutlinedButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text("Select Image from Gallery"),
                  onPressed: pickImage,
                )
              : Image.file(selectedImage!, height: 160),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: addItemToMarket,
            icon: const Icon(Icons.add_box),
            label: const Text("Add to Marketplace"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: const Text("Horse Marketplace"),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.store), text: 'Market'),
              Tab(icon: Icon(Icons.add_circle), text: 'Add Item'),
            ],
          ),
        ),
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: transitionBuilder,
          child: TabBarView(
            controller: _tabController,
            children: [
              marketItems.isEmpty
                  ? const Center(child: Text("No items yet"))
                  : ListView.builder(
                      itemCount: marketItems.length,
                      itemBuilder: (context, index) =>
                          buildMarketCard(marketItems[index]),
                    ),
              buildAddForm(),
            ],
          ),
        ),
      ),
    );
  }
}
