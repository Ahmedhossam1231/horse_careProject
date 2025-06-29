import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:login_ui_flutter/controllers/horse_controller.dart';
import 'package:login_ui_flutter/utils/constanst.dart';

class DailyDataScreen extends StatefulWidget {
  const DailyDataScreen({super.key});

  @override
  State<DailyDataScreen> createState() => _DailyDataScreenState();
}

class _DailyDataScreenState extends State<DailyDataScreen> {
  final horseName = Get.find<HorseController>().selectedHorse.value;
  final Map<String, Map<String, dynamic>> horseDailyData = {};

@override
void initState() {
  super.initState();
  final existing = horseDailyData[horseName];
  if (existing != null) {
    feedingController.text = existing['feeding'] ?? '';
    foodTypeController.text = existing['foodType'] ?? '';
    mealsController.text = existing['meals'] ?? '';
    waterIntake = existing['waterIntake'] ?? false;
    waterAmountController.text = existing['waterAmount'] ?? '';
    didExercise = existing['didExercise'] ?? false;
    activityTypeController.text = existing['activityType'] ?? '';
    durationController.text = existing['duration'] ?? '';
    poopType = existing['poopType'];
    temperatureController.text = existing['temperature'] ?? '';
    appetite = existing['appetite'];
    energy = existing['energy'];
    mood = existing['mood'];
    notesController.text = existing['notes'] ?? '';
  }
}

  String? mood, appetite, energy, poopType;
  final TextEditingController feedingController = TextEditingController();
  final TextEditingController foodTypeController = TextEditingController();
  final TextEditingController mealsController = TextEditingController();
  final TextEditingController waterAmountController = TextEditingController();
  final TextEditingController activityTypeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  bool waterIntake = false;
  bool didExercise = false;

  final List<String> moodOptions = ['Calm', 'Nervous', 'Aggressive', 'Depressed', 'Excited'];
  final List<String> appetiteOptions = ['Normal', 'Low', "Didn't eat"];
  final List<String> energyOptions = ['Active', 'Lazy', 'Tired'];
  final List<String> poopOptions = ['Normal', 'Soft', 'Hard', 'Watery', "Didn't poop"];

  @override
  void dispose() {
    feedingController.dispose();
    foodTypeController.dispose();
    mealsController.dispose();
    waterAmountController.dispose();
    activityTypeController.dispose();
    durationController.dispose();
    temperatureController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Widget _buildCard({required String title, required Widget child, IconData? icon, Color? color}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color?.withOpacity(0.2) ?? Colors.grey.shade100, color ?? Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Row(children: [Icon(icon, color: color), const SizedBox(width: 8), Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color))])
          else
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  void saveDailyData() {
    final data = {
  'feeding': feedingController.text,
  'foodType': foodTypeController.text,
  'meals': mealsController.text,
  'waterIntake': waterIntake,
  'waterAmount': waterAmountController.text,
  'didExercise': didExercise,
  'activityType': activityTypeController.text,
  'duration': durationController.text,
  'poopType': poopType,
  'temperature': temperatureController.text,
  'appetite': appetite,
  'energy': energy,
  'mood': mood,
  'notes': notesController.text,
};

horseDailyData[horseName] = data;
print('Saved Daily Data for $horseName: $data');
    print('Saved Daily Data: $data');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Daily Data Saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildCard(
              title: 'Feeding',
              icon: FontAwesomeIcons.bone,
              color: Colors.orange,
              child: TextField(
                controller: feedingController,
                decoration: const InputDecoration(hintText: 'Feeding Details'),
              ),
            ),
            _buildCard(
              title: 'Food Type',
              icon: FontAwesomeIcons.carrot,
              color: Colors.green,
              child: TextField(
                controller: foodTypeController,
                decoration: const InputDecoration(hintText: 'e.g., Hay, Grains'),
              ),
            ),
            _buildCard(
              title: 'Number of Meals',
              icon: FontAwesomeIcons.utensils,
              color: Colors.deepOrange,
              child: TextField(
                controller: mealsController,
                keyboardType: TextInputType.number,
              ),
            ),
            _buildCard(
              title: 'Water Intake?',
              icon: FontAwesomeIcons.tint,
              color: Colors.blue,
              child: SwitchListTile(
                value: waterIntake,
                title: const Text('Water Intake Today'),
                onChanged: (val) => setState(() => waterIntake = val),
              ),
            ),
            _buildCard(
              title: 'Estimated Water Amount (Liters)',
              icon: FontAwesomeIcons.glassWater,
              color: Colors.cyan,
              child: TextField(
                controller: waterAmountController,
                keyboardType: TextInputType.number,
              ),
            ),
            _buildCard(
              title: 'Exercise',
              icon: FontAwesomeIcons.running,
              color: Colors.purple,
              child: SwitchListTile(
                value: didExercise,
                title: const Text('Did the horse exercise?'),
                onChanged: (val) => setState(() => didExercise = val),
              ),
            ),
            _buildCard(
              title: 'Activity Type',
              icon: FontAwesomeIcons.horse,
              color: Colors.indigo,
              child: TextField(
                controller: activityTypeController,
                decoration: const InputDecoration(hintText: 'Trot, Gallop, Walking...'),
              ),
            ),
            _buildCard(
              title: 'Duration (minutes)',
              icon: FontAwesomeIcons.clock,
              color: Colors.deepPurple,
              child: TextField(
                controller: durationController,
                keyboardType: TextInputType.number,
              ),
            ),
            _buildCard(
              title: 'Poop Type',
              icon: FontAwesomeIcons.toiletPaper,
              color: Colors.brown,
              child: DropdownButtonFormField(
                value: poopType,
                items: poopOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) => setState(() => poopType = val as String?),
              ),
            ),
            _buildCard(
              title: 'Temperature (°C)',
              icon: FontAwesomeIcons.thermometerHalf,
              color: Colors.redAccent,
              child: TextField(
                controller: temperatureController,
                keyboardType: TextInputType.number,
              ),
            ),
            _buildCard(
              title: 'Appetite',
              icon: FontAwesomeIcons.utensilSpoon,
              color: Colors.teal,
              child: DropdownButtonFormField(
                value: appetite,
                items: appetiteOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) => setState(() => appetite = val as String?),
              ),
            ),
            _buildCard(
              title: 'Energy Level',
              icon: FontAwesomeIcons.batteryHalf,
              color: Colors.lightBlue,
              child: DropdownButtonFormField(
                value: energy,
                items: energyOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) => setState(() => energy = val as String?),
              ),
            ),
            _buildCard(
              title: 'Mood',
              icon: FontAwesomeIcons.faceSmile,
              color: Colors.amber,
              child: DropdownButtonFormField(
                value: mood,
                items: moodOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) => setState(() => mood = val as String?),
              ),
            ),
            _buildCard(
              title: 'Notes',
              icon: FontAwesomeIcons.noteSticky,
              color: Colors.grey,
              child: TextField(
                controller: notesController,
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: saveDailyData,
              icon: const Icon(Icons.save,color: Colors.white,),
              label: const Text("Save",style: TextStyle(color: Colors.white),),
              
              style: ElevatedButton.styleFrom(
                backgroundColor: t1,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
