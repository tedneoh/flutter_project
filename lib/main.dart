import 'package:flutter/material.dart';
import 'package:flutter_project/providers/contacts.dart';
import 'package:flutter_project/screens/contacts_screen.dart';
import 'package:flutter_project/screens/edit_contact_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Contacts(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter app',
          theme: ThemeData(
            primarySwatch: buildMaterialColor(Color(0xFFff8c00)),
          ),
          home: ContactsScreen(),
          routes: {
            ContactsScreen.routeName: (ctx) => ContactsScreen(),
            EditContactScreen.routeName: (ctx) => EditContactScreen(),
          }),
    );
  }
}
