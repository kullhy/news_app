import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_2/bloc/book_mark/book_mark_bloc.dart';
import 'package:learn_bloc_2/models/news/article.dart';

import '../../../bloc/book_mark/book_mark_event.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/utils.dart';
import '../../home/components/round_icon_button_widget.dart';
import '../../home/home_page.dart';
import '../../widgets/spacer_custom.dart';

// ignore: must_be_immutable
class DetailsHeaderWidget extends StatefulWidget {
  DetailsHeaderWidget({
    super.key,
    this.onTap,
    required this.isSaved,
    required this.article,
  });
  Article article;
  final Function()? onTap;
  bool isSaved;

  @override
  State<DetailsHeaderWidget> createState() => _DetailsHeaderWidgetState();
}

class _DetailsHeaderWidgetState extends State<DetailsHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    String dateTimeString =
        widget.article.publishedAt ?? "2023-07-30T00:40:00Z";
    DateTime dateTime = DateTime.parse(dateTimeString);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffbdbdbd),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.article.urlToImage ?? urlDefaul),
        ),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 45, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundIconButtonWidget(
                  iconName: Assets.icons.icBack.path,
                  iconColor: AppColors.backGroundColor,
                  iconWidth: 20,
                  iconHeight: 20,
                  borderColor: AppColors.borderColor,
                  onTap: widget.onTap,
                ),
                Container(
                  // frame3133166Sk (4:215)
                  width: 87,
                  height: 38,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0x99f1f1f1)),
                    borderRadius: BorderRadius.circular(72),
                  ),
                  child: Center(
                    child: Text(
                      widget.article.source!.name!,
                      textAlign: TextAlign.center,
                      style: SafeGoogleFont(
                        'Mulish',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const CustomHeightSpacer(
              size: 0.2,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.article.title},\n${dateTime.day}-${dateTime.month}",
                          style: SafeGoogleFont(
                            'Mulish',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                            color: const Color(0xffffffff),
                          ),
                        ),
                        Text(
                          "by ${widget.article.author ?? widget.article.source!.name!}",
                          style: SafeGoogleFont(
                            'Mulish',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ],
                    ),
                  ),
                  RoundIconButtonWidget(
                      iconName: widget.article.isBookMark!
                          ? Assets.icons.icSaved.path
                          : Assets.icons.icArchiveAdd.path,
                      iconColor: AppColors.backGroundColor,
                      iconWidth: 20,
                      iconHeight: 20,
                      borderColor: AppColors.borderColor,
                      onTap: () {
                        setState(() {
                          widget.article.isBookMark = true;
                        });
                        context
                            .read<BookMarkBloc>()
                            .add((SaveBookMarkEvent(widget.article)));
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
