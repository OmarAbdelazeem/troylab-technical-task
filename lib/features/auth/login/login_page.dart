// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/helpers.dart';
import 'package:flutter_demo/core/utils/mvp_extensions.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

class LoginPage extends StatefulWidget with HasPresenter<LoginPresenter> {
  const LoginPage({
    required this.presenter,
    super.key,
  });

  @override
  final LoginPresenter presenter;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with PresenterStateMixin<LoginViewModel, LoginPresenter, LoginPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: userNameController,
                decoration: InputDecoration(
                  hintText: appLocalizations.usernameHint,
                ),
                onChanged: presenter.onUserNameChanged,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: appLocalizations.passwordHint,
                ),
                onChanged: presenter.onPasswordChanged,
              ),
              const SizedBox(height: 16),
              stateObserver(
                builder: (context, state) => state.isLoginLoading ? const CircularProgressIndicator() : ElevatedButton(
                    onPressed: state.isLoginEnabled ? () => presenter.onLoginClicked(userNameController.text, passwordController.text) : null,
                    child: Text(appLocalizations.logInAction),
                  ),
              ),
            ],
          ),
        ),
      );

  
}
