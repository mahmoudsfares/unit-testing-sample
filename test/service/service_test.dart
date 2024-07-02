import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:unit_testing_sample/data/data.dart';
import 'package:unit_testing_sample/network/http_client.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing_sample/presentation/my_service.dart';
import '../_mocks/service_test.mocks.dart';
import 'service_mock_data.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([MyHttpClient])
void main() {
  MockMyHttpClient client = MockMyHttpClient();
  Get.put(client as MyHttpClient);

  //-------------------- TESTING FUTURE --------------------//

  group('service fetchDataFuture()', () {
    MyService service = MyService();

    test('server responds with list, return list of objects', () async {
      when(client.get()).thenAnswer((_) async => http.Response(ServiceMockData.RESPONSE_JSON_CORRECT_DATA, 200));
      expect(await service.fetchDataFuture(), ServiceMockData.RESPONSE_DESERIALIZED_CORRECT_DATA);
    });

    test('server responds with empty list, returns Exception: Empty', () async {
      when(client.get()).thenAnswer((_) async => http.Response("[]", 200));
      expect(() async => await service.fetchDataFuture(), throwsA(predicate((e) => e is Exception && e.toString() == 'Exception: Empty')));
    });

    test('bad request, returns Exception: Error fetching data', () async {
      when(client.get()).thenAnswer((_) async => http.Response("[]", 400));
      expect(
          () async => await service.fetchDataFuture(), throwsA(predicate((e) => e is Exception && e.toString() == 'Exception: Error fetching data')));
    });

    test('bad request, returns Exception: Error fetching data', () async {
      when(client.get()).thenAnswer((_) async => http.Response("[]", 500));
      expect(() async => await service.fetchDataFuture(), throwsA(predicate((e) => e is Exception && e.toString() == 'Exception: Server error')));
    });
  });

  //-------------------- TESTING STREAM OF FETCH STATE --------------------//

  group('service fetchDataStream()', () {
    MyService service = MyService();

    test('server responds with list, emits loading then data', () async {
      when(client.get()).thenAnswer((_) async => http.Response(ServiceMockData.RESPONSE_JSON_CORRECT_DATA, 200));
      expect(
          service.fetchDataStream(),
          emitsInOrder([
            predicate((o) => o is Loading),
            predicate((o) => o is Fetched && listEquals(o.data as List<MyDTO>, ServiceMockData.RESPONSE_DESERIALIZED_CORRECT_DATA))
          ]));
    });

    test('server responds with empty list, emits loading then Exception: Empty', () async {
      when(client.get()).thenAnswer((_) async => http.Response('[]', 200));
      expect(service.fetchDataStream(),
          emitsInOrder([predicate((o) => o is Loading), predicate((o) => o is Error && (o.exception).toString() == 'Exception: Empty')]));
    });

    test('server responds with bad request, emits loading then Exception: Error fetching data', () async {
      when(client.get()).thenAnswer((_) async => http.Response('any response', 400));
      expect(service.fetchDataStream(),
          emitsInOrder([predicate((o) => o is Loading), predicate((o) => o is Error && o.exception.toString() == 'Exception: Error fetching data')]));
    });

    test('server responds with error, emits loading then Exception: Server error', () async {
      when(client.get()).thenAnswer((_) async => http.Response('any response', 500));
      expect(service.fetchDataStream(),
          emitsInOrder([predicate((o) => o is Loading), predicate((o) => o is Error && o.exception.toString() == 'Exception: Server error')]));
    });
  });
}
