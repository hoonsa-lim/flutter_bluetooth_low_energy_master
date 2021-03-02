import 'package:bluetooth_finder/Screen/MainScreen.dart';
import 'package:bluetooth_finder/Store/ColorStore.dart';
import 'package:bluetooth_finder/Store/BluetoothStore.dart';
import 'package:bluetooth_finder/Store/StringStore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BluetoothStore()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringStore.AppName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor : const Color(ColorStore.primaryColor),
      ),
      initialRoute: '/MainScreen',
      routes: {
        '/MainScreen': (context) => MainScreen(),
      },
    );
  }
}