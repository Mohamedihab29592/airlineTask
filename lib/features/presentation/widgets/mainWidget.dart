import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utilies/colors.dart';
import '../../../core/utilies/constants.dart';
import '../../../core/utilies/values_manger.dart';
import '../../domain/entities/airlineEntity.dart';
import '../screens/airLineDetails.dart';



class MainWidget extends StatelessWidget {
  final List<AirLine> airLine;
  const MainWidget({Key? key, required this.airLine, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
      slivers:<Widget>[
        _getSliver(airLine,context),
      ]
    );
  }
}

SliverList _getSliver(List myList, BuildContext context) {
  return SliverList(
    delegate: SliverChildBuilderDelegate((BuildContext context, int index){
      return Padding(
        padding: const EdgeInsets.all(AppSize.s20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              padding: const EdgeInsets.only(right: AppSize.s8),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(airLine: myList, index: index,)));
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(AppSize.s8)),
                  child: CachedNetworkImage(
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    imageUrl:
                    ApiConstants.imageUrl(myList[index].logoURL),
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[850]!,
                      highlightColor: Colors.grey[800]!,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                          BorderRadius.circular(AppSize.s8),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Text(
              myList[index].name,
              style: const TextStyle(
                fontSize: AppSize.s20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSize.s20,),
            const Divider(height: 2,color: AppColors.teal,)

          ],
        ),
      );
  },
    childCount : myList.length,
  ),
  );

}










