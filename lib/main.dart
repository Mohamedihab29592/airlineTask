import 'package:air_line_task/core/error/internetCheck.dart';
import 'package:air_line_task/core/utilies/appStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/utilies/themes.dart';
import 'core/service/service_locator.dart'as di;
import 'features/presentation/controllers/bloc/air_line_bloc.dart';
import 'features/presentation/controllers/bloc/air_line_event.dart';
import 'features/presentation/controllers/favCubit/fav_cubit.dart';
import 'features/presentation/controllers/themeMode/theme_mode_cubit.dart';
import 'features/presentation/controllers/themeMode/theme_mode_state.dart';
import 'features/presentation/screens/layout.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await NetworkInfoImpl().checkInternet();
   await di.init();
  final sharedPreferences = await SharedPreferences.getInstance();

  bool? isDarkMode = sharedPreferences.getBool("isDarkMode") ?? false;

  runApp(  MyApp(isDarkMode: isDarkMode,));
}

class MyApp extends StatelessWidget {
  final bool ? isDarkMode;


  const MyApp({super.key,  this.isDarkMode, });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>di.sl<AirLineBloc>()..add(GetAirLineEvent()),
        ),
        BlocProvider(
          create: (context) => ThemeModeCubit()..changeAppMode(fromShared: isDarkMode),
        ),
        BlocProvider(
          create: (context) => FavCubit()..iniDatabase(),
        ),

      ],
      child: BlocBuilder<ThemeModeCubit, ThemeModeState>(
        builder: (context, state) {
          return MaterialApp(
            themeMode: ThemeModeCubit
                .get(context)
                .isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            darkTheme: AppThemes.darkMode,
            theme: AppThemes.lightMode,
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            home:  const HomeLayout(),
          );
        },
      ),
    );
  }
}


