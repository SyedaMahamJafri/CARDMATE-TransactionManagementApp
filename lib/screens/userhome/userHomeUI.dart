import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/screens/add/bloc/addBloc.dart';
import 'package:project/screens/add/bloc/addEvents.dart';
import 'package:project/screens/add/bloc/addStates.dart';
import 'package:project/screens/add/repo/addRepo.dart';
import 'package:project/screens/login/loginUI.dart';
import 'package:project/screens/userhome/bloc/userHomeBloc.dart';
import 'package:project/screens/userhome/bloc/userHomeEvents.dart';
import 'package:project/screens/userhome/bloc/userHomeStates.dart';
import 'package:project/screens/userhome/repo/userHomeRepo.dart';
import 'package:project/widget/navigationbar.dart';
import 'package:provider/provider.dart';

import '../../const/provider/dark_theme_provider.dart';

List<String> list = <String>['One', 'Two', 'Three', 'Four'];
bool found = false;

class UserHomeUI extends StatefulWidget {
  @override
  State<UserHomeUI> createState() => _UserHomeUIState();
}

class _UserHomeUIState extends State<UserHomeUI> {
  User user = FirebaseAuth.instance.currentUser!;

  String dropdownValue = list.first;

  get index => null;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserHomeBloc>(
          create: (BuildContext context) => UserHomeBloc(UserHomeRepository()),
        ),
        BlocProvider<AddBloc>(
          create: (BuildContext context) => AddBloc(AddRepository()),
        ),
      ],
      child: LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          body: blocBody(constraints),
        );
      }),
    );
  }

  Widget blocBody(BoxConstraints constraints) {
        final themeState = Provider.of<DarkThemeProvider>(context);
    return BlocProvider(
      create: (context) => UserHomeBloc(
        UserHomeRepository(),
      )..add(FetchDataEvent()),
      child:
          BlocBuilder<UserHomeBloc, UserHomeState>(builder: (context, state) {
        if (state is UserHomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserHomeFailure) {
          return Center(child: Text(state.errorMessage));
        } else if (state is UserHomeSuccess) {
          return Scaffold(   
            drawer: const SideBar(),
            //  backgroundColor: Colors.white,
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      //height: constraints.maxHeight,
                      //width: constraints.maxWidth,
                      height: 350,
                      child: _head(state, context),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transaction History',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 15,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: BlocBuilder<AddBloc, AddState>(
                      builder: (context, state) {
                        if (state is InitalState) {
                          found = true;
                          BlocProvider.of<AddBloc>(context)
                              .add(GetTransactions());
                        }
                        if (state is LoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is AddErrorState) {
                          return Center(child: Text(state.message));
                        } else if (state is LoadedState && found == true) {
                          if (state.add.length == 0) {
                            return Center(
                              child: SizedBox(
                                height: 250,
                                child: Image.asset(
                                  "assets/images/Found_nothing.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.add.length,
                            itemBuilder: (context, index) {
                              final item = state.add[index];
                              return ListTile(
                                leading: ClipRect(
                                  child: Image.asset(
                                    'assets/images/${item.selectedItem!}.png',
                                    height: 40,
                                  ),
                                ),
                                title: Text(
                                  item.selectedCard!,
                                  style: const TextStyle(
                                   
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  item.explanation,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: Text(
                                  item.amountTransacted as String,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19,
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      }),
    );
  }

  Widget _head(UserHomeSuccess state, BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Stack(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                  height: 250,
                  width: 500,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 169, 145, 182),
                        Color.fromARGB(255, 160, 123, 165),
                        Color.fromARGB(255, 144, 116, 168),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Column(
                      children: [
                       
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Available Balance',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPageUI()),
                                  (route) => false,
                                );
                              },
                              icon: Icon(Icons.logout),
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 250, 188, 103),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.1),
                                      blurRadius: 8,
                                      spreadRadius: 3,
                                    )
                                  ],
                                  border: Border.all(
                                    width: 1.5,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(40.0)),
                              padding: const EdgeInsets.all(5.0),
                              child: CircleAvatar(
                                backgroundImage: state.user.gender == 'male'
                                    ? const NetworkImage(
                                        'https://cdn.vectorstock.com/i/1000x1000/16/88/bearded-man-face-avatar-happy-smiling-male-vector-46221688.webp')
                                    : NetworkImage(
                                        'https://cdn5.vectorstock.com/i/1000x1000/01/69/businesswoman-character-avatar-icon-vector-12800169.jpg'),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "User ID: ${state.user.uid}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Name: ${state.user.firstName} ${state.user.lastName}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Phone No: ${state.user.phonenumber} ",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Gender: ${state.user.gender} ",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
        Positioned(
            top: 190,
            left: 37,
            child: Container(
              height: 150,
              width: 320,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(47, 125, 121, 0.3),
                      offset: Offset(0, 6),
                      blurRadius: 12,
                      spreadRadius: 6,
                    )
                  ],
                  color: Color.fromARGB(255, 163, 149, 190),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Total Balance',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('\$ ${state.user.balance}',
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor:
                                  Color.fromARGB(255, 85, 145, 141),
                              child: Icon(Icons.arrow_upward,
                                  color: Colors.white, size: 19),
                            ),
                            SizedBox(width: 7),
                            Text('Expenses',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 216, 216, 216))),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('\$${state.user.expense}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }
}

Container buildActivity(
    IconData icon, String title, Color backgroundColor, Color iconColor) {
  return Container(
    height: 90,
    width: 90,
    decoration: BoxDecoration(
        color: backgroundColor, borderRadius: BorderRadius.circular(10)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        icon,
        color: iconColor,
      ),
      const SizedBox(
        height: 5,
      ),
      TextButton(
          onPressed: () {},
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.black54, fontWeight: FontWeight.bold),
          ))
    ]),
  );
}
