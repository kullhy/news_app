import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:learn_bloc_2/bloc/get_user/get_user_event.dart';
import 'package:learn_bloc_2/bloc/get_user/get_user_state.dart';
import 'package:learn_bloc_2/models/user/user.dart';


class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  GetUserBloc() : super(GetUserInitial()) {
    on<GetUserDataEvent>(_getUser);
  }
  Future<void> _getUser(
      GetUserDataEvent event, Emitter<GetUserState> emit) async {
    emit(GetUserLoading());
    log("get data");
    try {
      String url = "https://reqres.in/api/users/2";
      var response = await http.get(Uri.parse(url));
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        final User user = User.fromJson(json);
        log("test data ${user.data!.firstName}");
        emit(GetUserLoaded(user: user));
      } else {
        throw Exception('Failed to load headlines');
      }
    } catch (e) {
      throw Exception('Failed to load headlines: $e');
    }
  }
}
