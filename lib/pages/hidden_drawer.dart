//Backbone of the entire app. Users can switch between three tabs - Home, Adoption history and settings page

import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:pet_adoption_app/pages/home_page.dart';
import 'package:pet_adoption_app/pages/settings_page.dart';
import 'package:pet_adoption_app/pages/adopted_pets.dart';

// import '../crud/write_data.dart';
// import 'package:pet_adoption_app/pages/write_data.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  final baseTextStyle = const TextStyle(
    fontFamily: "Roboto",
    // fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Colors.black87,
  );

  final selectedTextStyle = const TextStyle(
    fontFamily: "Roboto",
    // fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    fontSize: 24,
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Available \nPets",
          baseStyle: baseTextStyle,
          selectedStyle: selectedTextStyle,
          colorLineSelected: Colors.blue.shade700,
        ),
        const HomePage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Adoption \nHistory",
          baseStyle: baseTextStyle,
          selectedStyle: selectedTextStyle,
          colorLineSelected: Colors.blue.shade700,
        ),
        const AdoptedPage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Settings",
          baseStyle: const TextStyle(
            fontFamily: "Roboto",
            // fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          selectedStyle: const TextStyle(
            fontFamily: "Roboto",
            fontStyle: FontStyle.italic,
            fontSize: 24,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          colorLineSelected: Colors.blue.shade700,
        ),
        const SettingsPage(),
      ),
      // ScreenHiddenDrawer(
      //   ItemHiddenMenu(
      //     name: "Write",
      //     baseStyle: const TextStyle(
      //       fontFamily: "Roboto",
      //       fontWeight: FontWeight.bold,
      //       fontSize: 20,
      //       color: Color.fromARGB(255, 95, 95, 95),
      //     ),
      //     selectedStyle: const TextStyle(
      //       fontFamily: "Roboto",
      //       fontWeight: FontWeight.w600,
      //       fontSize: 24,
      //       color: Color.fromARGB(255, 95, 95, 95),
      //     ),
      //     colorLineSelected: Colors.blue.shade700,
      //   ),
      //   const WriteData(),
      // ),
    ];
  }

  // Future<void> initTheme() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool("setDarkMode", false);
  // }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: _pages,
      backgroundColorMenu: (Theme.of(context).brightness == Brightness.light)
          ? Colors.orangeAccent
          : Colors.deepPurpleAccent,
      initPositionSelected: 0,
      slidePercent: 60.0,
      contentCornerRadius: 25.0,
      tittleAppBar: const Text("Adopt-me app"),
    );
  }
}
