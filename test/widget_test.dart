import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:unit_testing_sample/network/http_client.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing_sample/ui/my_controller.dart';
import 'package:unit_testing_sample/ui/my_service.dart';
import 'mock_data.dart';
import 'widget_test.mocks.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([MyHttpClient])

void main() {

  MockMyHttpClient client = MockMyHttpClient();
  Get.put(client as MyHttpClient);

  test('increment value', () {
    MyController controller = MyController();
    int value = controller.value;
    controller.incrementNumber();
    expect(controller.value, ++value);
  });

  test('decrement value', () {
    MyController controller = MyController();
    int value = controller.value;
    controller.decrementNumber();
    expect(controller.value, --value);
  });


  test('fetchData(), server responds with list, return list of objects', () async {

        MyService service = MyService();

        when(client.get()).thenAnswer((_) async =>
        await http.Response(MockData.RESPONSE_JSON_CORRECT_DATA, 200));

        expect(await service.fetchData(), MockData.RESPONSE_DESERIALIZED_CORRECT_DATA);
      });
}
