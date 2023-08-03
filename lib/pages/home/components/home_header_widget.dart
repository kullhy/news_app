import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_2/bloc/get_user/get_user_bloc.dart';
import 'package:learn_bloc_2/bloc/get_user/get_user_state.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/utils.dart';

import 'round_icon_button_widget.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    log("header");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning',
              style: SafeGoogleFont(
                'Mulish',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.4,
                color: const Color(0xff94a5aa),
              ),
            ),
            BlocBuilder<GetUserBloc, GetUserState>(builder: (context, state) {
              if (state is GetUserLoaded) {
                log("${state.user.data!.firstName}");
                return Text(
                  "${state.user.data!.firstName} ${state.user.data!.lastName}",
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont(
                    'Mulish',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    color: const Color(0xff1a434e),
                  ),
                );
              } else {
                return Text(
                  '',
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont(
                    'Mulish',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    color: const Color(0xff1a434e),
                  ),
                );
              }
            })
          ],
        ),
        RoundIconButtonWidget(
          iconName: Assets.icons.icNotification.path,
          iconColor: AppColors.primaryColor,
          iconWidth: 20,
          iconHeight: 20,
          borderColor: AppColors.borderColor,
          onTap: () {
            // context.read<BookMarkBloc>().add((Book()));
          },
        ),
      ],
    );
  }
}
