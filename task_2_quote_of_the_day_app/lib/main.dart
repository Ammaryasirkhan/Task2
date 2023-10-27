import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_2_quote_of_the_day_app/Screen/home.dart';

import 'Providers/user_provider.dart';
import 'Screen/login_page.dart';
import 'Utilities/colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        iconTheme: const IconThemeData(color: Colors.white),
        primarySwatch: const MaterialColor(
          0xFF8DBAAD, // Replace with your desired color value
          <int, Color>{
            50: Color(0xFF8DBAAD),
            100: Color(0xFF8DBAAD),
            200: Color(0xFF8DBAAD),
            300: Color(0xFF8DBAAD),
            400: Color(0xFF8DBAAD),
            500: Color(0xFF8DBAAD),
            600: Color(0xFF8DBAAD),
            700: Color(0xFF8DBAAD),
            800: Color(0xFF8DBAAD),
            900: Color(0xFF8DBAAD),
          },
        ),
      ),
      // primarySwatch: Colors.blue,
      // home: LoginPage(),
      // home: ResponsiveScreenLayout(
      //     webScreenLayout: WebS(), mobileScreenLayout: MobileS())
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider()),
          // Add other providers if needed
        ],
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const HomePage();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: ColorRes.app),
              );
            }
            return const LoginPage();
          },
        ),
      ),
      // getPages: Routes.routes,
    );
  }
}
