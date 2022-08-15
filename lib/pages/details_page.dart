//Details page: Contains interactive image viewer, a button to adopt the pet and a short description about the pet

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String heroId;
  final String petType;
  final String petName;
  final String petPrice;
  final String petAge;
  final bool adoptionStatus;
  const DetailsPage({
    Key? key,
    required this.heroId,
    required this.petType,
    required this.petAge,
    required this.petName,
    required this.petPrice,
    required this.adoptionStatus,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool disabled = false;
  final controller = ConfettiController();

  Widget conditional() {
    if (widget.adoptionStatus == true) {
      return (Text(
        "You've already adopted ${widget.petName}, please choose another pet",
        style: const TextStyle(
          fontFamily: "Roboto",
          fontStyle: FontStyle.italic,
        ),
      ));
    }
    return ElevatedButton(
      onPressed: (disabled)
          ? null
          : () {
              final update = {
                "adopted": true,
                "time": Timestamp.now(),
              };
              controller.play();
              FirebaseFirestore.instance
                  .collection("pet-details")
                  .doc(widget.heroId)
                  .set(update, SetOptions(merge: true));
              openDialog();
              setState(() {
                disabled = true;
              });
            },
      child: Text(
        "Adopt ${widget.petName}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Hero(
                    tag: widget.heroId,
                    child: InteractiveViewer(
                      child: Image(
                        image: AssetImage(
                          'images/${widget.petType}.png',
                        ),
                        height: 300,
                        // width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.black.withOpacity(0),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(2.0),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Text(
                  "Hey there! My name is ${widget.petName}, I'm a ${widget.petAge} year old pet ${widget.petType}, I like biscuits, My previous owner passed away recently, and I'm looking for a new companion. I could be your adorable pet for a price of \u20b9${widget.petPrice}/-",
                  style: const TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            conditional()
          ],
        ),
      ),
    );
  }

//Used to handle pop-up ad confetti animation
  Future openDialog() => showDialog(
        context: context,
        builder: (context) => Stack(
          alignment: Alignment.center,
          children: [
            AlertDialog(
              title: const Text("Congratulations!!!"),
              content: Text(
                "You've now adopted ${widget.petName}",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    controller.stop();
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
            ConfettiWidget(
              confettiController: controller,
              shouldLoop: false,
              blastDirection: -pi / 2,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: 0.01,
              numberOfParticles: 25,
              minBlastForce: 40,
              maxBlastForce: 75,
              gravity: 0.6,
            )
          ],
        ),
      );
}
