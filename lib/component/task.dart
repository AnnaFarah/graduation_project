class Task {
  int taskID = 0;
  String taskName = '';
  String taskDescription = '';
  String taskStartDate = '';
  String taskEndDate = '';
  int taskStatus = 0;
  bool checkBoxValue = false;
  Task(int id, String name, String description, String startDate,
      String endDate, int status) {
    this.taskID = id;
    this.taskName = name;
    this.taskDescription = description;
    this.taskStartDate = startDate;
    this.taskEndDate = endDate;
    this.taskStatus = status;
  }
}
