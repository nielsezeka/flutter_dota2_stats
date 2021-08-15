import 'package:dota_2_stats/services/service_index.dart';
import 'package:dota_2_stats/views/view_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';

import 'services/graphql_dota/graphql_dota.dart';

void main() {
  ServiceFacade.registerDefaultService();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themes: [
        AppTheme(
          id: "custom_theme", // Id(or name) of the theme(Has to be unique)
          description: "My Custom Theme", // Description of theme
          data: ThemeData(
            // Real theme data
            primaryColor: Colors.black,
            accentColor: Colors.white,
            backgroundColor: Colors.black,
            cardColor: Colors.white.withOpacity(0.1),
            fontFamily: GoogleFonts.breeSerif().fontFamily,
            textTheme: TextTheme(
              headline6: TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.normal,
                color: Colors.white,
              ),
              subtitle1: TextStyle(color: Colors.white),
              bodyText1: TextStyle(color: Colors.white),
              bodyText2: TextStyle(color: Colors.white),
            ),
            hintColor: Colors.white.withOpacity(0.2),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.white.withOpacity(0.2),
            ),
          ),
        ),
        AppTheme
            .light(), // This is standard light theme (id is default_light_theme)
        AppTheme
            .dark(), // This is standard dark theme (id is default_dark_theme)
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            theme: ThemeProvider.themeOf(themeContext).data,
            title: 'Material App',
            home: MyHomePage(),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String test = 'https://picsum.photos/250?image=9';
  DotaGraph graph = DotaGraph();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListAllHeroes(),
        // child: DetailHero(
        //   heroID: 100,
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
