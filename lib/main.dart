import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Pages/home_page.dart';

void main() async{
  //hive init
  await Hive.initFlutter();

  //open box
  var box = await Hive.openBox("myBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green,
        useMaterial3: false,

      ),
    );
  }
}
