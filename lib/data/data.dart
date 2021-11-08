import 'package:equatable/equatable.dart';

class FetchState{}

class Loading extends FetchState{}

class Fetched extends FetchState{
  dynamic data;
  Fetched(this.data);
}

class Error extends FetchState{
  Exception exception;
  Error(this.exception);
}


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
  List<Object?> get props => [userId, id, title, isCompleted];
}
