import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:unit_testing_sample/network/http_client.dart';
import 'package:unit_testing_sample/ui/my_controller.dart';

class MyHomeScreen extends GetView<MyController> {

  @override
  Widget build(BuildContext context) {

    Get.lazyPut(() => MyController());
    Get.lazyPut(() => MyHttpClient());

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              'click me'
            ),
          ),
        ),
      ),
    );
  }
}