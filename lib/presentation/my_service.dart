import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:unit_testing_sample/data/data.dart';
import 'package:unit_testing_sample/network/http_client.dart';

class MyService {
  Future<List<MyDTO>> fetchDataFuture() async {
    MyHttpClient client = Get.find();
    dynamic res;
    try {
      res = await client.get();
    } catch (e) {
      if (e is SocketException) throw Exception("No internet connection");
    }
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body) as List<dynamic>;
      final listResult = json.map((e) => MyDTO.fromJson(e)).toList();
      if (listResult.isEmpty) {
        throw Exception("Empty");
      } else {
        return listResult;
      }
    } else if (res.statusCode >= 400 && res.statusCode < 500) {
      throw Exception("Error fetching data");
    } else if (res.statusCode >= 500 && res.statusCode < 600) {
      throw Exception("Server error");
    } else {
      throw Exception("Error occurred, please try again later");
    }
  }

  Stream<FetchState> fetchDataStream() async* {
    yield Loading();
    MyHttpClient client = Get.find();
    dynamic res;
    try {
      res = await client.get();
    } catch (e) {
      if (e is SocketException) {
        yield Error(Exception("No internet connection"));
      }
    }
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body) as List<dynamic>;
      final listResult = json.map((e) => MyDTO.fromJson(e)).toList();
      if (listResult.isEmpty) {
        yield Error(Exception("Empty"));
      } else {
        yield Fetched(listResult);
      }
    } else if (res.statusCode >= 400 && res.statusCode < 500) {
      yield Error(Exception("Error fetching data"));
    } else if (res.statusCode >= 500 && res.statusCode < 600) {
      yield Error(Exception("Server error"));
    } else {
      yield Error(Exception("Error occurred, please try again later"));
    }
  }
}
