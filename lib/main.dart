import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:learn_bloc_2/bloc/book_mark/book_mark_bloc.dart';
import 'package:learn_bloc_2/bloc/get_news/get_new_bloc.dart';
import 'package:learn_bloc_2/bloc/get_user/get_user_bloc.dart';
import 'package:learn_bloc_2/bloc/login/login_bloc.dart';
import 'package:learn_bloc_2/bloc/search_news/search_news_bloc.dart';
import 'package:learn_bloc_2/bloc/splash/splash_bloc.dart';
import 'package:learn_bloc_2/pages/details/details_page.dart';
import 'package:learn_bloc_2/pages/home/components/home_header_widget.dart';
import 'package:learn_bloc_2/pages/home/home_page.dart';
import 'package:learn_bloc_2/pages/login/login_page.dart';
import 'package:learn_bloc_2/pages/search/search_page.dart';
import 'package:learn_bloc_2/pages/splash/splash_page.dart';
import 'package:learn_bloc_2/service/firebase_api.dart';

import 'bloc/get_news/get_new_event.dart';
import 'bloc/get_user/get_user_event.dart';
import 'firebase_options.dart';
import 'models/news/article.dart';
import 'navigator/app_navigator.dart';
import 'navigator/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FireBaseApi().initNotifications();
  setupServiceLocator();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => SplashBloc(), child: const SplashPage()),
    BlocProvider(
      create: (context) => LoginBloc(),
      child: const LoginPage(),
    ),
    BlocProvider(
        create: (context) => GetUserBloc(), child: const HomeHeaderWidget()),
    BlocProvider(
      create: (context) => GetNewsBloc(),
      child: const HomePage(),
    ),
    BlocProvider(
      create: (context) => BookMarkBloc(),
      child: DetailsPage(article: Article()),
    ),
    BlocProvider(
      create: (context) => SearchNewsBloc(),
      child: const SearchPage(),
    )
  ], child: const MyApp()));
}

final getIt = GetIt.instance;
void setupServiceLocator() {
  // getIt.registerLazySingleton<WeatherBloc>(
  //     () => WeatherBloc(httpClient: http.Client()));
  // getIt.registerLazySingleton<CheckWeatherBloc>(() => CheckWeatherBloc());
}

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GetNewsBloc>().add((GetNewsDataEvent()));
    context.read<GetUserBloc>().add((GetUserDataEvent()));

    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      onGenerateRoute: AppNavigator.getRoute,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
      initialRoute: Routes.splashPage,
      title: 'News',
    );
  }
}
