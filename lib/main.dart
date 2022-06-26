import 'package:dart_vlc/dart_vlc.dart';
import 'package:etfarag/providers/google_signin_provider.dart';
import 'package:etfarag/providers/live_channel_provider.dart';
import 'package:etfarag/providers/movies_provider.dart';
import 'package:etfarag/screens/add_live_screen.dart';
import 'package:etfarag/screens/add_movie_screen.dart';
import 'package:etfarag/screens/main_screen.dart';
import 'package:etfarag/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DartVLC.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (_) => LiveChannelsProvider()),
        ChangeNotifierProvider(create: (_) => MovieChannelsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // canvasColor: Colors.white,
            brightness: Brightness.light,
            textTheme: TextTheme(
              headline1: GoogleFonts.cairo(
                  color: Colors.black,
                  fontSize: 86,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1.5),
              headline2: GoogleFonts.cairo(
                  color: Colors.black,
                  fontSize: 54,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -0.5),
              headline3: GoogleFonts.cairo(
                  color: Colors.black,
                  fontSize: 43,
                  fontWeight: FontWeight.w400),
              headline4: GoogleFonts.cairo(
                color: Colors.black,
                fontSize: 31,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
              ),
              headline5: GoogleFonts.cairo(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
              headline6: GoogleFonts.cairo(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15),
              subtitle1: GoogleFonts.cairo(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.15),
              subtitle2: GoogleFonts.cairo(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1),
              bodyText1: GoogleFonts.cairo(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5),
              bodyText2: GoogleFonts.cairo(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.25),
              button: GoogleFonts.cairo(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.25),
              caption: GoogleFonts.cairo(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.4),
              overline: GoogleFonts.cairo(
                  color: Colors.black,
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.5),
            )),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return MainScree();
            } else if (snapshot.hasError) {
              return Text('an error occured, Try again later');
            }
            return SignupScreen();
          },
        ),
        routes: {
          AddLiveChannel.id: (context) => AddLiveChannel(),
          AddMovie.id: (context) => AddMovie(),
        },
      ),
    );
  }
}
