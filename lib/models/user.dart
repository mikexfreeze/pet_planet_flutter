import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends ChangeNotifier {

  String token;

  UserModel() {
    _initDataFromStorage();
  }

  _initDataFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.get('token');
    print('token from localstorage: $token');
    notifyListeners();
  }

  void setToken (String token){
    this.token = token;
    notifyListeners();
  }

}

