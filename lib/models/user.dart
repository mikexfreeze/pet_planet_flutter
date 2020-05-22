import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {

  String token = '1';

  void setToken (String token){
    this.token = token;
    notifyListeners();
  }

}

