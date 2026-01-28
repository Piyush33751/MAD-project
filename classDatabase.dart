import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class Reports{
  static var desc="Nigger";
  static var Z=[];
  static var G=[];
  static CollectionReference reportnews =FirebaseFirestore.instance.collection('reportnews');
  
  static String TappednameEvent="";
  static String TappedDate="";
  static String TappedLocation="";
  static String Tappedstatus="";

  static String TappedDescription="";

  static Future<String> getDesrciptionByid(String id)async{
    QuerySnapshot qs = await reportnews.get();
    for(int i=0;i<qs.docs.length;i++){
      DocumentSnapshot doc = qs.docs[i];
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;   
      if(data['name']==id){
        TappedDescription=data['description']!;
        return TappedDescription;
      }
    }
    return "";
  }

  static Future<void> checkstatus()async{
    QuerySnapshot qs = await reportnews.get();
    for(int i=0;i<qs.docs.length;i++){
      DocumentSnapshot doc = qs.docs[i];
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;   
      if(data['status']== 'easy'){
        G.add(data);
      } 
      else{
        Z.add(data);
      }
    }
  }

  static void clear(){
    Z=[];
    G=[];
  }

}