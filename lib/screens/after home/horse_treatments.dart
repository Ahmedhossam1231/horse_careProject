import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_ui_flutter/controllers/horse_controller.dart';

class MedicalRecordScreen extends StatefulWidget {
  const MedicalRecordScreen({super.key});

  @override
  State<MedicalRecordScreen> createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordScreen>
    with TickerProviderStateMixin {
  final horseName = Get.find<HorseController>().selectedHorse.value;

  List<String> vaccinations = [];
  List<String> doctorVisits = [];
  List<String> surgeries = [];
  List<String> treatments = [];

  late TabController _tabController;
  final TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    inputController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _addEntry(List<String> list) {
    if (inputController.text.isNotEmpty) {
      setState(() => list.add(inputController.text));
      inputController.clear();
    }
  }

  Widget _buildAnimatedList(List<String> items, IconData icon, Color color) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  items[index],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabContent(List<String> dataList, String label, IconData icon, Color color) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: inputController,
                  decoration: InputDecoration(
                    hintText: 'Add $label...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => _addEntry(dataList),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Icon(Icons.add, color: Colors.white),
              )
            ],
          ),
        ),
        Expanded(child: _buildAnimatedList(dataList, icon, color))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$horseName Medical Records'),
        backgroundColor: Colors.teal.shade600,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(FontAwesomeIcons.syringe), text: 'Vaccines'),
            Tab(icon: Icon(FontAwesomeIcons.userDoctor), text: 'Doctor'),
            Tab(icon: Icon(FontAwesomeIcons.userDoctor), text: 'Surgeries'),
            Tab(icon: Icon(FontAwesomeIcons.pills), text: 'Treatments'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent(vaccinations, 'Vaccination', FontAwesomeIcons.syringe, Colors.redAccent),
          _buildTabContent(doctorVisits, 'Doctor Visit', FontAwesomeIcons.userDoctor, Colors.blueAccent),
          _buildTabContent(surgeries, 'Surgery', FontAwesomeIcons.userDoctor, Colors.purpleAccent),
          _buildTabContent(treatments, 'Treatment', FontAwesomeIcons.pills, Colors.green),
        ],
      ),
      backgroundColor: const Color(0xFFF4FAFF),
    );
  }
}
