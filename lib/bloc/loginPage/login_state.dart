abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSucces extends LoginState {
  final String token;

  LoginSucces({required this.token});
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}

class GlobalUnauthorized extends LoginState {}
