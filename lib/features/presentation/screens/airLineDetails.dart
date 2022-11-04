import 'package:air_line_task/features/presentation/controllers/favCubit/fav_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utilies/colors.dart';
import '../../../../core/utilies/constants.dart';
import '../../../../core/utilies/values_manger.dart';
import '../../../core/utilies/appStrings.dart';
import '../../data/models/airLineModel.dart';
import '../controllers/favCubit/fav_cubit.dart';

class DetailsScreen extends StatelessWidget {
  final List airLine;
  final int index;

  const DetailsScreen({
    Key? key,
    required this.airLine,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(AppSize.s10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                airLine[index].name,
                style: const TextStyle(fontSize: AppSize.s40),
              ),
              Container(
                padding: const EdgeInsets.only(right: AppSize.s8),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(AppSize.s8)),
                  child: CachedNetworkImage(
                    height: AppSize.s250,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    imageUrl: ApiConstants.imageUrl(airLine[index].logoURL),
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[850]!,
                      highlightColor: Colors.grey[800]!,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(AppSize.s8),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s15),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: AppSize.s2,
                  horizontal: AppSize.s8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.teal,
                  borderRadius: BorderRadius.circular(AppSize.s4),
                ),
                child: TextButton(
                  onPressed: () async {
                    var url = Uri.parse(airLine[index].site);
                    webView(url);
                  },
                  child: Text(
                    airLine[index].site,
                    style: const TextStyle(
                        color: AppColors.white, fontSize: AppSize.s20),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s15),
              if (airLine[index].phone != AppStrings.empty)
                Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSize.s2,
                      horizontal: AppSize.s8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.teal,
                      borderRadius: BorderRadius.circular(AppSize.s4),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        makePhoneCall(airLine[index].phone);
                      },
                      child: Text(
                        airLine[index].phone,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: AppSize.s16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ))
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSize.s2,
                    horizontal: AppSize.s8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.teal,
                    borderRadius: BorderRadius.circular(AppSize.s4),
                  ),
                  child: const Text(
                    AppStrings.noPhone,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: AppSize.s16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              BlocBuilder<FavCubit, FavState>(
                builder: (context, state) {
                  FavCubit cubit = FavCubit.get(context);
                  bool isFav = false;
                  int ? id ;
                  for (var element in cubit.airLineFav) {
                    if (element["name"] == airLine[index].name) {
                      isFav = true;
                      id = element['id'];
                    }
                  }

                  return ElevatedButton(
                    onPressed: () {
                      if (isFav && id!=null) {
                        cubit.deleteData(id: id);
                      } else {
                        cubit.insertDatabase(
                          name: airLine[index].name,
                          phone: airLine[index].phone,
                          site: airLine[index].site,
                          logoUrl: airLine[index].logoURL,
                          code: airLine[index].code,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    child: isFav
                        ?const  Icon(Icons.favorite,color: AppColors.red,)
                        :const Icon(Icons.favorite_border_outlined,),
                  );
                },
              )
            ],
          ),
        )));
  }
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Future<void> webView(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.inAppWebView,
    webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
  )) {
    throw 'Could not launch $url';
  }
}
