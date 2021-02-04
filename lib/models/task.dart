class Task {
  final String name;
  bool isDone;

  Task({this.name, this.isDone = false}); //isDone => default parameter

  void toggleisDone() {
    isDone = !isDone;
  }

  Map toJSONEncodable() {
    return {"name": name, "isDone": isDone};
  }
}
