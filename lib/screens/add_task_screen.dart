import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soochi_patra/models/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newTaskTitle; //local property to store textfield value

    return Container(
      color: Color(0xFF28691D), //=> behind rounded corners, dim green appears
      child: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Color(0xFF5BC0EB),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "अपने कार्य को सूची में जोड़ें ।",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27,
                color: Color(0xFFB71C1C),
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 15),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(border: OutlineInputBorder()),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onChanged: (String newText) {
                newTaskTitle = newText;
              },
            ),
            SizedBox(height: 15),
            FlatButton(
              color: Colors.yellow,
              height: 50,
              child: Text(
                "  ADD thokiye dabake 🔥",
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0xFF28324B),
                  fontWeight: FontWeight.w900,
                ),
              ),
              onPressed: () {
                //DO NOT use Provider.of<TaskData>(context).tasks.add(newTaskTitle)
                Provider.of<TaskData>(context, listen: false)
                    .addTask(newTaskTitle);
                //listen: false coz it's only for update purpose in AddTaskScreen
//that trigger all current provider listener (TasksScreen & TasksList) to re-build themseleves
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
