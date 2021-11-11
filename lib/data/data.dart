import 'package:equatable/equatable.dart';

class MyDTO extends Equatable {
  int userId;
  int id;
  String title;
  bool isCompleted;

  MyDTO(this.userId, this.id, this.title, this.isCompleted);

  factory MyDTO.fromJson(Map<String, dynamic> jsonProduct) {
    return MyDTO(jsonProduct['userId'], jsonProduct['id'], jsonProduct['title'],
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


class FetchState {}

class Loading extends FetchState with EquatableMixin {
  // loading doesn't need this value but the extension of equatable needs
  // a comparable value to compare with.
  // we can also compare without extending equatable using predicate
  // (check commented part in controller test and service streams test)
  int testInt = 1;

  @override
  List<Object?> get props => [testInt];
}

class Error extends FetchState  with EquatableMixin {
  Exception exception;
  Error(this.exception);

  @override
  List<Object?> get props => [exception.toString()];
}

class Fetched extends FetchState with EquatableMixin {
  dynamic data;
  Fetched(this.data);

  @override
  List<Object?> get props =>[data];
}
