
import 'package:equatable/equatable.dart';

class MyDTO extends Equatable{
  int userId;
  int id;
  String title;
  bool isCompleted;

  MyDTO(this.userId, this.id, this.title, this.isCompleted);

  factory MyDTO.fromJson(Map<String, dynamic> jsonProduct) {
    return MyDTO(
        jsonProduct['userId'],
        jsonProduct['id'],
        jsonProduct['title'],
        jsonProduct['completed']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'completed': isCompleted,
    };
  }

  @override
  List<Object?> get props => [
    userId, title
  ];
}