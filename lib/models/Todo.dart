class Todo {
  String? title;
  String? text;
  bool? done;

  Todo({this.title, this.text, this.done = false});

  Todo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() => {'title': title, 'text': text, 'done': done};
}
