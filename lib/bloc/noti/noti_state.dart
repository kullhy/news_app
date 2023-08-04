abstract class NotiState {}

class NotiInitial extends NotiState {}

class NotiLoading extends NotiState {}

class NotiLoaded extends NotiState {
  final bool isNoti;

  NotiLoaded(this.isNoti);
}

class NotiError extends NotiState {
  final String error;

  NotiError({required this.error});
}
