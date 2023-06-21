import 'package:flutter/material.dart';
import 'package:project/screens/add/addUI.dart';
import 'package:project/screens/card/cardUI.dart';
import 'package:project/screens/profile/profile.dart';
import 'package:project/screens/update/updateUI.dart';
import 'package:project/screens/userhome/userHomeUI.dart';
import 'package:provider/provider.dart';

import '../const/provider/dark_theme_provider.dart';

class bottomNavigation extends StatefulWidget {
  final int index_color;
  const bottomNavigation({Key? key, required this.index_color})
      : super(key: key);

  @override
  State<bottomNavigation> createState() => _bottomNavigationState();
}

class _bottomNavigationState extends State<bottomNavigation> {
  int indexColor = 0;
  List<Widget> screens = [
    UserHomeUI(),
    const MyCards(),
    const UpdateUI(),
  //  const Profile()
  ];

  @override
  void initState() {
    super.initState();
    indexColor = widget.index_color;
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: indexColor,
            children: screens,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 60,
               
                color: Color.fromARGB(255, 163, 149, 190),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        indexColor = 0;
                      });
                    },
                    icon: Icon(
                      Icons.home,
                      size: 30,
                      color: indexColor == 0
                          ? Color.fromARGB(255, 234, 167, 210)
                          : Colors.white
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        indexColor = 1;
                      });
                    },
                    icon: Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 30,
                      color: indexColor == 1
                          ? Color.fromARGB(255, 234, 167, 210)
                          : Colors.white
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        indexColor = 2;
                      });
                    },
                    icon: Icon(
                      Icons.person_outlined,
                      size: 30,
                      color: indexColor == 2
                          ? Color.fromARGB(255, 234, 167, 210)
                          : Colors.white
                    ),
                  ),
                 
                ],
                
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment(0, 0.87),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => const Add()),
            );
          },
          child: const Icon(Icons.add),
          backgroundColor: Color.fromARGB(255, 163, 149, 190),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
