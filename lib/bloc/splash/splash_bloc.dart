import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_2/bloc/splash/splash_event.dart';
import 'package:learn_bloc_2/bloc/splash/splash_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<CheckLoginEvent>(_checkLogin);
  }

  Future<void> _checkLogin(
      CheckLoginEvent event, Emitter<SplashState> emit) async {
    emit(SplashLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLogin = prefs.getBool('isLogin') ?? false;
      log(isLogin.toString());
      if (isLogin == true) {
        emit(SplashLogin());
      } else {
        emit(SplashUnLogin());
      }
      log(state.toString());
    } catch (e) {
      emit(SplashError(error: e.toString()));
    }
  }
}
