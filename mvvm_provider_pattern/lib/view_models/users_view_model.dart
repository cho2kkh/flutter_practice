import 'package:flutter/material.dart';
import 'package:mvvm_provider_pattern/models/user_model.dart';
import 'package:mvvm_provider_pattern/resources/api_status.dart';
import 'package:mvvm_provider_pattern/resources/user_methods.dart';
import 'package:mvvm_provider_pattern/utils/constants.dart';

class UsersViewModel extends ChangeNotifier {
  LoadingStatus _loadingStatus = LoadingStatus.empty;
  Failure? _error;
  List<UserModel> _userListModel = [];

  LoadingStatus get loadingStatus => _loadingStatus;
  Failure? get error => _error;
  List<UserModel> get userListModel => _userListModel;

  Future<void> getUsers() async {
    _loadingStatus = LoadingStatus.loading;
    notifyListeners();

    var response = await UserMethods.getUsers();
    if (response is Success) {
      _error = null;
      _userListModel = response.response as List<UserModel>;
    }
    if (response is Failure) {
      _error = response;
    }

    _loadingStatus =
        _userListModel.isEmpty ? LoadingStatus.empty : LoadingStatus.completed;
    notifyListeners();
  }
}
