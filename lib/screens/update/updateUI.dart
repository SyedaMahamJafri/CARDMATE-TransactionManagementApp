import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/screens/login/loginUI.dart';
import 'package:project/screens/update/bloc/updateBloc.dart';
import 'package:project/screens/update/bloc/updateEvents.dart';
import 'package:project/screens/update/bloc/updateStates.dart';
import 'package:project/screens/update/model/updateModel.dart';
import 'package:project/screens/update/repo/updateRepo.dart';
import 'package:project/widget/MainButton.dart';
import 'package:project/widget/bottom_navigation.dart';
import 'package:provider/provider.dart';

import '../../const/provider/dark_theme_provider.dart';

class UpdateUI extends StatefulWidget {
  const UpdateUI({super.key});

  @override
  State<UpdateUI> createState() => _UpdateState();
}

class _UpdateState extends State<UpdateUI> {
  final TextEditingController FirstName = TextEditingController();
  FocusNode first = FocusNode();
  final TextEditingController LastName = TextEditingController();
  FocusNode last = FocusNode();
  final TextEditingController Email = TextEditingController();
  FocusNode email = FocusNode();
  final TextEditingController Password = TextEditingController();
  FocusNode pwd = FocusNode();
  final TextEditingController PhoneNumber = TextEditingController();
  FocusNode ph_num = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UpdateUIBloc>(
          create: (BuildContext context) => UpdateUIBloc(UpdateUIRepository()),
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
    return BlocProvider(
      create: (context) =>
          UpdateUIBloc(UpdateUIRepository())..add(UserLoadEvent()),
      child:
          BlocBuilder<UpdateUIBloc, UpdateUIState>(builder: (context, state) {
        if (state is UpdatedUser) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => bottomNavigation(index_color: 0)));
          });
        }
        if (state is UpdatedUserLogout) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => LoginPageUI()));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("User Updated Successfully, please login again"),
              ),
            );
          });
        }
        if (state is DeletedUser) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("User Deleted Successfully"),
                backgroundColor: Colors.red,
              ),
            );
          });
        }
        if (state is UpdateUIProcessing) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UpdateUISuccess) {
          return Scaffold(
           // backgroundColor: Colors.grey.shade100,
            body: SafeArea(
                child: SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                  background_container(context),
                  Positioned(
                    top: 120,
                    child: main_container(state, context),
                  )
                              ],
                            ),
                )),
          );
        } else if (state is UpdateUIError) {
          return Container(
            child: Center(
              child: Text(state.errorMessage),
            ),
          );
        }
        return Container();
      }),
    );
  }

  Padding ChangeFirstName(String firstName) {
    FirstName.text = firstName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        focusNode: first,
        controller: FirstName,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'First Name',
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey.shade500,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 226, 179, 237))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 226, 179, 237)))),
      ),
    );
  }

  Padding ChangeLastName(String lastName) {
    LastName.text = lastName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        focusNode: last,
        controller: LastName,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Last Name',
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey.shade500,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 226, 179, 237))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 226, 179, 237)))),
      ),
    );
  }

  Padding ChangePassword() {
    bool showPassword = false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: StatefulBuilder(
        builder: (context, setState) {
          return TextField(
            keyboardType: TextInputType.visiblePassword,
            focusNode: pwd,
            controller: Password,
            obscureText: !showPassword,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              labelText: 'Password',
              labelStyle: TextStyle(
                fontSize: 17,
                color: Colors.grey.shade500,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color:Color.fromARGB(255, 226, 179, 237)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 226, 179, 237)),
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
    );
  }

  Padding ChangeEmail(String userEmail) {
    Email.text = userEmail;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        focusNode: email,
        controller: Email,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Email',
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey.shade500,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 226, 179, 237))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 226, 179, 237)))),
      ),
    );
  }

  Padding ChangePhoneNumber(String phoneNumber) {
    PhoneNumber.text = phoneNumber;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        focusNode: ph_num,
        controller: PhoneNumber,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ],
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Phone Number',
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey.shade500,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 226, 179, 237))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color:Color.fromARGB(255, 226, 179, 237)))),
      ),
    );
  }

  Container main_container(UpdateUISuccess state, BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            height: 600,
            width: 340,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                ChangeFirstName(state.updatedUser.firstName),
                const SizedBox(
                  height: 30,
                ),
                ChangeLastName(state.updatedUser.lastName),
                const SizedBox(
                  height: 30,
                ),
                ChangeEmail(state.updatedUser.email),
                const SizedBox(
                  height: 30,
                ),
                ChangePassword(),
                const SizedBox(
                  height: 30,
                ),
                ChangePhoneNumber(state.updatedUser.phoneNumber),
                const SizedBox(
                  height: 30,
                ),
                UpdateButton(context),
                const SizedBox(
                  height: 20,
                ),
                DeleteButton(context),
              ],
            )),
      ),
    );
  }

  MainButton UpdateButton(BuildContext context) {
    return MainButton(
      onTap: () {
        final updatedUser = UpdateUserModel(
          firstName: FirstName.text,
          lastName: LastName.text,
          password: Password.text,
          email: Email.text,
          phoneNumber: PhoneNumber.text,
        );

        if (Email.text.isEmpty ||
            FirstName.text.isEmpty ||
            LastName.text.isEmpty ||
            PhoneNumber.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please fill all fields'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (!isValidEmail(Email.text)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please enter a valid email'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (Password.text.length < 6 && Password.text != '') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password not long enough, should be 6 characters'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (!isValidNumber(PhoneNumber.text)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Phone number not long enough, should be 11 digits and should start with 03'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          BlocProvider.of<UpdateUIBloc>(context)
              .add(UpdateButtonPressed(updatedUser));
        }
      },
      btncolor: Color.fromARGB(0, 14, 14, 14),
      text: Text('Update',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  MainButton DeleteButton(BuildContext context) {
    final blocContext = context;
    return MainButton(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Alert!'),
              content: Text(
                'Are you sure you want to delete your account?',
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Continue'),
                  onPressed: () {
                    BlocProvider.of<UpdateUIBloc>(blocContext)
                        .add(DeleteButtonPressed());
                    Navigator.of(blocContext).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      btncolor: Color.fromARGB(0, 14, 14, 14),
      text: Text('Delete',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  bool isValidNumber(String phoneNumber) {
    if (phoneNumber.length == 11 && phoneNumber.startsWith('03')) {
      return true;
    } else {
      return false;
    }
  }

  Column background_container(BuildContext context) {
      final themeState = Provider.of<DarkThemeProvider>(context);
    return Column(
      children: [
        Container(
          height: 250,
          width: 500,
           
          decoration: const BoxDecoration(
            gradient:  LinearGradient(
                colors: [
                  Color.fromARGB(255, 169, 145, 182), 
                   Color.fromARGB(255, 160, 123, 165),
                   Color.fromARGB(255, 144, 116, 168),
                   
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          child: Column(
            children: [
              SwitchListTile(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(children: const [
                      Text('Update Your Information',
                          key: Key("updatescreenheading"),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600)),
                      Text('Fill in the fields below to update your account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          )),
                    ]),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  bool isValidEmail(String email) {
    // Regular expression pattern for email validation
    final emailRegex =
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';

    // Create a RegExp object with the email pattern
    final regex = RegExp(emailRegex);

    // Return true if the email matches the pattern, false otherwise
    return regex.hasMatch(email);
  }
}
