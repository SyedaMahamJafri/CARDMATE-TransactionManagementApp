import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/const/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(

      body: Center(
        child: SwitchListTile(
          title: Text('Theme'),
          secondary: Icon(themeState.getdarkTheme
              ? Icons.dark_mode_outlined
              : Icons.light_mode_outlined,
              color: Colors.white,
            ),
         
          onChanged: (bool value) {
            setState(() {
                themeState.setdarkTheme = value;
            });
          
          },
          value: themeState.getdarkTheme,
        ),
      ),
    );
  }
}
