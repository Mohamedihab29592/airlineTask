import 'package:air_line_task/features/presentation/controllers/themeMode/theme_mode_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeModeCubit extends Cubit<ThemeModeState> {
  ThemeModeCubit() : super(ThemeModeInitial());

  static ThemeModeCubit get(context) => BlocProvider.of(context);

  bool isDarkMode = false;

  void changeAppMode({ bool ? fromShared})async {
    if (fromShared != null) {
      isDarkMode = fromShared;
    } else {
      isDarkMode = !isDarkMode;
      final sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setBool('isDarkMode',  isDarkMode).then((value) {
        emit(ChangeAppModeSuccess());


      });
    }
  }
}

