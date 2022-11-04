import 'package:air_line_task/core/utilies/values_manger.dart';
import 'package:air_line_task/features/presentation/controllers/bloc/air_line_bloc.dart';
import 'package:air_line_task/features/presentation/controllers/bloc/air_line_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utilies/appStrings.dart';
import '../../../core/utilies/colors.dart';
import '../controllers/themeMode/theme_mode_cubit.dart';



class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key, }) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}




class _HomeLayoutState extends State<HomeLayout> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AirLineBloc, AirLineState>(
        builder: (context, state) {
          AirLineBloc bloc = AirLineBloc.get(context);
          return Scaffold(
            body: bloc.screens[bloc.currentIndex],
            bottomNavigationBar: Scaffold(
              appBar:  AppBar(
                toolbarHeight: AppSize.s100,
                actions: [
                  IconButton(
                    onPressed: () {
                      ThemeModeCubit.get(context).changeAppMode();
                    },
                    icon: const Icon(Icons.brightness_4),
                  ),
                ],
                centerTitle: true,
                title: const Text(AppStrings.appName),
              ),
              body: bloc.screens[bloc.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                elevation: 20,
                selectedItemColor: AppColors.teal,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: AppColors.grey,
                currentIndex: bloc.currentIndex,
                onTap: (index) => setState(() => bloc.currentIndex = index),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu_rounded),
                    label: AppStrings.main,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border),
                    label: AppStrings.favorite,
                  ),

                ],
              ),
            ),
          );
        });
  }
}
