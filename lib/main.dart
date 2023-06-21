import 'package:flutter/material.dart';
import 'package:project/const/provider/dark_theme_provider.dart';

import 'package:project/google_signin.dart';
import 'package:project/screens/login/loginUI.dart';
import 'package:provider/provider.dart';
import 'const/theme_data.dart';
import 'widget/MainButton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
 bool _isDark = false;
class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   DarkThemeProvider themeChangeProvider = DarkThemeProvider();

   void getCurrentAppTheme() async{
    themeChangeProvider.setdarkTheme = 
     await themeChangeProvider.darkThemePreferences.getTheme();
   }

  void initState(){
    getCurrentAppTheme();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {  
    return MultiProvider(
      providers: [
       ChangeNotifierProvider(create: (_){
         return themeChangeProvider;
       })

      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider,child) {
          return MaterialApp(
               
                title: 'Flutter Demo',
                theme: Styles.themeData(themeProvider.getdarkTheme, context),
                themeMode: ThemeMode.system,
                debugShowCheckedModeBanner: false,
                home: MyHomePage(),
              );
        }
      ),
    );
      
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight; 
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 237, 223, 244),
          body: Stack(
            children: [
              SizedBox(
                height: height / 1.005,
                width: constraints.maxWidth,
                child: Image.asset(
                  key: Key('applogo'),
                  "assets/images/newbackground.png",
                 fit: BoxFit.fill,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                final screenHeight = constraints.maxHeight;
                final screenWidth = constraints.maxWidth;
                    return SizedBox(
                      height: screenHeight / 2.5,
                      width: screenWidth,
                      child: ListView(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(height: screenHeight * 0.12),
                              RichText(
                                key: Key('appname'),
                                  text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'CARDMATE',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 6.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                key: Key('catchline1'),
                                'Where Smart Spending ',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 142, 107, 213),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3.0,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              const Text(
                                key: Key('catchline2'),
                                'Meets Financial Success',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 213, 184, 67),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3.0,
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              MainButton(
                                key: Key('getstartbutton'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => const LoginPageUI(),
                                    ),
                                  );
                                },
                                btncolor: const Color.fromARGB(0, 14, 14, 14),
                                text: const Text(
                                  'Get Started',
                                  style: TextStyle(
                                    color:  Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
