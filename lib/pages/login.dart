import 'package:flutter/material.dart';
import 'package:petplanet/app.dart';
import 'package:petplanet/data/app_options.dart';
import 'package:petplanet/layout/letter_spacing.dart';
import 'package:petplanet/theme.dart';

const _horizontalPadding = 24.0;

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ApplyTextOptions(
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: _horizontalPadding,
            ),
            children: const <Widget>[
              SizedBox(height: 120,),
              _UsernameTextField(),
              SizedBox(height: 12),
              _PasswordTextField(),
              LoginButton(),
            ],
          )
        )
      ),
    );

  }
}

class _UsernameTextField extends StatelessWidget {
  const _UsernameTextField();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final _usernameController = TextEditingController();

    return Container(
      child: TextField(
        controller: _usernameController,
        cursorColor: colorScheme.onSurface,
        decoration: InputDecoration(
          labelText: '用户名',
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final _passwordController = TextEditingController();

    return  Container(
      child: TextField(
        controller: _passwordController,
        cursorColor: colorScheme.onSurface,
        obscureText: true,
        decoration: InputDecoration(
          labelText: '密码',
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;


    final buttonTextPadding = EdgeInsets.zero;

    return Wrap(
      children: [
        ButtonBar(
          buttonPadding: null,
          children: [
            RaisedButton(
              child: Padding(
                padding: buttonTextPadding,
                child: Text(
                  '登录',
                  style: TextStyle(
                      letterSpacing: letterSpacingOrNone(largeLetterSpacing)),
                ),
              ),
              elevation: 8,
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(App.homeRoute);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(primaryColor: color),
    );
  }
}