import 'package:flutter/material.dart';
import 'package:todo/data/database.dart';
import 'package:todo/pages/util/dialog_box.dart';
import 'package:todo/pages/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key}); 

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    
    // if this is the 1st time ever opening the app the create default data
    if(_myBox.get("toDoList") == null) {
      db.createInitialData();
    }
    else {
      // there already exists data
      db.loadData();
    }
    
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  //* checkBox was tapped
  void checkBoxChanged(int index) {
    setState(() {
      db.toDoList[index] [1] = !db.toDoList[index] [1];
    });
    db.updateDataBase();
  }

  //* save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
      Navigator.pop(context);
      db.updateDataBase();
  }

  //* create a new task
  void createNewTask () {
    showDialog(
      context: context, 
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        elevation: 2,
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Colors.yellow,
        title: const Text("To Do"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add,), 
        ),
      
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder:(context, index) {
          return ToDoTile(
            taskName: db.toDoList[index] [0],
            taskCompleted: db.toDoList[index] [1],
            onChanged: (value) => checkBoxChanged(index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}