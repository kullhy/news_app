abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class Logined extends LoginState {}


class LoginError extends LoginState {
  final String error;

  LoginError({required this.error});
}
