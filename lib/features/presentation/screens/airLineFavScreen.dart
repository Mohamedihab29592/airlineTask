import 'package:air_line_task/features/presentation/controllers/favCubit/fav_state.dart';
import 'package:air_line_task/features/presentation/screens/airLineDetails.dart';
import 'package:air_line_task/features/presentation/widgets/mainWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utilies/appStrings.dart';
import '../../../core/utilies/colors.dart';
import '../../../core/utilies/constants.dart';
import '../../../core/utilies/values_manger.dart';
import '../controllers/favCubit/fav_cubit.dart';
import '../widgets/favWidget.dart';
import '../widgets/loadingWidget.dart';

class AirLineFavScreen extends StatelessWidget {
  const AirLineFavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavCubit, FavState>(
      builder: (context, state) {
        FavCubit cubit = FavCubit.get(context);

        if (cubit.airLineFav.isNotEmpty) {
          return SingleChildScrollView(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                height: 2,
                color: AppColors.teal,
              ),
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: cubit.airLineFav.length,
              itemBuilder: (context, index) {
                final fav = cubit.airLineFav[index];
                return Column(
                  children: [
                    FavWidget(
                      logo: fav['logoUrl'],
                      name: fav['name'],
                      site: fav['website'],
                      phone: fav['phone'],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cubit.deleteData(id: fav["id"]);

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      child:
                      const Icon(
                        Icons.favorite,
                        color: AppColors.red,
                      ),

                    ),
                  ],
                );
              },
            ),
          );
        } else if (state is AppLoadingState) {
          return const LoadingWidget();
        } else {
          return const SizedBox(
              height: AppSize.s400,
              child: Center(
                child: Text(AppStrings.noData),
              ));
        }
      },
    );
  }
}
