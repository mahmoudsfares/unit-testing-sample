import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing_sample/data/data.dart';
import 'package:unit_testing_sample/ui/my_controller.dart';
import 'package:unit_testing_sample/ui/my_service.dart';
import 'controller_mock_data.dart';
import 'controller_test.mocks.dart';

@GenerateMocks([MyService])
void main() {

  //-------------------- TESTING NORMAL METHODS --------------------//

  group('MyController normal methods', () {
    MyController controller = MyController();

    test('increment value', () {
      int value = controller.value;
      controller.incrementNumber();
      expect(controller.value, ++value);
    });

    test('decrement value', () {
      int value = controller.value;
      controller.decrementNumber();
      expect(controller.value, --value);
    });
  });


  //-------------------- TESTING METHODS WITH MOCKITO --------------------//

  MockMyService service = MockMyService();
  Get.put(service as MyService);

  group('MyController Methods that need mocking', () {

    MyController controller = MyController();

    test('data fetched correctly, state fetched', () async {
      when(service.fetchDataFuture()).thenAnswer(
          (_) async => ControllerMockData.RESPONSE_DESERIALIZED_CORRECT_DATA);
      expect(
          controller.fetchState.stream,
          emitsInOrder([
            Loading(),
            Fetched(ControllerMockData.RESPONSE_DESERIALIZED_CORRECT_DATA)
          ]));
      // uncomment this part to test without extending equatable in data
      // expect(
      //     controller.fetchState.stream,
      //     emitsInOrder([
      //       predicate((o) => o is Loading),
      //       predicate((o) => o is Fetched && listEquals(o.data as List<MyDTO>, ControllerMockData.RESPONSE_DESERIALIZED_CORRECT_DATA))
      //     ]));
      controller.fetchData();
    });

    test('error fetching data, state error', () async {
      when(service.fetchDataFuture())
          .thenAnswer((_) async => throw Exception("Error fetching data"));
      expect(controller.fetchState.stream,
          emitsInOrder([Loading(), Error(Exception('Error fetching data'))]));
      // uncomment this part to test without extending equatable in data
      // expect(
      //     controller.fetchState.stream,
      //     emitsInOrder([
      //       predicate((o) => o is Loading),
      //       predicate((o) => o is Error && o.exception.toString() == "Exception: Error fetching data")
      //     ]));
      controller.fetchData();
    });
  });
}
