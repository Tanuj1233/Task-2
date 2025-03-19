import 'package:flutter/material.dart';
import 'package:todo/pages/util/my_button.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyButton(
                  backgroundColor: Colors.yellow,
                  text: "Save", 
                  onPressed: onSave,
                ),

                MyButton(
                  backgroundColor: Colors.yellow,
                  text: "Cancel", 
                  onPressed: onCancel,
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}
