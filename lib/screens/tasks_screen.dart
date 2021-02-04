import 'package:flutter/material.dart';
import 'package:soochi_patra/screens/add_task_screen.dart';
import 'package:soochi_patra/widgets/tasks_list.dart';
import 'package:provider/provider.dart';
import 'package:soochi_patra/models/task_data.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(30, 37, 25, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  child: Icon(
                    Icons.list_alt,
                    color: Colors.yellow,
                    size: 30,
                  ),
                  backgroundColor: Color(0xFFD32F2F),
                  radius: 25,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "सूची-पत्र",
                  style: TextStyle(
                    color: Color(0xFF28324B),
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "( TO-DO List / Daily Task Planner / Shopping Cart )",
                  style: TextStyle(
                    color: Color(0xFF28324B),
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                Text(
                  "${Provider.of<TaskData>(context).taskCount} कृत्य", //reading data from the provider object
                  style: TextStyle(
                    color: Color(0xFF28324B),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                color: Color(0xFF58E540),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: TasksList(),
//////TasksList() having listview in it , which indeed has tasktile children
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            //puts modal above keyboard
            isScrollControlled: true, //makes the modal full screen height
            context: context,
            builder:
//To have the AddTaskScreen sit just above the keyboard,
//we wrap it inside a SingleChildScrollView,
//which determines the padding at the bottom using a MediaQuery.
                (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddTaskScreen(),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.yellow,
        foregroundColor: Color(0xFF28324B),
        child: Icon(Icons.add),
      ),
    );
  }
}
/*   widget tree of app ->

                  MyApp
                    |
                    |
                TasksScreen
                /        \
               /          \
    AddTaskScreen       TasksList
                             |
                             |
                          TasksTile   */
