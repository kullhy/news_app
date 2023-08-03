import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:learn_bloc_2/models/news/article.dart';

import '../../service/sqlite.dart';
import 'book_mark_event.dart';
import 'book_mark_state.dart';

class BookMarkBloc extends Bloc<BookMarkEvent, BookMarkState> {
  BookMarkBloc() : super(BookMarkInitial()) {
    on<GetBookMarkEvent>(_getBookMark);
    on<SaveBookMarkEvent>(_saveBookMark);
    on<DeleteBookMarkEvent>(_deleteBookMark);
    on<DeleteAllBookMarkEvent>(_deleteAllBookMark);
  }
  Future<void> _getBookMark(
      GetBookMarkEvent event, Emitter<BookMarkState> emit) async {
    emit(BookMarkLoading());
    final List<Article> savedArticles =
        await DatabaseHelper.instance.getArticles();
    log(savedArticles[0].source!.id.toString());
    emit(BookMarkLoaded(listArticle: savedArticles));
  }

  Future<void> _saveBookMark(
      SaveBookMarkEvent event, Emitter<BookMarkState> emit) async {
    await DatabaseHelper.instance.insertArticle(event.article);
    // emit(BookMarkLoaded(listArticle: []));
  }

  Future<void> _deleteBookMark(
      DeleteBookMarkEvent event, Emitter<BookMarkState> emit) async {
    event.article.isBookMark = false;
    await DatabaseHelper.instance.deleteArticle(event.article);
  }

  Future<void> _deleteAllBookMark(
      DeleteAllBookMarkEvent event, Emitter<BookMarkState> emit) async {
    await DatabaseHelper.instance.deleteAllArticles();
    emit(BookMarkLoaded(listArticle: []));
  }
}
