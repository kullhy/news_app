abstract class LogInEvent {}

class LoginEvent extends LogInEvent {
  String userName;
  String passWord;
  LoginEvent({
    required this.userName,
    required this.passWord,
  });
}
