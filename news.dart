import 'package:flutter/material.dart';
import 'classDatabase.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  var z = Reports.G;

  IconData statusdEmergency(String status) {
    if (status == 'emergency') {
      return Icons.safety_check;
    } else if (status == "semi-ugrent") {
      return Icons.punch_clock;
    }
    return Icons.emergency;
  }

  Color color(String colors) {
    if (colors == 'red') {
      return Colors.red;
    } else if (colors == 'yellow') {
      return Colors.yellow;
    }
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        leading:IconButton(
          onPressed:(){
            Reports.clear();
            Navigator.pop(context);
          },
          icon:Icon(Icons.arrow_back )
          ),

        automaticallyImplyLeading: false,
        title: const Text(
          "News Page",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: z.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),

            child: ListTile(
              leading:Container(
                width: 48,
                height: 48,
                child:Image.asset('assests/imgs/${z[index]['src']}'),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

              onTap: () async{
                Reports.TappednameEvent = z[index]['name']!;
                Reports.TappedDate = z[index]['date']!;
                Reports.TappedLocation = z[index]['location']!;
                Reports.Tappedstatus = z[index]['status']!;
                Reports.desc=await Reports.getDesrciptionByid(Reports.TappednameEvent);
                Navigator.pushNamed(context, '/reportdislaypage');
              },

              title: Text(
                z[index]['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),

              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  z[index]['date']!,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 13,
                  ),
                ),
              ),

              trailing: Icon(
                statusdEmergency(z[index]['status']!),
                color: color(z[index]['color']!),
              ),
            ),
          );
        },
      ),
    );
  }
}