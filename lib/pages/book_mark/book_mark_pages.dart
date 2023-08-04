import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_2/bloc/book_mark/book_mark_event.dart';
import 'package:learn_bloc_2/gen/assets.gen.dart';
import 'package:learn_bloc_2/service/firebase_api.dart';

import '../../bloc/book_mark/book_mark_bloc.dart';
import '../../bloc/book_mark/book_mark_state.dart';
import '../../navigator/app_navigator.dart';
import '../../navigator/routes.dart';
import '../home/components/card_view_widget.dart';
import '../home/home_page.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/show_dialog.dart';
import '../widgets/spacer_custom.dart';
import 'components/book_mark_header_widget.dart';

class BookMarkPage extends StatelessWidget {
  const BookMarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    context.read<BookMarkBloc>().add((GetBookMarkEvent()));
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
        child: Column(
          children: [
            const BookMarkHeaderWidget(),
            const CustomHeightSpacer(),
            SearchBarWidget(
              textEditingController: textEditingController,
              onTap: () {},
            ),
            const CustomHeightSpacer(),
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<BookMarkBloc, BookMarkState>(
                    builder: (context, state) {
                  if (state is BookMarkError) {
                    voidShowDialog(
                      context: context,
                      content: state.error,
                      ontap: () {},
                      title: 'Error',
                    );
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is BookMarkLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.listArticle.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = state.listArticle[index].title!;
                        return Dismissible(
                          // dragStartBehavior: DragStartBehavior.s,
                          background: Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                          ),
                          secondaryBackground: Container(
                            decoration: const BoxDecoration(color: Colors.red),
                            child: Image.asset(
                              Assets.icons.deleteAll.path,
                              width: 10,
                              height: 10,
                              color: Colors.white,
                            ),
                          ),
                          key: Key(item),
                          child: CardViewWidget(
                            image: state.listArticle[index].urlToImage ??
                                urlDefaul,
                            name: state.listArticle[index].title!,
                            author: state.listArticle[index].author ??
                                state.listArticle[index].source!.name!,
                            onTap: () {
                              AppNavigator.push(Routes.detailPage,
                                  arguments: state.listArticle[index]);
                            },
                          ),
                          onDismissed: (direction) {
                            context.read<BookMarkBloc>().add(
                                (DeleteBookMarkEvent(
                                    state.listArticle[index])));
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  FireBaseApi().sendNotification();
                },
                child: const Text("Send"))
          ],
        ),
      ),
    );
  }
}
