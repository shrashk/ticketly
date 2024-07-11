import 'package:flutter/material.dart';

class AppStrings {
  static const String enterKeywords = "Please enter some keywords to get the results";
  static const String loadingData = "Loading data...";
  static const String dataFetched = "Data fetched successfully!";
  static const String noResults = "No results found. Please search with a different keyword.";
  static const String errorOccurred = "An error occurred. Please try again.";
  static const String searchHint = "Search start point";
  static const String bestMatch = "Best Match";
  static const String typePrefix = "Type: ";
  static const String localityPrefix = "Locality: ";
  static const String additionalInfoPrefix = "Additional info: ";
  static const String somethingWentWrong = "Something went wrong.";
}

class AppBorders {
  static BorderRadius listItemBorderRadius = BorderRadius.circular(10);
  static BorderRadius badgeBorderRadius = BorderRadius.circular(6);
}

class AppConstants {
  static const double padding = 12.0;
  static const double listItemPaddingVertical = 5.0;
  static const double listTopPadding = 90.0;
  static const double listItemPaddingHorizontal = 8.0;
  static const double listItemSeparatorHeight = 8.0;
  static const double searchInputTopPositionFocused = 10.0;
  static const double searchInputHeightOffset = 25.0;
  static const Duration searchDebounceDuration = Duration(milliseconds: 800);
  static const Duration searchInputAnimationDuration = Duration(milliseconds: 500);
}
