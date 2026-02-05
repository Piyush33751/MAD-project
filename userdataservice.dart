import 'userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataService {
  static String name = "";
  static String email = "";
  static String password = "";
  static String nric = "";
  static String Blkno = "";
  static List<User> z = [];

  static CollectionReference userData =
      FirebaseFirestore.instance.collection('userdata');
  static int getCount() {
    return (z.length);
  }

  static void addUser(String userName, String userEmail, String userPassword,
      String userNric, String userBlkno) async {
    z.add(User(userName, userEmail, userPassword, userNric, userBlkno));
    final DocumentReference dr = await userData.add({
      'name': userName,
      'email': userEmail,
      'password': userPassword,
      'nric': userNric,
      'blkno': userBlkno,
    });
  }

  static User getUserAt(int index) {
    return (z[index]);
  }

  static User? getUserByArtId(String id) {
    for (int i = 0; i < z.length; i++) {
      if (z[i].email == email) {
        return z[i];
      }
    }
    return null;
  }

  static Future<void> getAllUser() async {
    z.clear();
    QuerySnapshot qs = await userData.get();
    for (int i = 0; i < qs.docs.length; i++) {
      DocumentSnapshot doc = qs.docs[i];
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      z.add(User(data['name'], data['email'], data['password'], data['nric'],
          data['blkno']));
    }
  }
}
