import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/core/utils/mvp_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

class LoginPresenter extends Cubit<LoginViewModel>
    with CubitToCubitCommunicationMixin<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.navigator,
    this.logInUseCase,
  );

  final LoginNavigator navigator;
  final LogInUseCase logInUseCase;

  // ignore: unused_element
  LoginPresentationModel get _model => state as LoginPresentationModel;

  void onUserNameChanged(String userName) {
    emit(_model.copyWith(username: userName));
  }

  void onPasswordChanged(String password) {
    emit(_model.copyWith(password: password));
  }

  Future<void> onLoginClicked(String userName, String password) async {
    await await logInUseCase
        .execute(username: userName, password: password)
        .observeStatusChanges(
          (result) =>
              emit(_model.copyWith(password: password, username: userName, loginResult: result,)),
        )
        .asyncFold(
          (fail) => navigator.showError(fail.displayableFailure()),
          (success) => navigator.showAlert(message: appLocalizations.youAreLoggedIn, title: appLocalizations.loginSuccess),
        );
  }
}
