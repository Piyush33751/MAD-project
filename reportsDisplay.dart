import 'package:flutter/material.dart';
import 'package:hello_world/mapdatabse.dart';
import 'classDatabase.dart';

class reportDipslay extends StatefulWidget {
  const reportDipslay({super.key});

  @override
  State<reportDipslay> createState() => _reportDipslayState();
}

class _reportDipslayState extends State<reportDipslay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // light background

      appBar: AppBar(
        title: Text(
          Reports.TappednameEvent,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

           
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
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

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Section title
                    const Text(
                      "Additional Details For Residents:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2F80ED),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Description text
                    Text(
                      '${Reports.desc}',
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height:12),
                    FilledButton(onPressed: (){
                      Mapdatabse.reportslocation();
                      Navigator.pushNamed(context,'/map');
                    }, child: Text("Location On Map"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
