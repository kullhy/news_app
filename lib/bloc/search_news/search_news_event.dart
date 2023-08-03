abstract class SearchNewsEvent {}

class SearchNewsDataEvent extends SearchNewsEvent {
  final String searchValue;
  SearchNewsDataEvent({required this.searchValue});
}

class MoreEvent extends SearchNewsEvent {
  final String searchValue;
  MoreEvent({required this.searchValue});
}
