import 'package:flutter/material.dart';
import 'package:soochi_patra/widgets/task_tile.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:soochi_patra/models/task_data.dart';

final LocalStorage localStorage = LocalStorage('toDoList.json');
bool initialised = false;
List tasksList = [];

class TasksList extends StatelessWidget {
  Future<bool> get retrieveData async {
    await localStorage.ready;
    if (localStorage != null) {
      tasksList = await localStorage.getItem('todos'); //saved in key='todos'
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: retrieveData,
      builder: (context, snapshot) {
        //print(snapshot);
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } //
        else {
          //Instead of provider.of< >(context) all the time
          //wrap all of the downstream widgets with Consumer widget
          //(that need to be updated when task property changes).
          return Consumer<TaskData>(
//Consumer widget re-build the entire ListView, while listening to changes in tasks data
            builder: (BuildContext context, TaskData taskData, Widget child) {
              if (initialised == false) {
                taskData.init(tasksList);
                initialised = true;
              }
              //print(taskData.tasks);

              return ListView.builder(
                //dynamic Listview.builder only gonna build the TaskTiles, as many user sees
                itemBuilder: (context, index) {
                  final task = taskData.tasks[index]; //a task item

                  return TasksTile(
                    taskTitle: task.name,
                    isChecked: task.isDone,
                    checkBoxCallBack: (bool currentCheckBoxState) {
                      taskData.updateTask(task);
                    },
                    longPressTaskTileDeleteCallBack: () {
                      taskData.deleteTask(task);
                    },
                    longPressTaskTileClearCallBack: () {
                      taskData.clearAllTasks(task);
                      //we can clear all Tasks , by passing any one task item of that List<Task>
                    },
                  );
                },
                itemCount: taskData.taskCount,
              );
            },
          );
        }
      },
    );
  }
//Stateless widget = memoryless
//which simply gets constructed when they're needed and
//destroyred & replaced with the ones when they update.
}
