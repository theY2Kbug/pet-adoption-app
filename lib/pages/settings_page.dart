//Settings page to switch between light and dark mode

import 'package:flutter/material.dart';
import 'package:pet_adoption_app/model/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            fontFamily: "Roboto",
          ),
        ),
      ),
      body: Transform.scale(
        scale: 1.5,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Dark Mode:"),
              Consumer<ThemeProvider>(
                builder: (context, provider, child) {
                  return Switch(
                    value: provider.currentTheme,
                    onChanged: (newTheme) {
                      provider.changeTheme(newTheme);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
