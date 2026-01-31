import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class Reports{
  static var desc=" ";
  static var ImageName="";
  static var Z=[];
  static var G=[];
  static var X=[];//this is for building seperation 
  static CollectionReference reportnews =FirebaseFirestore.instance.collection('reportnews');

  
  static String TappednameEvent="";
  static String TappedDate="";
  static String TappedLocation="";
  static String Tappedstatus="";
  static double LAT=0;
  static double LNG=0;
  static String TappedDescription="";


  static List<dynamic> TappedCalendear=[];

  static String loginbuild="";

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

  static Future<List<dynamic>> getdata(String date)async{
    TappedCalendear.clear();
    QuerySnapshot qs = await reportnews.get();
    for(int i=0;i<qs.docs.length;i++){
      DocumentSnapshot doc = qs.docs[i];
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;   
      if(data['date']==date){
        var f=data['name']!;
        TappedCalendear.add(f);
        var g=data['date']!;
        TappedCalendear.add(g);
        var j=data['location']!;
        TappedCalendear.add(j);
        var l=data['description'];
        TappedCalendear.add(l);
        return TappedCalendear;
      }
    }
    return [];
  }

  static void checkstatus(){
    for(int i=0;i<X.length;i++){ 
      if(X[i]['status']== 'easy'){
        G.add(X[i]);
      } 
      else{
        Z.add(X[i]);
      
    }
  }
  }

  static void clear(){
    Z=[];
    G=[];
  }


  static Future<void> buildingsorter()async{
    QuerySnapshot qs = await reportnews.get();
    for(int i=0;i<qs.docs.length;i++){
      DocumentSnapshot doc = qs.docs[i];
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>; 
      
      if(data['HDB']==loginbuild){
        X.add(data);
      }
    }
  }

}