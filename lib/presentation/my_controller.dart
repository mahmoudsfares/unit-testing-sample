import 'package:get/get.dart';
import 'package:unit_testing_sample/data/data.dart';
import 'package:unit_testing_sample/presentation/my_service.dart';

class MyController extends GetxController{

  int value = 0;

  void incrementNumber() => value++;
  void decrementNumber() => value--;

  Rx<FetchState> fetchState = FetchState().obs;
  MyService service = Get.find();

  void fetchData() async {
    fetchState.value = Loading();
    try {
      List<MyDTO> data = await service.fetchDataFuture();
      fetchState.value = Fetched(data);
    }
    catch (e){
      if (e is Exception) fetchState.value = Error(e);
    }
  }
}
