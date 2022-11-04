import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utilies/appStrings.dart';
import '../../../core/utilies/colors.dart';
import '../../../core/utilies/constants.dart';
import '../../../core/utilies/values_manger.dart';
import '../screens/airLineDetails.dart';

class DetailsWidget extends StatelessWidget {
  final String name;
  final String image;
  final String site;
  final String phone;
  const DetailsWidget({Key? key, required this.name, required this.image, required this.site, required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.all(AppSize.s10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
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
                imageUrl: ApiConstants.imageUrl(image),
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
                var url = Uri.parse(site);
                webView(url);
              },
              child: Text(
                site,
                style: const TextStyle(
                    color: AppColors.white, fontSize: AppSize.s20),
              ),
            ),
          ),
          const SizedBox(height: AppSize.s15),
          if (phone != AppStrings.empty)
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
                    makePhoneCall(phone);
                  },
                  child: Text(
               phone,
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
              child:  const Text(
                AppStrings.noPhone,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: AppSize.s16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

        ],
      ),
    );
  }
}
