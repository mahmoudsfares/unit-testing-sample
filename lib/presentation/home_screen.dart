import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unit_testing_sample/network/http_client.dart';
import 'package:unit_testing_sample/presentation/my_controller.dart';
import 'package:unit_testing_sample/presentation/my_service.dart';

class MyHomeScreen extends StatefulWidget {

  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Get.lazyPut(() => MyService());
    Get.lazyPut(() => MyController());
    Get.lazyPut(() => MyHttpClient());
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('hello world!'),
        ),
      ),
    );
  }
}
