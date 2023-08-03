import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:learn_bloc_2/pages/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>(_login);
  }

  Future<void> _login(LoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('POST', Uri.parse('https://reqres.in/api/login'));
      request.body =
          json.encode({"email": event.userName, "password": event.passWord});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        emit(Logined());
        if (rememberMe) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLogin', true);
        }
      } else {
        emit(LoginError(error: response.statusCode.toString()));
      }
    } catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }
}
