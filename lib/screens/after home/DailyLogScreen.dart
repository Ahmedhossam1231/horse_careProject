import 'package:flutter/material.dart';

class DailyLogScreen extends StatefulWidget {
  const DailyLogScreen({super.key});

  @override
  State<DailyLogScreen> createState() => _DailyLogScreenState();
}

class _DailyLogScreenState extends State<DailyLogScreen> {
  final TextEditingController foodController = TextEditingController();
  final TextEditingController exerciseController = TextEditingController();
  final TextEditingController healthController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  void dispose() {
    foodController.dispose();
    exerciseController.dispose();
    healthController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Horse data"),
        backgroundColor: Colors.teal[700],
        elevation: 0,
      ),
      body: Container(
        color: Colors.teal[50],
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ListView(
          children: [
            buildInputField("feeding", foodController),
            buildInputField("The exercises", exerciseController),
            buildInputField("The health condition", healthController),
            buildInputField("Other notes", notesController, maxLines: 4),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // TODO: Save data logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم حفظ البيانات")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[700],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text("save",style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.teal),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.teal.shade700, width: 2),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
