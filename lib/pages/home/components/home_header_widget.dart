import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_2/bloc/get_user/get_user_bloc.dart';
import 'package:learn_bloc_2/bloc/get_user/get_user_state.dart';
import 'package:learn_bloc_2/bloc/noti/noti_state.dart';
import '../../../bloc/noti/noti_bloc.dart';
import '../../../bloc/noti/noti_event.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/utils.dart';

import 'round_icon_button_widget.dart';

bool isNoti = false;

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<NotiBloc>().add((SetNotiEvent()));
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
        Stack(
          children: [
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
            BlocBuilder<NotiBloc, NotiState>(builder: (context, state) {
              if (state is NotiLoaded) {
                return Visibility(
                  visible: state.isNoti,
                  child: Container(
                    alignment: Alignment.topRight,
                    height: 12,
                    width: 12,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              } else {
                return Visibility(
                  visible: isNoti ? true : false,
                  child: Container(
                    alignment: Alignment.topRight,
                    height: 12,
                    width: 12,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }
            })
          ],
        ),
      ],
    );
  }
}
