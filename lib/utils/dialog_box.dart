import 'package:flutter/material.dart';
import 'package:todo/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  final String title;
  final inputController;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({super.key,
    required this.onSave,
    required this.onCancel,
    this.inputController,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      backgroundColor: Colors.green[100],
      content: SizedBox(
        height: 152,
        width: double.infinity,
        child: Column(
          children: [
            //title
            Text(title, style: TextStyle(fontSize: 18),),
            //gap
            SizedBox(height: 12,),
            //user input
            TextField(
              autofocus: true,
              controller: inputController,
              decoration: InputDecoration(
                hintText: "Add new task",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
            ),
            const SizedBox(height: 12,),

            //buttons --> save & cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //cancel button
                MyButton(onPressed: onCancel, text: "Cancel"),
                //gap
                SizedBox(width: 8,),
                //save button
                MyButton(onPressed: onSave, text: "Save"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
