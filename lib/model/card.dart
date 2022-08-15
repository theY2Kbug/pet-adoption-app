//This file contains the framework for designing the card.

import 'package:flutter/material.dart';
import 'data_model.dart';

class PetCard extends StatelessWidget {
  final Pet pet;
  const PetCard({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Hero(
        tag: pet.id,
        child: Image(
          image: AssetImage(
            'images/${pet.category}.png',
          ),
          height: 250,
          // width: 200,
          fit: BoxFit.cover,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Row(children: [
            const Text(
              "Name: ",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              pet.name,
              style: const TextStyle(
                fontFamily: "Roboto",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          Row(children: [
            const Text(
              "Price: ",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "\u20b9${pet.price}",
              style: const TextStyle(
                fontFamily: "Roboto",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ]),
      ),
    ]);
  }
}
