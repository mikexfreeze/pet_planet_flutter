import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:petplanet/app.dart';
import 'package:http/http.dart' as http;
import 'package:petplanet/models/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _horizontalPadding = 24.0;

class LoginData {
  String username = '';
  String password = '';
}

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  UserModel user;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  bool _autoValidate = false;

  void _handleSubmitted() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true; // Start validating on every change.
      showInSnackBar('请先修正红色错误，然后再提交。');
    } else {
      form.save();
      print('loginData.password: ${loginData.password}');

      Future<Token> _responseData = login();
      _responseData.then((value) {
        String token = 'Bearer ${value.token}';
        user.setToken(token);
        _setTokenInStorage(token);
      }).catchError((error) => print(error));
      Navigator.of(context).pushNamed(App.homeRoute);
    }
  }

  _setTokenInStorage(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  LoginData loginData = new LoginData();

  String _validateName(String value) {
    if (value.isEmpty) {
      return '请输入';
    }
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return '用户名只能为大小写字母';
    }
    return null;
  }

  String _validatePassword(String value) {
    final passwordField = _passwordFieldKey.currentState;
    if (passwordField.value == null || passwordField.value.isEmpty) {
      return '请输入';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserModel>(context);
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
            child: Form(
                autovalidate: _autoValidate,
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _horizontalPadding,
                  ),
                  children: [
                    SizedBox(height: 120,),
                    TextFormField(
                      maxLength: 12,
                      decoration: InputDecoration(
                        hintText: '请输入',
                        labelText: '用户名',
                      ),
                      onSaved: (value) {
                        loginData.username = value;
                      },
//                      validator: _validateName,
                    ),
                    SizedBox(height: 12),
                    PasswordField(
                      fieldKey: _passwordFieldKey,
                      labelText: '密码',
                      helperText: '请输入',
                      onFieldSubmitted: (value) {
                        setState(() {
                          loginData.password = value;
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    Center(
                      child: RaisedButton(
                        child: Text('登录'),
                        onPressed: _handleSubmitted,
                      ),
                    ),
                  ],
                )
            )

        )
    );

  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      maxLength: 12,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),

    );
  }
}

Future<Token> login() async {
  final http.Response response = await http.post(
    'http://aws.duandiwang.com:8080/api/authenticate',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'password': 'x1986119',
      'username': 'test01',
    }),
  );

  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to login.');
  }
}

class Token {
  String token;

  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['id_token'],
    );
  }
}