
import 'package:flutter/material.dart';
import 'package:warm_hearts_flutter/screens/SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: Colors.white,
              iconTheme: IconThemeData(color: Colors.grey[800]),
              actionsIconTheme: IconThemeData(
                color: Colors.grey[800],
              ),
            )
        ),
        home: SplashScreen()
    );
  }
}