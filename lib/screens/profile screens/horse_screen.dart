import 'package:flutter/material.dart';
import 'package:login_ui_flutter/utils/constanst.dart';

class Horse extends StatefulWidget {
  final String? horseName;
  final String? gender,
      birthDate,
      breed,
      coat,
      medicalNotes,
      countryOfBirth,
      color,
      owner,
      nationalId,
      stableLocation;

  const Horse({
    Key? key,
    this.horseName,
    this.gender,
    this.birthDate,
    this.breed,
    this.coat,
    this.medicalNotes,
    this.countryOfBirth,
    this.color,
    this.owner,
    this.nationalId,
    this.stableLocation,
  }) : super(key: key);

  @override
  _HorseState createState() => _HorseState();
}
final Map<String, Map<String, dynamic>> horseDailyData = {};


class _HorseState extends State<Horse> with SingleTickerProviderStateMixin {
  late TextEditingController nameController;
  TextEditingController genderController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController breedController = TextEditingController();
  TextEditingController coatController = TextEditingController();
  TextEditingController medicalNotesController = TextEditingController();
  TextEditingController countryOfBirthController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController ownerController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController stableLocationController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.horseName ?? "");
    genderController.text = widget.gender ?? "";
    birthDateController.text = widget.birthDate ?? "";
    breedController.text = widget.breed ?? "";
    coatController.text = widget.coat ?? "";
    medicalNotesController.text = widget.medicalNotes ?? "";
    countryOfBirthController.text = widget.countryOfBirth ?? "";
    colorController.text = widget.color ?? "";
    ownerController.text = widget.owner ?? "";
    nationalIdController.text = widget.nationalId ?? "";
    stableLocationController.text = widget.stableLocation ?? "";

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    birthDateController.dispose();
    breedController.dispose();
    coatController.dispose();
    medicalNotesController.dispose();
    countryOfBirthController.dispose();
    colorController.dispose();
    ownerController.dispose();
    nationalIdController.dispose();
    stableLocationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [t1, Color(0xFFC0D6DF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          widget.horseName != null ? "Horse Profile" : "Add New Horse",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
              colors: [t1, Color(0xFFC0D6DF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: size.height * 0.06)),
                SliverToBoxAdapter(
                  child: Center(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Container(
                          width: size.width * 0.25,
                          height: size.width * 0.25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              )
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              // TODO: add camera or gallery picker
                            },
                            icon: Icon(
                              Icons.camera_alt_rounded,
                              size: size.width * 0.15,
                              color: Colors.teal.shade700,
                            ),
                            splashRadius: 35,
                            tooltip: "Upload Horse Image",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: SizedBox(height: size.height * 0.045)),
                DetailsWidget(
                  details: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildField('Name', nameController),
                      buildField('Gender', genderController),
                      buildField('Date of Birth', birthDateController),
                      buildField('Country of Birth', countryOfBirthController),
                      buildField('Color', colorController),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                    child: SizedBox(height: size.height * 0.025)),
                DetailsWidget(
                  details: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildField('Breed', breedController),
                      buildField('Owner', ownerController),
                      buildField('National ID', nationalIdController),
                      buildField(
                          'Medical or Health Notes', medicalNotesController),
                      buildField('Stable Location', stableLocationController),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 120)),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 28,
            right: 28,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.shade100,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    elevation: 4,
                    shadowColor: Colors.redAccent.shade200,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    String horseName = nameController.text.trim();
                    if (horseName.isNotEmpty) {
                      Navigator.pop(context, horseName); // يرجّع الاسم للـ Home
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please enter the horse name")),
                      );
                    }
                  },
                  child: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    elevation: 6,
                    shadowColor: Colors.tealAccent.shade400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildField(String header, TextEditingController controller) {
    return DetailItem(
      header: header,
      child: Focus(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter $header',
            hintStyle: const TextStyle(color: Colors.white70),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.teal.withOpacity(0.3),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          ),
          cursorColor: Colors.teal.shade900,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        onFocusChange: (hasFocus) {
          setState(() {}); // to update UI on focus change if needed
        },
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  const DetailItem({
    Key? key,
    required this.header,
    required this.child,
  }) : super(key: key);

  final String header;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(
              color: Colors.teal,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({Key? key, required this.details}) : super(key: key);

  final Widget details;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.teal.shade200.withOpacity(0.85),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.shade100.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: details,
      ),
    );
  }
}
