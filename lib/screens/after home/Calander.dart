import 'package:flutter/material.dart';
import 'package:login_ui_flutter/controllers/horse_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Simulate data loaded for specific horses:
  final Map<String, List<DateTime>> horseDataMap = {
    'Horse1': [
      DateTime.now().subtract(const Duration(days: 1)),
      DateTime.now().add(const Duration(days: 1)),
    ],
    'Horse2': [
      DateTime.now().subtract(const Duration(days: 2)),
    ],
  };

  bool _hasDataForSelectedHorse(DateTime day, String horseName) {
    return horseDataMap[horseName]?.any((d) => isSameDay(d, day)) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final horseName = Get.find<HorseController>().selectedHorse.value;

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: FadeInRight(child: Text('calendar'.tr)),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Column(
        children: [
          Text("Calendar for $horseName", style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          FadeInDown(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  Get.to(() => DailyDataDetailScreen(date: selectedDay));
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.orange.shade700,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.orange.shade300,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    if (_hasDataForSelectedHorse(day, horseName)) {
                      return Positioned(
                        bottom: 1,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FadeInUp(
            child: Text(
              _selectedDay != null
                  ? '${'selected_date'.tr}: ${_selectedDay!.toLocal().toString().split(' ')[0]}'
                  : 'select_date_msg'.tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class DailyDataDetailScreen extends StatelessWidget {
  final DateTime date;

  const DailyDataDetailScreen({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horseName = Get.find<HorseController>().selectedHorse.value;

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text('${'data_for'.tr} $horseName - ${date.toLocal().toString().split(' ')[0]}'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          'data_preview'.tr,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
