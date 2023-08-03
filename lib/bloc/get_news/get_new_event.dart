abstract class GetNewsEvent {}

class GetNewsDataEvent extends GetNewsEvent {}

class ChangeNewsTypeEvent extends GetNewsEvent {
  final String type;

  ChangeNewsTypeEvent(this.type);
}
