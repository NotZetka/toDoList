class Task {
  String? title;
  String description = '';
  int id = 0;

  Task(this.title, this.description, this.id);

  Task.fromJson(Map<String, dynamic> taskMap) {
    title = taskMap['title'] ?? '';
    description = taskMap['description'] ?? '';
    id = taskMap['id'];
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'id': id};
  }
}
