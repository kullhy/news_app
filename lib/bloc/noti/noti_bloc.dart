import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'noti_event.dart';
import 'noti_state.dart';


class NotiBloc extends Bloc<NotiEvent, NotiState> {
  NotiBloc() : super(NotiInitial()) {
    on<RemoveNotiEvent>(_removeNoti);
    on<SetNotiEvent>(_setNoti);
  }

  Future<void> _setNoti(
      SetNotiEvent event, Emitter<NotiState> emit) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isNoti = prefs.getBool('isNoti') ?? false;
      emit(NotiLoaded(isNoti));
    } catch (e) {
      emit(NotiError(error: e.toString()));
    }
  }

  Future<void> _removeNoti(
      RemoveNotiEvent event, Emitter<NotiState> emit) async {
    emit(NotiLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLogin', false);
      emit(NotiLoaded(false));
    } catch (e) {
      emit(NotiError(error: e.toString()));
    }
  }
}
