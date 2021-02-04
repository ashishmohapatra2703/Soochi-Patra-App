import 'package:flutter/material.dart';

class TasksTile extends StatelessWidget {
  //all properties in stateless widget class are final
  final String taskTitle;
  final bool isChecked;
  final Function checkBoxCallBack;
  final Function longPressTaskTileDeleteCallBack;
  final Function longPressTaskTileClearCallBack;

  TasksTile({
    this.taskTitle,
    this.isChecked,
    this.checkBoxCallBack,
    this.longPressTaskTileDeleteCallBack,
    this.longPressTaskTileClearCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskTitle,
        style: TextStyle(
          fontSize: 17,
          fontFamily: 'Sedgwick Ave',
          fontWeight: FontWeight.w600,
          letterSpacing: 0.9,
          decoration: (isChecked) ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: isChecked,
        onChanged: checkBoxCallBack,
        //to notify the parent (Tasklist) when the checkbox get triggered, on tap
        activeColor: Color(0xFFB71C1C),
      ),
      //onLongPress: longPressTaskTileCallBack,
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Delete Task ?"),
              content:
                  Text("क्या आप कार्य को अपने सूची-पत्र से हटाना चाहते हैं ?"),
              actions: [
                FlatButton(
                  onPressed: longPressTaskTileDeleteCallBack,
                  child: Text("Delete this task item only"),
                ),
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Go Back"),
                ),
                FlatButton(
                  onPressed: longPressTaskTileClearCallBack,
                  child: Text("Delete all tasks and clear the list"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
