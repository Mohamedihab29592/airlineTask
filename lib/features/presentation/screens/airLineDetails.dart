import 'package:air_line_task/features/presentation/controllers/favCubit/fav_state.dart';
import 'package:air_line_task/features/presentation/widgets/detailsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utilies/colors.dart';
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
            child: Column(children: [
              DetailsWidget(name: airLine[index].name, image:airLine[index].logoURL,
                site: airLine[index].site, phone: airLine[index].phone,),
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
        )
    );
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
