import 'package:flutter/material.dart';
import 'package:ticketly/constants.dart';
import 'package:ticketly/models/api_response.dart';
import 'package:ticketly/theme/colors.dart';
import 'package:ticketly/theme/styles.dart';

class MatchThumbnail extends StatelessWidget {
  final Location location;

  const MatchThumbnail({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.listItemBackground,
        borderRadius: AppBorders.listItemBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppConstants.listItemPaddingVertical,
          horizontal: AppConstants.listItemPaddingHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (location.isBest) const BestMatchBadge(),
            LocationName(name: location.name),
            LocationTypeBadge(type: location.type),
            LocationParent(parentType: location.parent.type, parentName: location.parent.name),
            if (location.properties != null) AdditionalInfo(properties: location.properties!)
          ],
        ),
      ),
    );
  }
}

class BestMatchBadge extends StatelessWidget {
  const BestMatchBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppBorders.badgeBorderRadius,
          color: AppColors.bestMatchBadgeBackground,
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 2.0,
            horizontal: 4.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star,
                size: 16,
                color: AppColors.starIcon,
              ),
              SizedBox(width: 3),
              Text(
                AppStrings.bestMatch,
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationName extends StatelessWidget {
  final String name;

  const LocationName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: AppStyles.listItemTitle,
    );
  }
}

class LocationTypeBadge extends StatelessWidget {
  final String type;

  const LocationTypeBadge({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppBorders.badgeBorderRadius,
          color: AppColors.typeBadgeBackground,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6.0,
            vertical: 2.0,
          ),
          child: Text(
            "${AppStrings.typePrefix}$type",
            style: AppStyles.type,
          ),
        ),
      ),
    );
  }
}

class LocationParent extends StatelessWidget {
  final String parentType;
  final String parentName;

  const LocationParent({super.key, required this.parentType, required this.parentName});

  @override
  Widget build(BuildContext context) {
    return Text(
      parentType == "locality" ? "${AppStrings.localityPrefix}$parentName" : "",
      style: AppStyles.listItemSubtitle,
    );
  }
}

class AdditionalInfo extends StatelessWidget {
  final AdditionalProp properties;

  const AdditionalInfo({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: AppColors.divider),
        Row(
          children: [
            const Text(
              AppStrings.additionalInfoPrefix,
              style: AppStyles.listItemInfo,
            ),
            Flexible(
              child: Text(
                properties.mainLocality,
                style: AppStyles.listItemInfo,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
