//History page. Data (adopted status - true) from cloud firestore is fetched and chronologically sorted (Descending order - Most recent adopted pet is shown on top of the list). 

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdoptedPage extends StatefulWidget {
  const AdoptedPage({Key? key}) : super(key: key);

  @override
  State<AdoptedPage> createState() => _AdoptedPageState();
}

class _AdoptedPageState extends State<AdoptedPage> {
  final Stream<QuerySnapshot> searchPets = FirebaseFirestore.instance
      .collection('pet-details')
      .orderBy("time", descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Past Adoptions",
          style: TextStyle(
            fontFamily: "Roboto",
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: searchPets,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text(
              'Something went wrong',
            ));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No pets adopted!"),
            );
          }

          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    title: Text("Name: ${data['name']}"),
                    subtitle: Text("Adopted time: ${data["time"].toDate()}"),
                  );
                })
                .toList()
                .cast(),
          );
        },
      ),
    );
  }
}
