import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';


class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  var inputHDB="232";
  var blocklocationLAT={"327":1.3140313059361606,"232":1.3584854916768148};
  var blocklocationLNG={"327":103.76659589239317,"232": 103.88834160328719};
  @override
Widget build(BuildContext context) {
  return Scaffold(
   appBar: AppBar(title:Text("HDB Block ${inputHDB}"),backgroundColor: Colors.red,), 
    body:FlutterMap(
    options: MapOptions(
      initialCenter: LatLng(blocklocationLAT[inputHDB]!, blocklocationLNG[inputHDB]!), 
      initialZoom: 18,
    ),
    children: [
      
      TileLayer( // Bring your own tiles
      
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
        userAgentPackageName: 'com.HDBHelperMap.app', // Add your app identifier
        // And many more recommended properties!
      ),
      RichAttributionWidget( // Include a stylish prebuilt attribution widget that meets all requirments
        attributions: [
          TextSourceAttribution(
            'OpenStreetMap contributors',
            onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')), // (external)
          ),
          // Also add images...
        ],
      ),
      MarkerLayer(
        markers: [
       Marker(
          point: LatLng(blocklocationLAT[inputHDB]!, blocklocationLNG[inputHDB]!),
           width: 20,
          height: 20,
          child: Icon(Icons.location_on),
    ),
  ],
),
    ],
  ));
}
}



