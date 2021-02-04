import 'package:flutter/material.dart';
import 'package:soochi_patra/screens/tasks_screen.dart';
import 'package:provider/provider.dart';
import 'package:soochi_patra/models/task_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//Provider should be wrapped at the root of widget tree or high enough w.r.t to its branches.
    return ChangeNotifierProvider<TaskData>(
      create: (context) {
        return TaskData();
        //object to be provided
      },
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}
//state of the tasks (list) objects provider are kept high
//so that we can use it all the way down in widget tree
//providing that data to both TasksScreen() & TasksList()
//=> to listen for changes in the tasks data.
