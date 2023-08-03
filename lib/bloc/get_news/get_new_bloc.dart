import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:learn_bloc_2/models/news/article.dart';
import 'package:learn_bloc_2/service/fetch_news_data.dart';

import '../../service/fetch_news_with_type.dart';
import 'get_new_event.dart';
import 'get_new_state.dart';

class GetNewsBloc extends Bloc<GetNewsEvent, GetNewsState> {
  GetNewsBloc() : super(GetNewsInitial()) {
    on<GetNewsDataEvent>(_fetchNewData);
    on<ChangeNewsTypeEvent>(_changeNewType);
  }
  Future<void> _changeNewType(
      ChangeNewsTypeEvent event, Emitter<GetNewsState> emit) async {
    emit(GetNewsLoading());
    try {
      final List<Article> listArticle = await fetchNewsType(event.type);
      emit(GetNewsLoaded(listArticle: listArticle));
    } catch (e) {
      emit(GetNewsError(error: e.toString()));
    }
  }

  Future<void> _fetchNewData(
      GetNewsDataEvent event, Emitter<GetNewsState> emit) async {
    emit(GetNewsLoading());
    try {
      final List<Article> listArticle = await fetchHeadline();
      emit(GetNewsLoaded(listArticle: listArticle));
    } catch (e) {
      emit(GetNewsError(error: e.toString()));
    }
  }
}
