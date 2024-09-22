// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart';

import '../utils/constants.dart';

class UserService {
  late List data;

  Future<void> fetchAllUser() async {
    Response response = await get(
      Uri.parse('$HOST/api/v1/users'),
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
