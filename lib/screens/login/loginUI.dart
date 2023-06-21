import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/screens/forgotpassword/forgotPasswordUI.dart';
import 'package:project/screens/login/bloc/loginBloc.dart';
import 'package:project/screens/login/bloc/loginEvents.dart';
import 'package:project/screens/login/bloc/loginStates.dart';
import 'package:project/screens/login/repo/loginRepo.dart';
import 'package:project/screens/signup/siginupUI.dart';
import 'package:project/screens/userhome/userHomeUI.dart';
import 'package:project/widget/MainButton.dart';
import 'package:project/widget/bottom_navigation.dart';
import 'package:project/widget/textfild.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPageUI extends StatefulWidget {
  const LoginPageUI({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

TextEditingController userEmail = TextEditingController();
TextEditingController userPassword = TextEditingController();
FocusNode pwd = FocusNode();

class _LoginPageState extends State<LoginPageUI> {
  //FirebaseServices _service= new FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(LoginRepo()),
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            body: blocBody(constraints),
          );
        }
      ),
    );
  }

  Widget blocBody(BoxConstraints constraints) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoginFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          });
        }
        if (state is LoginSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            userEmail.clear();
            userPassword.clear();
          });
          return const bottomNavigation(index_color: 0);
        }
        return Scaffold(
          // backgroundColor: Colors.black,
          body: Container(
           height: constraints.maxHeight,
            width: constraints.maxWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/loginback.png' ,) ,
              fit: BoxFit.fill)
               
              //color: Color.fromARGB(255, 177, 133, 181)
               // gradient: LinearGradient(
                //    colors: [Color.fromARGB(255, 177, 133, 181),Color.fromARGB(255, 173, 108, 190), Color.fromARGB(255, 158, 88, 175)])
                    ),
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    key: Key('welcomeback'),
                    'WELCOME BACK',
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 4.0,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    key: Key('signintoyouraccount'),
                    'Please sign in to your account',
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 3.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                  const SizedBox(height: 80.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, right: 317, top: 0),
                    child: Text(
                      key: Key("emailheading"),
                      'Email',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  //
                  email(),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, right: 300, top: 0),
                    child: Text(
                      key: Key('passwordheading'),
                      'Password',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  password(),
                  const SizedBox(height: 5.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: TextButton(
                          key: const Key("forgotpasswordtext"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        const ForgotPasswordUI()));
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(height: 60.0),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          MainButton(
                            key: const Key("loginbutton"),
                            onTap: () {
                              if (userEmail.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Please enter email'),
                                      content: const Text(
                                          'Email is empty, please enter email'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Close'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                                return;
                              }
                              if (userPassword.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:
                                          const Text('Please enter password'),
                                      content: const Text(
                                          'Password is empty, please enter password'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Close'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                                // return;
                              } else {
                                BlocProvider.of<LoginBloc>(context).add(
                                    LoginButtonPressed(
                                        userEmail.text, userPassword.text));
                              }
                            },
                            btncolor: const Color.fromARGB(0, 7, 6, 6),
                            text: const Text('Log in',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          const SizedBox(height: 2.0),
                          const SizedBox(height: 0.25),
                          const SizedBox(
                            height: 5.0,
                          ),
                          TextButton(
                              key: Key("signupbutton"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            const SignUpPageUI()));
                              },
                              child: RichText(
                                  key: const Key('signuptext'),
                                  text: const TextSpan(children: [
                                    TextSpan(
                                        text: "Don't have an account? ",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromARGB(255, 138, 72, 192),)),
                                    TextSpan(
                                        text: "Sign up",
                                        style: TextStyle(
                                          color: Color(0XFF00B686),
                                          fontSize: 14.0,
                                        ))
                                  ])))
                        ],
                      )),
                ],
              )),
            ),
          ),
        );
      },
    );
  }
}

LayoutBuilder password() {
  bool showPassword = false;

  return LayoutBuilder(
    builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final containerWidth = screenWidth * 0.9;
      return Container(
        width: containerWidth,
        height: 70.0,
         padding: const EdgeInsets.symmetric(horizontal: 5.0),
        margin: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(19, 211, 209, 209),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              //width: 310.0,
              // padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return TextField(
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: pwd,
                    controller: userPassword,
                    obscureText: !showPassword,
                    style: const TextStyle(color: Colors.white),
                    // textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 3.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: Icon(
                          showPassword ? Icons.visibility : Icons.visibility_off,
                          color: showPassword ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  );
}

LayoutBuilder email() {
  return LayoutBuilder(
    builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final containerWidth = screenWidth * 0.9;
      return Container(
        width: containerWidth,
        height: 70.0,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        margin: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(19, 211, 209, 209),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: userEmail,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 3.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  prefixIcon: const Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  );
}

GoogleSignIn _googleSignIn = GoogleSignIn();
FirebaseAuth _auth = FirebaseAuth.instance;

Future<UserCredential?> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    User? user = userCredential.user;
    // Do something with the user object
    if (user != null) {
      // Navigate to the desired page
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserHomeUI()),
      );
    }
    return userCredential;
  } catch (e) {
    return null;
  }
}