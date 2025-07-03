import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_ui_flutter/controllers/horse_controller.dart';
import 'package:login_ui_flutter/utils/constanst.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class HorseGalleryScreen extends StatefulWidget {
  final String horseName; 

  const HorseGalleryScreen({super.key, required this.horseName});

  @override
  State<HorseGalleryScreen> createState() => _HorseGalleryScreenState();
}

class _HorseGalleryScreenState extends State<HorseGalleryScreen> {
  List<String> imagePaths = [];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = '${widget.horseName}_${DateTime.now().millisecondsSinceEpoch}${extension(pickedFile.path)}';
      final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');

      setState(() {
        imagePaths.add(savedImage.path);
      });
    }
  }

  void _openImagePreview(String path) {
    Navigator.of(context as BuildContext).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title:  Text('Preview'.tr)),
          body: Center(child: Image.file(File(path))),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
final horseName = Get.find<HorseController>().selectedHorse['name'];

    return Scaffold(
      appBar: AppBar(
        
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [t1, Color(0xFFC0D6DF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text("Daily Data - $horseName"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: _pickImage,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: imagePaths.isEmpty
            ? const Center(child: Text("No photo added"))
            : GridView.builder(
                itemCount: imagePaths.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _openImagePreview(imagePaths[index]),
                    child: Image.file(
                      File(imagePaths[index]),
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
