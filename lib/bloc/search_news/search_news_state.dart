import 'package:learn_bloc_2/models/news/article.dart';

abstract class SearchNewsState {}

class SearchNewsInitial extends SearchNewsState {}

class SearchNewsLoading extends SearchNewsState {}

class SearchNewsLoaded extends SearchNewsState {
  final List<Article> listArticle;
  final int x;
  SearchNewsLoaded( {
    required this.listArticle,required this.x,
  });
}

class SearchNewsError extends SearchNewsState {
  final String error;

  SearchNewsError({required this.error});
}
