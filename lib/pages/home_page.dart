//Home screen. Shows all available pets. Results fetched from firestore are paginated.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/pages/search_bar.dart';

import '../crud/pagination.dart';
import '../model/card.dart';
import '../model/data_model.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PaginatedResults paginatedBloc;

  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    paginatedBloc = PaginatedResults();
    paginatedBloc.fetchFirstList();
    controller.addListener(_scrollListner);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Scroll down for pets (or) Hit the search icon",
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder<List<DocumentSnapshot>>(
              stream: paginatedBloc.petStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: paginatedBloc.fetchFirstList,
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      controller: controller,
                      itemBuilder: (context, index) {
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
                                    name: snapshot.data![index]["name"],
                                    category: snapshot.data![index]["category"],
                                    age: snapshot.data![index]["age"],
                                    price: snapshot.data![index]["price"],
                                    adopted: snapshot.data![index]["adopted"],
                                    id: snapshot.data![index]["id"],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(
                                        MaterialPageRoute(
                                          builder: (context) => DetailsPage(
                                            heroId: snapshot.data![index]["id"],
                                            petType: snapshot.data![index]
                                                ["category"],
                                            petAge: snapshot.data![index]
                                                ["age"],
                                            petName: snapshot.data![index]
                                                ["name"],
                                            petPrice: snapshot.data![index]
                                                ["price"],
                                            adoptionStatus: snapshot
                                                .data![index]["adopted"],
                                          ),
                                        ),
                                      )
                                          .then((value) {
                                        paginatedBloc.fetchFirstList();
                                      });
                                    },
                                    child: const Text("View Details"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _scrollListner() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      paginatedBloc.fetchNextPets();
    }
  }
}
