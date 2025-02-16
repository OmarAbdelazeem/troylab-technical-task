import 'package:flutter_demo/features/auth/login/login_initial_params.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
    /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  ) : loginResult = const FutureResult.empty();
    /// Used for the copyWith method
  LoginPresentationModel._();
  String username = '';
  String password = '';
  FutureResult<Either<LogInFailure, User>>? loginResult;

  @override
  bool get isLoginEnabled => username.isNotEmpty && password.isNotEmpty;
  @override
  bool get isLoginLoading => loginResult!.isPending();





  LoginPresentationModel copyWith({
    String? username,
    String? password,
    FutureResult<Either<LogInFailure, User>>? loginResult,
  }) {
    return LoginPresentationModel._()
      ..username = username ?? this.username
      ..password = password ?? this.password
      ..loginResult = loginResult ?? this.loginResult;
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get isLoginEnabled;
  bool get isLoginLoading;
}
