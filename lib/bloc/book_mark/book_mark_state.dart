// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:learn_bloc_2/models/news/article.dart';



abstract class BookMarkState {}

class BookMarkInitial extends BookMarkState {}

class BookMarkLoading extends BookMarkState {}

class BookMarkLoaded extends BookMarkState {
  final  List<Article> listArticle;
  BookMarkLoaded({
     required this.listArticle,
  });
}

class BookMarkError extends BookMarkState {
  final String error;

  BookMarkError({required this.error});
}
