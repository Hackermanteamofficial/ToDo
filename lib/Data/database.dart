import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  //ref the box
  final _myBox = Hive.box("myBox");

  //run this app if it's the first time
  void createInitData(){
    toDoList = [];
  }

  //load data from database
  void loadDatabase() {
    toDoList = _myBox.get("TODOLIST");
  }

  //update database
  void updateDatabase(){
    _myBox.put("TODOLIST", toDoList);
  }
}