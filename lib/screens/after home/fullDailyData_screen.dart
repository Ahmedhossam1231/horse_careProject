import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_ui_flutter/controllers/horse_controller.dart';

class FullDailyDataScreen extends StatefulWidget {
  const FullDailyDataScreen({super.key});

  @override
  State<FullDailyDataScreen> createState() => _FullDailyDataScreenState();
}

class _FullDailyDataScreenState extends State<FullDailyDataScreen> {
  final horseController = Get.find<HorseController>();

  final TextEditingController feedingController = TextEditingController();
  final TextEditingController foodTypeController = TextEditingController();
  final TextEditingController mealsController = TextEditingController();
  final TextEditingController waterAmountController = TextEditingController();
  final TextEditingController activityTypeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String? mood, appetite, energy, poopType;
  bool waterIntake = false;
  bool didExercise = false;

  final List<String> moodOptions = ['Calm', 'Nervous', 'Aggressive', 'Depressed', 'Excited'];
  final List<String> appetiteOptions = ['Normal', 'Low', "Didn't eat"];
  final List<String> energyOptions = ['Active', 'Lazy', 'Tired'];
  final List<String> poopOptions = ['Normal', 'Soft', 'Hard', 'Watery', "Didn't poop"];

  @override
  void initState() {
    super.initState();

    final data = horseController.getDailyDataForSelectedHorse();

    if (data.isNotEmpty) {
      feedingController.text = data['feeding'] ?? '';
      foodTypeController.text = data['foodType'] ?? '';
      mealsController.text = data['meals'] ?? '';
      waterIntake = data['waterIntake'] ?? false;
      waterAmountController.text = data['waterAmount'] ?? '';
      didExercise = data['didExercise'] ?? false;
      activityTypeController.text = data['activityType'] ?? '';
      durationController.text = data['duration'] ?? '';
      poopType = data['poopType'];
      temperatureController.text = data['temperature'] ?? '';
      appetite = data['appetite'];
      energy = data['energy'];
      mood = data['mood'];
      notesController.text = data['notes'] ?? '';
    }
  }

  void saveDailyData() {
    final newData = {
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

    horseController.saveDailyDataForSelectedHorse(newData);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Daily Data Saved')),
    );
  }

  Widget _buildCard({
    required String title,
    required Widget child,
    Color? color,
    IconData? icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color?.withOpacity(0.07) ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color),
                ),
              ],
            )
          else
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    final selected = horseController.selectedHorse;
    final horseName = selected['name'] ?? 'Selected Horse';

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: Text("$horseName - Daily Data"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            _buildCard(
              title: 'Feeding',
              icon: Icons.restaurant,
              color: Colors.orange,
              child: TextField(controller: feedingController, decoration: const InputDecoration(hintText: 'Feeding Details')),
            ),
            _buildCard(
              title: 'Food Type',
              icon: Icons.agriculture,
              color: Colors.green,
              child: TextField(controller: foodTypeController, decoration: const InputDecoration(hintText: 'Hay, Grains, etc')),
            ),
            _buildCard(
              title: 'Number of Meals',
              icon: Icons.food_bank,
              color: Colors.deepOrange,
              child: TextField(controller: mealsController, keyboardType: TextInputType.number),
            ),
            _buildCard(
              title: 'Water Intake',
              icon: Icons.water_drop,
              color: Colors.blue,
              child: SwitchListTile(
                value: waterIntake,
                title: const Text('Water Intake Today'),
                onChanged: (val) => setState(() => waterIntake = val),
              ),
            ),
            _buildCard(
              title: 'Water Amount (Liters)',
              icon: Icons.local_drink,
              color: Colors.cyan,
              child: TextField(controller: waterAmountController, keyboardType: TextInputType.number),
            ),
            _buildCard(
              title: 'Exercise',
              icon: Icons.directions_run,
              color: Colors.purple,
              child: SwitchListTile(
                value: didExercise,
                title: const Text('Did the horse exercise?'),
                onChanged: (val) => setState(() => didExercise = val),
              ),
            ),
            _buildCard(
              title: 'Activity Type',
              icon: Icons.directions_walk,
              color: Colors.indigo,
              child: TextField(controller: activityTypeController, decoration: const InputDecoration(hintText: 'Trot, Gallop...')),
            ),
            _buildCard(
              title: 'Duration (min)',
              icon: Icons.timer,
              color: Colors.deepPurple,
              child: TextField(controller: durationController, keyboardType: TextInputType.number),
            ),
            _buildCard(
              title: 'Poop Type',
              icon: Icons.wc,
              color: Colors.brown,
              child: DropdownButtonFormField(
                value: poopType,
                items: poopOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) => setState(() => poopType = val as String?),
              ),
            ),
            _buildCard(
              title: 'Temperature (°C)',
              icon: Icons.thermostat,
              color: Colors.red,
              child: TextField(controller: temperatureController, keyboardType: TextInputType.number),
            ),
            _buildCard(
              title: 'Appetite',
              icon: Icons.soup_kitchen,
              color: Colors.teal,
              child: DropdownButtonFormField(
                value: appetite,
                items: appetiteOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) => setState(() => appetite = val as String?),
              ),
            ),
            _buildCard(
              title: 'Energy',
              icon: Icons.bolt,
              color: Colors.amber,
              child: DropdownButtonFormField(
                value: energy,
                items: energyOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) => setState(() => energy = val as String?),
              ),
            ),
            _buildCard(
              title: 'Mood',
              icon: Icons.mood,
              color: Colors.lightBlue,
              child: DropdownButtonFormField(
                value: mood,
                items: moodOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) => setState(() => mood = val as String?),
              ),
            ),
            _buildCard(
              title: 'Notes',
              icon: Icons.notes,
              color: Colors.grey,
              child: TextField(controller: notesController, maxLines: 3),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: saveDailyData,
              icon: const Icon(Icons.save),
              label: const Text("Save"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
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
