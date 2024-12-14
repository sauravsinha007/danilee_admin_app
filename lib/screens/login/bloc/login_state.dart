part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => <Object?>[];
}

class LoginStateInitial extends LoginState {
  const LoginStateInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  const LoginSuccess({
    required this.loginData,
  });

  final LoginData loginData;

  @override
  List<Object?> get props => <Object?>[];
}

class LoginFailed extends LoginState {
  const LoginFailed({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => <Object?>[errorMessage];
}
