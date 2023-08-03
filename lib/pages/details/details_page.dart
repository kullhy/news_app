// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:learn_bloc_2/models/news/article.dart';
import 'package:learn_bloc_2/navigator/app_navigator.dart';
import 'package:learn_bloc_2/pages/details/widgets/details_header_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/utils.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
    required this.article,
  }) : super(key: key);
  final Article article;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailsHeaderWidget(
                article: article,
                onTap: () {
                  AppNavigator.pop();
                }, isSaved: false,),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
              child: Text(
                article.description!,
                style: SafeGoogleFont(
                  'Mulish',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.8,
                  color: const Color(0xff95a6aa),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5),
              child: Text(
                article.content ?? "",
                style: SafeGoogleFont(
                  'Mulish',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.8,
                  color: const Color(0xff95a6aa),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
              child: InkWell(
                onTap: () async {
                  if (!await launchUrl(Uri.parse(article.url!))) {
                    throw Exception('Could not launch ');
                  }
                },
                child: Text(
                  'View detail >>',
                  style: SafeGoogleFont(
                    'Mulish',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    color: const Color(0xff1a434e),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
