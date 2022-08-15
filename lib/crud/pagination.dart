//Handles pagination. 15 results are pulled at a time. Can also be refreshed.

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import 'firebase_provider.dart';


class PaginatedResults {
  late FirebaseProvider firebaseProvider;

  bool showIndicator = false;
  late List<DocumentSnapshot> documentList;

  late BehaviorSubject<List<DocumentSnapshot>> petController;
  late BehaviorSubject<bool> showIndicatorController;

  PaginatedResults() {
    petController = BehaviorSubject<List<DocumentSnapshot>>();
    showIndicatorController = BehaviorSubject<bool>();
    firebaseProvider = FirebaseProvider();
  }

  Stream get getShowIndicatorStream => showIndicatorController.stream;

  Stream<List<DocumentSnapshot>> get petStream => petController;

  Future fetchFirstList() async {
    try {
      documentList = await firebaseProvider.fetchFirstList();
      petController.sink.add(documentList);
    } on SocketException {
      petController.sink
          .addError(const SocketException("No Internet Connection"));
    } catch (e) {
      petController.sink.addError(e);
    }
  }

  fetchNextPets() async {
    try {
      updateIndicator(true);
      List<DocumentSnapshot> newDocumentList =
          await firebaseProvider.fetchNextList(documentList);
      documentList.addAll(newDocumentList);
      petController.sink.add(documentList);
      try {
        if (documentList.isEmpty) {
          updateIndicator(false);
        }
      } catch (e) {
        updateIndicator(false);
        petController.sink.addError(e);
      }
    } catch (e) {
      updateIndicator(false);
      petController.sink.addError(e);
    }
  }

  updateIndicator(bool value) async {
    showIndicator = value;
    showIndicatorController.sink.add(value);
  }

  void dispose() {
    petController.close();
    showIndicatorController.close();
  }
}

// class PaginatedResults extends StatelessWidget {
//   const PaginatedResults({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: getDocId(context),
//       builder: (context, snapshot) {
//         return ListView.builder(
//           shrinkWrap: true,
//           physics: const ClampingScrollPhysics(),
//           itemCount: docIds.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: GetDetails(documentId: docIds[index]),
//               subtitle: Text("${docIds.length}"),
//             );
//           },
//         );
//       },
//     );
//   }
// }
