import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:project/widget/MainButton.dart';
import 'package:project/widget/textfild.dart';

class ForgotPasswordUI extends StatefulWidget {
  const ForgotPasswordUI({
    Key? key,
  }) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordUI> {
  final auth = FirebaseAuth.instance;
  TextEditingController userEmail = TextEditingController();
  @override
  Widget build(BuildContext content) {
    return LayoutBuilder(
      builder: (context, constraints) {
         final screenHeight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;
        return Scaffold(    
           backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            body: Container( 
              height: screenHeight,
                width: screenWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
            children: [
            SizedBox(
              child: Image.asset(
                "assets/images/fp.png",
                fit: BoxFit.cover,
               ),
            ),
             SizedBox(
              height: 20
                ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 0, top: 0),
              child: Text(
                key: Key('sendrequest'),
                'Forgot Password',
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 4.0,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
             SizedBox(
              height: 20,
                  width: screenWidth,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 0, top: 0),
              child: Text(
                key: Key('emailheading'),
                'Email',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            textfild(
              const Text(
                key: Key('emailhinttext'),
                'UserEmail',
                style: TextStyle(color: Colors.black),
              ),
              const Icon(
                Icons.mail,
                color: Color.fromARGB(255, 191, 163, 201),
              ),
              Color(0XFF00B686),
              userEmail,
              TextInputType.emailAddress,
              Key("forgotpasswordtextfield"),
            ),
            const SizedBox(
              height: 15.0,
            ),
            MainButton(
              key: Key('sendrequest'),
              onTap: () {
                auth
                    .sendPasswordResetEmail(email: userEmail.text)
                    .then((value) {
                  if (userEmail.text == null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Email Field is empty'),
                          content: const Text(
                              'Please enter a valid email address to receive the recovery email'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Continue'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Recovery Email Sent!'),
                          content: const Text(
                              'The email to recover the password has been sent. Please check your email.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                }).onError((error, stackTrace) {
                  print("Email :  ${error.toString()}");
                });
              },
              btncolor: const Color.fromARGB(0, 7, 6, 6),
              text: const Text('Send Request',
              style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        )),
            ),
              ]),
            ));
      }
    );
  }
}
