//Custom search function to query the db for user defined search term

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/card.dart';
import '../model/data_model.dart';
import 'details_page.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_rounded),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = "";
            }
          },
          icon: const Icon(Icons.clear_rounded),
        )
      ];

  @override
  Widget buildResults(BuildContext context) {
    final Stream<QuerySnapshot> searchPets = FirebaseFirestore.instance
        .collection('pet-details')
        .where("nameSearch", arrayContains: query.toLowerCase())
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: searchPets,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              'Something went wrong',
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 32.0,
                    right: 32.0,
                  ),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Column(
                      children: [
                        PetCard(
                          pet: Pet(
                            name: data["name"],
                            category: data["category"],
                            age: data["age"],
                            price: data["price"],
                            adopted: data["adopted"],
                            id: data["id"],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                    heroId: data["id"],
                                    petType: data["category"],
                                    petAge: data["age"],
                                    petName: data["name"],
                                    petPrice: data["price"],
                                    adoptionStatus: data["adopted"],
                                  ),
                                ),
                              );
                            },
                            child: const Text("View Details"),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })
              .toList()
              .cast(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Stream<QuerySnapshot> searchPets = (query == "")
        ? FirebaseFirestore.instance
            .collection('pet-details')
            .orderBy("name")
            .snapshots()
        : FirebaseFirestore.instance
            .collection('pet-details')
            .where("nameSearch", arrayContains: query.toLowerCase())
            .snapshots();
    return StreamBuilder<QuerySnapshot>(
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

        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          heroId: data["id"],
                          petType: data["category"],
                          petAge: data["age"],
                          petName: data["name"],
                          petPrice: data["price"],
                          adoptionStatus: data["adopted"],
                        ),
                      ),
                    );
                  },
                  title: Text(data['name']),
                  subtitle: Text(data["category"]),
                );
              })
              .toList()
              .cast(),
        );
      },
    );
  }
}
