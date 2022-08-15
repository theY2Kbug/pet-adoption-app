//Snippet to fetch data from firestore for pagination
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider {
  Future<List<DocumentSnapshot>> fetchFirstList() async {
    return (await FirebaseFirestore.instance
            .collection("pet-details")
            .limit(15)
            .get())
        .docs;
  }

  Future<List<DocumentSnapshot>> fetchNextList(
      List<DocumentSnapshot> documentList) async {
    return (await FirebaseFirestore.instance
            .collection("pet-details")
            .startAfterDocument(documentList[documentList.length - 1])
            .limit(15)
            .get())
        .docs;
  }
}
