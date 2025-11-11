import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/Data/database.dart';
import 'package:todo/utils/todo_list.dart';

import '../utils/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _myBox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState(){
    super.initState();
    if(_myBox.get("TODOLIST") == null){
      db.createInitData();
    }else{
      db.loadDatabase();
    }
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Task Removed!"),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        duration: const Duration(seconds: 2),
        dismissDirection: DismissDirection.startToEnd,
      ),
    );
  }
  //add task
  void addNewTask(){
    showDialog(context: context, builder: (context) {
      return DialogBox(
        title: "",
        onCancel: Navigator.of(context).pop,
        onSave: saveTask,
      );
    });
  }
  //save task
  void saveTask() {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      //
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: const [
                Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
                SizedBox(width: 8),
                Text("Empty Task"),
              ],
            ),
            content: const Text(
              "Please enter a task before saving.",
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "OK",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      );
      return;
    }

    //
    setState(() {
      db.toDoList.add([text, false]);
      _controller.clear();
    });

    db.updateDatabase();
    Navigator.of(context).pop();

    //show snack bar messenger
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Task added successfully ✅"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.fixed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        duration: const Duration(seconds: 2),
        dismissDirection: DismissDirection.startToEnd,
      ),
    );
  }

  //checkbox change
  void checkBoxChange(bool? value,int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }
  //create new task
  void createTask() async{
    await showDialog(context: context, builder: (context) {
      return DialogBox(
        title: "Add New Task",
        onSave: saveTask,
        onCancel: () {
          Navigator.of(context).pop();
          _controller.clear();
        },
        inputController: _controller,);
    });
    _controller.clear();
  }

  //edit task function
  void editTask(index){
    final editController = TextEditingController(text: db.toDoList[index][0]);

    showDialog(context: context, builder: (context) {
      return  DialogBox(
          title: "Edit Task",
          inputController:editController,
          onSave: () {
            setState(() {
              db.toDoList[index][0] = editController.text.trim();
            });
            db.updateDatabase();
            Navigator.of(context).pop();
          },
          onCancel: () => Navigator.of(context).pop(),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My To Do List"),
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: db.toDoList.isEmpty
            ? Center(
          child: Text("No tasks yet 💤",style: TextStyle(fontSize: 25),),
        )
            :ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return TodoList(
                taskName: db.toDoList[index][0],
                isDone: db.toDoList[index][1],
                deleteFunction: (context) => deleteTask(index),
                onChanged: (value) => checkBoxChange(value, index),
                editFunction: (context) => editTask(index)
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        child: Icon(Icons.add, size: 35,),
      ),
    );
  }
}
