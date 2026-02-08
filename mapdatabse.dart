import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'classDatabase.dart';

class Mapdatabse{
  static var desc=" ";
  static Map<String, dynamic> X={};//this is for building seperation 
  static CollectionReference hdbtomap =FirebaseFirestore.instance.collection('hdbtomap');

  static String loginbuild="";

  static Future<bool> buildingsorter()async{
    QuerySnapshot qs = await hdbtomap.get();
    for(int i=0;i<qs.docs.length;i++){
      DocumentSnapshot doc = qs.docs[i];
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>; 
      
      if(data['HDB']==loginbuild){
        X=data;
        return true;
      } 
    }
    return false;
  }
  

  static void reportslocation(){
    X={};
    X={'LAT':Reports.LAT,'LNG':Reports.LNG };
  }

}