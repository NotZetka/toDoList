class Task {
  int id = 0;
  String? title = '';
  String description = '';

  Task(this.id, this.title, this.description);

  Task.fromJson(Map<String, dynamic> taskMap) {
    id = taskMap['id'];
    title = taskMap['title'] ?? '';
    description = taskMap['description'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'description': description};
  }
}
