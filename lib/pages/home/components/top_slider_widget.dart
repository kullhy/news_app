import 'package:flutter/material.dart';
import 'package:learn_bloc_2/models/news/article.dart';
import 'package:learn_bloc_2/pages/home/home_page.dart';

import '../../../navigator/app_navigator.dart';
import '../../../navigator/routes.dart';
import '../../../utils/utils.dart';

class TopSliderWidget extends StatelessWidget {
  const TopSliderWidget(
      {super.key, required this.article, required this.isLoaded});

  final Article article;
  final bool isLoaded;

  @override
  Widget build(BuildContext context) {
    String dateTimeString = article.publishedAt ?? "2023-07-30T00:40:00Z";
    DateTime dateTime = DateTime.parse(dateTimeString);
    return InkWell(
      onTap: () {
        AppNavigator.push(
          Routes.detailPage,
          arguments: article,
        );
      },
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 132, 131, 131),
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              article.urlToImage ?? urlDefaul,
            ),
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: isLoaded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        '${article.title},\n${dateTime.day}-${dateTime.month} ',
                        style: SafeGoogleFont(
                          'Mulish',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                          color: const Color(0xffffffff),
                        ),
                        // maxLines: ,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "by ${article.author ?? article.source!.name!}",
                            style: SafeGoogleFont(
                              'Mulish',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                              color: const Color(0xffffffff),
                            ),
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ],
                  )
                : const Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
