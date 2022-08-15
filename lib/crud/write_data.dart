//Generate dummy data

// import 'package:flutter/material.dart';
// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../model/data_model.dart';

// List<String> names = [
//   "max",
//   "charlie",
//   "bella",
//   "poppy",
//   "daisy",
//   "buster",
//   "alfie",
//   "millie",
//   "molly",
//   "rosie",
//   "buddy",
//   "barney",
//   "lola",
//   "roxy",
//   "ruby",
//   "tilly",
//   "bailey",
//   "marley",
//   "tia",
//   "bonnie",
//   "toby",
//   "milo",
//   "archie",
//   "holly",
//   "lucy",
//   "lexi",
//   "bruno",
//   "rocky",
//   "sasha",
//   "billy",
//   "gerbil",
//   "bear",
//   "luna",
//   "oscar",
//   "jack",
//   "lady",
//   "willow",
//   "tyson",
//   "benji",
//   "jake",
//   "jess",
//   "teddy",
//   "coco",
//   "murphy",
//   "sky",
//   "honey",
//   "lilly",
//   "lily",
//   "monty",
//   "patch",
//   "rolo",
//   "harry",
//   "maisy",
//   "pippa",
//   "trixie",
//   "bruce",
//   "dexter",
//   "freddie",
//   "jasper",
//   "shadow",
//   "milly",
//   "missy",
//   "pepper",
//   "rex",
//   "sally",
//   "zeus",
//   "bobby",
//   "harvey",
//   "lucky",
//   "ollie",
//   "pip",
//   "sam",
//   "storm",
//   "amber",
//   "belle",
//   "cooper",
//   "fudge",
//   "meg",
//   "minnie",
//   "ozzy",
//   "ralph",
//   "tess",
//   "dave",
//   "diesel",
//   "george",
//   "jessie",
//   "leo",
//   "lottie",
//   "louie",
//   "prince",
//   "reggie",
//   "simba",
//   "skye",
//   "basil",
//   "betsy",
//   "chase",
//   "dolly",
//   "frankie",
//   "lulu",
//   "maggie",
// ];

// class WriteData extends StatelessWidget {
//   const WriteData({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () {
//           sendData();
//         },
//         child: const Text("Send data"),
//       ),
//     );
//   }

//   Future sendData() async {
//     Random rand = Random();
//     int min_price = 2000, max_price = 22000;
//     int min_age = 1, max_age = 16;
//     for (var name in names) {
//       List<String> name_search = [];
//       String category = "";
//       for (var i = 1; i < name.length + 1; i++) {
//         name_search.add(name.substring(0, i));
//       }
//       for (var i = 0; i < 3; i++) {
//         final document =
//             FirebaseFirestore.instance.collection("pet-details").doc();
//         category = (i == 0)
//             ? "dog"
//             : (i == 1)
//                 ? "cat"
//                 : "bird";
//         num price = min_price + rand.nextInt(max_price - min_price);
//         price = price - (price % 1000);
//         num age = min_age + rand.nextInt(max_age - min_age);
//         final pet = Pet(
//           name: name,
//           category: category,
//           age: "$age",
//           price: "$price",
//           adopted: false,
//           nameSearch: name_search,
//         );
//         final json = pet.toJson();
//         await document.set(json);
//       }
//     }
//   }
// }
