import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatelessWidget {
  final String taskName;
  final bool isDone;
  final Function(bool?) onChanged;
  final Function(BuildContext)? deleteFunction;
  const TodoList({super.key,
    required this.taskName,
    required this.isDone,
    required this.deleteFunction,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25,right: 25,top: 20),
      child: Slidable(
        endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                label: "delete",
                onPressed: deleteFunction,
                icon: Icons.delete_forever_outlined,
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(10),
                foregroundColor: Colors.white,
            )
          ]
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          height: 80,
          decoration:BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            //check box
            children: [
              Checkbox(value: isDone, onChanged: onChanged, activeColor: Colors.black,shape: CircleBorder(),),
              //task name
              Text(taskName, style: TextStyle(decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none, fontSize: 17),),
            ],
          ),
        ),
      ),
    );
  }
}
