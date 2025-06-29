import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:login_ui_flutter/screens/profile%20screens/horse_screen.dart';

class OcrScannerScreen extends StatefulWidget {
  const OcrScannerScreen({super.key});

  @override
  State<OcrScannerScreen> createState() => _OcrScannerScreenState();
}

class _OcrScannerScreenState extends State<OcrScannerScreen> {
  File? _image;
  final picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;

    setState(() {
      _image = File(pickedFile.path);
      _isLoading = true;
    });

    

    final inputImage = InputImage.fromFile(_image!);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    final extractedData = _extractHorseData(recognizedText.text);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Horse(
          horseName: extractedData["name"],
          gender: extractedData["gender"],
          birthDate: extractedData["birthDate"],
          breed: extractedData["breed"],
          coat: extractedData["coat"],
          countryOfBirth: extractedData["country"],
          color: extractedData["color"],
          owner: extractedData["owner"],
          nationalId: extractedData["id"],
          medicalNotes: extractedData["notes"],
          stableLocation: extractedData["stable"],
        ),
      ),
    );
  }

  // استخلاص البيانات من النص (نموذج مبسط – يمكن تطويره حسب تنسيق بياناتك)
  Map<String, String> _extractHorseData(String text) {
    final data = <String, String>{};
    final lines = text.split('\n');

    for (final line in lines) {
      if (line.toLowerCase().contains('name')) data['name'] = line.split(':').last.trim();
      if (line.toLowerCase().contains('gender')) data['gender'] = line.split(':').last.trim();
      if (line.toLowerCase().contains('birth')) data['birthDate'] = line.split(':').last.trim();
      if (line.toLowerCase().contains('breed')) data['breed'] = line.split(':').last.trim();
      if (line.toLowerCase().contains('coat')) data['coat'] = line.split(':').last.trim();
      if (line.toLowerCase().contains('country')) data['country'] = line.split(':').last.trim();
      if (line.toLowerCase().contains('color')) data['color'] = line.split(':').last.trim();
      if (line.toLowerCase().contains('owner')) data['owner'] = line.split(':').last.trim();
      if (line.toLowerCase().contains('id')) data['id'] = line.split(':').last.trim();
      if (line.toLowerCase().contains('notes')) data['notes'] = line.split(':').last.trim();
      if (line.toLowerCase().contains('stable')) data['stable'] = line.split(':').last.trim();
    }

    return data;
  }

  @override
  void initState() {
    super.initState();
    _pickImage(); // تفتح الكاميرا تلقائيًا
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : const Center(child: Text('No image selected')),
    );
  }
}
