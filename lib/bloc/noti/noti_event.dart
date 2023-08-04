abstract class NotiEvent {}

class RemoveNotiEvent extends NotiEvent {
  final bool isNoti;

  RemoveNotiEvent(this.isNoti);
}

class SetNotiEvent extends NotiEvent {
}
