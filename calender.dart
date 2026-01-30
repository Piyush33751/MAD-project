import 'package:flutter/material.dart';
import 'package:hello_world/classDatabase.dart';
import 'package:table_calendar/table_calendar.dart';

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

  Map<DateTime, Map<String, List<String>>> activities = {};
  var x="";
  var y=[];
  var date=[];


  List<String> tabs = ['Location', 'Description', 'Events'];
  List<IconData> tabIcons = [Icons.apartment, Icons.build, Icons.event];

  void _onDaySelected(DateTime day, DateTime focusedDay) async{
  setState(() {
    today = day;
  });
  

   x = day.toString().split(" ")[0];  // "2026-01-29"
   y=await Reports.getdata(x);
   date=y[1].split("-");
   activities = {
    DateTime(int.parse(date[0]),int.parse(date[1]),int.parse(date[2])): {
      'Location': [y[2]],
      'Description': [y[3]],
      'Events':[y[0]],
    },
  };
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Calendar Page",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: content(),
    );
  }

  Widget content() {
    DateTime normalizedDate = DateTime(today.year, today.month, today.day);
    List<String> dayActivities =
        activities[normalizedDate]?[tabs[selectedTab]] ?? [];

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Location Schedule for ${today.toString().split(" ")[0]}",
                  ),
                ),
                TableCalendar(
                  locale: "en_US",
                  rowHeight: 55,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  focusedDay: today,
                  firstDay: DateTime.utc(2026, 1, 1),
                  lastDay: DateTime.utc(2026, 12, 31),
                  onDaySelected: _onDaySelected,
                  eventLoader: (day) {
                    
                    DateTime normalized =
                        DateTime(day.year, day.month, day.day);
                    return activities[normalized] != null ? ['event'] : [];
                  },
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                for (int i = 0; i < tabs.length; i++)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = i;
                        });

                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: selectedTab == i ? Colors.blue : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              tabIcons[i],
                              color:
                                  selectedTab == i ? Colors.white : Colors.grey,
                              size: 24,
                            ),
                            SizedBox(height: 6),
                            Text(
                              tabs[i],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: selectedTab == i
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(tabIcons[selectedTab], color: Colors.blue, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Activities for ${today.toString().split(" ")[0]}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                dayActivities.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.event_busy,
                                size: 48,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 12),
                              Text(
                                'No activities scheduled',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: dayActivities.length,
                        separatorBuilder: (context, index) =>
                            Divider(height: 1),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    dayActivities[index],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
          SizedBox(height: 20),

          FilledButton(
            onPressed:(){
              Reports.desc=y[3];
              Navigator.pushNamed(context,'/reportdislaypage');
            }, 
            child: const Text("Press for more details")),
            
        ],
      ),
    );
  }
}