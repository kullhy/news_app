import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_2/bloc/search_news/search_news_event.dart';
import 'package:learn_bloc_2/bloc/search_news/search_news_state.dart';

import 'package:learn_bloc_2/models/news/article.dart';
import 'package:learn_bloc_2/service/search_news_data.dart';

class SearchNewsBloc extends Bloc<SearchNewsEvent, SearchNewsState> {
  SearchNewsBloc() : super(SearchNewsInitial()) {
    on<SearchNewsDataEvent>(_searchNewData);
    on<MoreEvent>(_moreSearchNewData);
  }
  int count = 20;

  Future<void> _searchNewData(
      SearchNewsDataEvent event, Emitter<SearchNewsState> emit) async {
    emit(SearchNewsLoading());
    log("search...${event.searchValue}");
    try {
      final List<Article> listArticle = await searchNewsData(event.searchValue);
      emit(SearchNewsLoaded(
        listArticle: listArticle,
        x: count,
      ));
    } catch (e) {
      emit(SearchNewsError(error: e.toString()));
    }
  }
  Future<void> _moreSearchNewData(
      MoreEvent event, Emitter<SearchNewsState> emit) async {
    emit(SearchNewsLoading());

    try {
      final List<Article> listArticle = await searchNewsData(event.searchValue);
      emit(SearchNewsLoaded(
        listArticle: listArticle,
        x: count+20
      ));
    } catch (e) {
      emit(SearchNewsError(error: e.toString()));
    }
  }
}
