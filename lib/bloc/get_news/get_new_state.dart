// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:learn_bloc_2/models/news/article.dart';



abstract class GetNewsState {}

class GetNewsInitial extends GetNewsState {}

class GetNewsLoading extends GetNewsState {}

class GetNewsLoaded extends GetNewsState {
  final  List<Article> listArticle;
  GetNewsLoaded({
     required this.listArticle,
  });
}

class GetNewsError extends GetNewsState {
  final String error;

  GetNewsError({required this.error});
}
