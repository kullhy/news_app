import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/utils.dart';

import '../../bloc/search_news/search_news_bloc.dart';
import '../../bloc/search_news/search_news_event.dart';
import '../../bloc/search_news/search_news_state.dart';
import '../../navigator/app_navigator.dart';
import '../../navigator/routes.dart';
import '../../utils/constants/app_colors.dart';

import '../home/components/card_view_widget.dart';
import '../home/home_page.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/show_dialog.dart';
import '../widgets/spacer_custom.dart';
import 'widgets/search_header_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();

  int x = 20;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 45, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchHeaderWidget(),
              const CustomHeightSpacer(
                size: 0.03,
              ),
              SearchBarWidget(
                textEditingController: textEditingController,
                onTap: () {
                  log(textEditingController.text);
                  context.read<SearchNewsBloc>().add(
                        (SearchNewsDataEvent(
                          searchValue: textEditingController.text,
                        )),
                      );
                },
              ),
              const CustomHeightSpacer(
                size: 0.02,
              ),
              Text(
                'Result',
                style: SafeGoogleFont(
                  'Mulish',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                  color: const Color(0xff1a434e),
                ),
              ),
              SizedBox(
                height: 500,
                child: BlocBuilder<SearchNewsBloc, SearchNewsState>(
                    builder: (context, state) {
                  if (state is SearchNewsError) {
                    voidShowDialog(context:context,content: state.error, ontap: (){}, title: 'Error',);
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SearchNewsLoaded) {
                    return ListView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: state.listArticle.length > x
                          ? x
                          : state.listArticle.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardViewWidget(
                          image:
                              state.listArticle[index].urlToImage ?? urlDefaul,
                          name: state.listArticle[index].title!,
                          author: state.listArticle[index].author ??
                              state.listArticle[index].source!.name!,
                          onTap: () {
                            AppNavigator.push(Routes.detailPage,
                                arguments: state.listArticle[index]);
                          },
                        );
                      },
                    );
                  } else if (state is SearchNewsInitial) {
                    return Center(
                      child: Container(),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
