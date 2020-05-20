import 'package:flutter/material.dart';
import 'package:petplanet/app.dart';
import 'package:petplanet/data/app_options.dart';
import 'package:petplanet/layout/letter_spacing.dart';
import 'package:petplanet/theme.dart';

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;

  void _handleSubmitted() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true; // Start validating on every change.
      showInSnackBar('请先修正红色错误，然后再提交。');
    } else {
      form.save();
      print(loginData.username);
    }
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

  @override
  Widget build(BuildContext context) {
    return ApplyTextOptions(
      child: Scaffold(
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
                  decoration: InputDecoration(
                    hintText: '请输入',
                    labelText: '用户名',
                  ),
                  onSaved: (value) {
                    loginData.username = value;
                  },
                  validator: _validateName,
                ),
                SizedBox(height: 12),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '请输入',
                    labelText: '密码',
                  ),
                  onSaved: (value) {
                    loginData.password = value;
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
      ),
    );

  }
}