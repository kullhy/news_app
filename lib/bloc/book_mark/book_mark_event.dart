import 'package:learn_bloc_2/models/news/article.dart';

abstract class BookMarkEvent {}

class GetBookMarkEvent extends BookMarkEvent {}

class SaveBookMarkEvent extends BookMarkEvent {
  final Article article;
  SaveBookMarkEvent(this.article);
}

class DeleteBookMarkEvent extends BookMarkEvent {
  final Article article;
  DeleteBookMarkEvent(this.article);
}

class DeleteAllBookMarkEvent extends BookMarkEvent {}
