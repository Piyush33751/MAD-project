import 'package:flutter/material.dart';
import 'classDatabase.dart';
import 'package:table_calendar/table_calendar.dart';
import 'mapdatabse.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: CalendarPage()));
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  int selectedTab = 0;
  var y = [];
  Map<DateTime, Map<String, List<String>>> activities = {};
  Map<String, List<String>> currentDayData = {};

  List<String> tabs = ['Location', 'Description', 'Events'];
  List<IconData> tabIcons = [Icons.apartment, Icons.build, Icons.event];


  Key listKey = UniqueKey();

  void _onDaySelected(DateTime day, DateTime focusedDay) async {

    setState(() {
      today = day;
      y = []; 
      currentDayData = {}; 
      listKey = UniqueKey();
    });

    String dateString = day.toString().split(" ")[0];
    
    print("Fetching data for: $dateString");
    var data = await Reports.getdata(dateString);
    print("Data received: $data");

    if (mounted) {
      setState(() {
        y = data;
        DateTime normalizedDay = DateTime(day.year, day.month, day.day);

        if (data != null && data.isNotEmpty && data.length >= 4) {
          var newData = {
            'Location': [data[2].toString()],
            'Description': [data[3].toString()],
            'Events': [data[0].toString()],
          };
          activities[normalizedDay] = newData;
          currentDayData = newData;
        } else {
          currentDayData = {};
        }
        listKey = UniqueKey(); 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Calendar Page", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: content(),
    );
  }

  Widget content() {
    List<String> dayActivities = currentDayData[tabs[selectedTab]] ?? [];

    return SingleChildScrollView(
      child: Column(
        children: [
 
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: TableCalendar(
              firstDay: DateTime.utc(2026, 1, 1),
              lastDay: DateTime.utc(2026, 12, 31),
              focusedDay: today,
              selectedDayPredicate: (day) => isSameDay(day, today),
              onDaySelected: _onDaySelected,
              eventLoader: (day) {
                DateTime normalized = DateTime(day.year, day.month, day.day);
                return activities[normalized] != null ? ['event'] : [];
              },
              headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                todayDecoration: BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(tabs.length, (i) => Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => selectedTab = i),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: selectedTab == i ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(tabIcons[i], color: selectedTab == i ? Colors.white : Colors.grey),
                        Text(tabs[i], style: TextStyle(color: selectedTab == i ? Colors.white : Colors.grey)),
                      ],
                    ),
                  ),
                ),
              )),
            ),
          ),

          const SizedBox(height: 20),

         
          Container(
            key: listKey, 
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Activities for ${today.toString().split(" ")[0]}', 
                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                dayActivities.isEmpty
                  ? const Center(child: Text("No activities scheduled", style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dayActivities.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: const Icon(Icons.circle, size: 8, color: Colors.blue),
                        title: Text(dayActivities[index]),
                      ),
                    ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          FilledButton(
            onPressed: (y.isNotEmpty) ? () {
              Reports.loginbuild = y[7];
              Mapdatabse.loginbuild = y[7];
              Reports.TappednameEvent=y[0];
              Reports.TappedDate=y[1];
              Reports.TappedLocation=y[2];
              Reports.ImageName=y[4];
              Reports.desc = y[3];
              Reports.LAT=y[5];
              Reports.LNG=y[6];
              Navigator.pushNamed(context, '/reportdislaypage');
            } : null,
            child: const Text("Press for more details"),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}