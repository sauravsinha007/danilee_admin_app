import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../clients/login/login_client.dart';
import '../../../clients/login/models/login_response.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginStateInitial()) {
    on<LoginSubmitted>(_login);
  }

  final LoginClient _loginClient = LoginClient();

  Future<void> _login(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    await _loginClient.login(
      email: event.email,
      password: event.password,
      onSuccess: (LoginData loginData) {
        emit(LoginSuccess(loginData: loginData));
      },
      onError: (String errorMessage) {
        emit(LoginFailed(errorMessage: errorMessage));
      },
    );
  }
}
