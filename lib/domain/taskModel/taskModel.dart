import 'dart:convert';
// Class that will be the Model for a Task Object
class TaskModel {

  final String id;
  String title;
  String content;
  String imageUrl;
  TaskModel({
    required this.id,
    required this.title,
   required this.content,
   required this.imageUrl
  });

  @override
  String toString() => 'TaskModel(id: $id, title: $title, content: $content)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'imageUrl':imageUrl
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      imageUrl: map['imageUrl'],
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}