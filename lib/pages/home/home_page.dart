import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_2/bloc/get_news/get_new_bloc.dart';
import 'package:learn_bloc_2/bloc/get_news/get_new_state.dart';
import 'package:learn_bloc_2/models/news/article.dart';

import '../../gen/assets.gen.dart';
import '../../navigator/app_navigator.dart';
import '../../navigator/routes.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/utils.dart';
import '../widgets/show_dialog.dart';
import '../widgets/spacer_custom.dart';
import 'components/card_view_widget.dart';
import 'components/home_header_widget.dart';
import 'components/horizontal_category_list.dart';
import 'components/round_icon_button_widget.dart';
import 'components/top_slider_widget.dart';

String urlDefaul =
    "https://a2.espncdn.com/combiner/i?img=%2Fphoto%2F2023%2F0729%2Fr1203830_1296x729_16%2D9.jpg";

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 45, 24, 0),
          child: Column(
            children: [
              const HomeHeaderWidget(),
              const CustomHeightSpacer(
                size: 0.04,
              ),
              BlocBuilder<GetNewsBloc, GetNewsState>(builder: (context, state) {
                if (state is GetNewsLoading) {
                  return TopSliderWidget(
                    article: Article(),
                    isLoaded: false,
                  );
                } else if (state is GetNewsLoaded) {
                  return TopSliderWidget(
                    article: state.listArticle[0],
                    isLoaded: true,
                  );
                } else {
                  return TopSliderWidget(
                    article: Article(),
                    isLoaded: false,
                  );
                }
              }),
              const CustomHeightSpacer(
                size: 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover Hotest\nNews',
                    textAlign: TextAlign.start,
                    style: SafeGoogleFont(
                      'Mulish',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      color: const Color(0xff1a434e),
                    ),
                  ),
                  RoundIconButtonWidget(
                    iconName: Assets.icons.icSetting5.path,
                    iconColor: AppColors.primaryColor,
                    iconWidth: 20,
                    iconHeight: 20,
                    borderColor: AppColors.borderColor,
                    onTap: () {},
                  ),
                ],
              ),
              const CustomHeightSpacer(
                size: 0.02,
              ),
              const HorizontalCategoryList(),
              BlocBuilder<GetNewsBloc, GetNewsState>(builder: (context, state) {
                if (state is GetNewsError) {
                  voidShowDialog(context:context,content: state.error, ontap: (){}, title: 'Error',);
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetNewsLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.listArticle.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CardViewWidget(
                        image: state.listArticle[index].urlToImage ?? urlDefaul,
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
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
