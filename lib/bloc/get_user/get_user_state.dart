// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../models/user/user.dart';

abstract class GetUserState {}

class GetUserInitial extends GetUserState {}

class GetUserLoading extends GetUserState {}

class GetUserLoaded extends GetUserState {
  final User user;
  GetUserLoaded({
    required this.user,
  });
}

class HomeError extends GetUserState {
  final String error;

  HomeError({required this.error});
}
