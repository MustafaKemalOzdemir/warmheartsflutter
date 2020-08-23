
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:warm_hearts_flutter/screens/SplashScreen.dart';
import 'package:google_map_location_picker/generated/i18n.dart' as location_picker;

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
        localizationsDelegates: [
          location_picker.S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('tr'),
          const Locale('en', '')
        ],
        home: SplashScreen()
    );
  }
}