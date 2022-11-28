import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mvvm_provider_pattern/models/user_model.dart';
import 'package:mvvm_provider_pattern/resources/api_status.dart';

class UserMethods {
  static Future<Object> getUsers() async {
    try {
      var response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
      if (200 == response.statusCode) {
        return Success(
          code: response.statusCode,
          response: usersListModelFromJson(response.body),
        );
      }
      return Failure(code: 100, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: 101, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(code: 101, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: 102, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(
          code: 103, errorResponse: 'Unknown Error : ${e.toString()}');
    }
  }
}
