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
  MockMyService service = MockMyService();
  Get.put(service as MyService);

  //-------------------- TESTING NORMAL METHODS --------------------//

  group('MyController functions', () {
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

  group('MyController functions', () {
    MyController controller = MyController();

    test('fetch data', () async {
      when(service.fetchDataFuture()).thenAnswer(
          (_) async => ControllerMockData.RESPONSE_DESERIALIZED_CORRECT_DATA);
      expect(controller.fetchData, returnsNormally);
    });

    test('fetch data', () async {
      when(service.fetchDataFuture())
          .thenAnswer((_) async => throw Exception("Error fetching data"));
      expect(controller.fetchData, returnsNormally);
    });
  });
}
