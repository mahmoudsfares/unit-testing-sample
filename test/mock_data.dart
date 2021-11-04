import 'package:unit_testing_sample/data/data.dart';

class MockData {

  static late final String RESPONSE_JSON_CORRECT_DATA = """[{
  "userId": 1,
  "id": 1,
  "title": "delectus aut autem",
  "completed": false
  },
  {
  "userId": 1,
  "id": 2,
  "title": "quis ut nam facilis et officia qui",
  "completed": false
  }]""";

  static late final List<MyDTO>  RESPONSE_DESERIALIZED_CORRECT_DATA = [
    MyDTO(1, 1, 'delectus aut autem', false),
    MyDTO(1, 2, 'quis ut nam facilis et officia qui', false)
  ];
}