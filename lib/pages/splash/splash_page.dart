import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_2/bloc/splash/splash_bloc.dart';
import 'package:learn_bloc_2/bloc/splash/splash_state.dart';

import '../../bloc/splash/splash_event.dart';
import '../../navigator/app_navigator.dart';
import '../../navigator/routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashBloc>().add((CheckLoginEvent()));
    return Column(
      children: [
        const Center(
            child: Image(
          image: AssetImage("assets/images/splash.png"),
          height: 100,
        )),
        BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashUnLogin) {
              AppNavigator.pushAndRemoveUntil(Routes.logInPage);
            }
            if (state is SplashLogin) {
              AppNavigator.pushAndRemoveUntil(Routes.homePage);
            }
          },
          child: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              if (state is SplashLoading) {
                return const CircularProgressIndicator();
              } else if (state is SplashError) {
                return Text("lỗi : ${state.error}");
              } else {
                return Container();
              }
            },
          ),
        )
      ],
    );
  }
}
