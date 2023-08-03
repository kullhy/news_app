import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_2/navigator/app_navigator.dart';

import '../../../bloc/book_mark/book_mark_bloc.dart';
import '../../../bloc/book_mark/book_mark_event.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/utils.dart';
import '../../home/components/round_icon_button_widget.dart';
import '../../widgets/show_dialog.dart';

class BookMarkHeaderWidget extends StatelessWidget {
  const BookMarkHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Book Mark\nNews',
          style: SafeGoogleFont(
            'Mulish',
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1.3,
            color: const Color(0xff1a434e),
          ),
        ),
        RoundIconButtonWidget(
          iconName: Assets.icons.deleteAll.path,
          iconColor: AppColors.primaryColor,
          iconWidth: 30,
          iconHeight: 30,
          borderColor: AppColors.borderColor,
          onTap: () {
            voidShowDialog(
              context: context,
              content: "You definitely want to delete them all?",
              ontap: () {
                context.read<BookMarkBloc>().add(
                      (DeleteAllBookMarkEvent()),
                    );
                AppNavigator.pop();
              },
              title: 'DeleteAll',
            );
          },
        ),
      ],
    );
  }
}
