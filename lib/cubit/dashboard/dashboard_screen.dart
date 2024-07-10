import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketly/constants.dart';
import 'package:ticketly/cubit/dashboard/dashboard_cubit.dart';
import 'package:ticketly/cubit/dashboard/dashboard_state.dart';
import 'package:ticketly/theme/colors.dart';
import 'package:ticketly/widgets/match_thumbnail.dart';
import 'package:ticketly/widgets/search_input.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = "/";
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  final ScrollController scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  late Timer searchOnStoppedTyping;
  bool _isSearchTapped = false;
  

  @override
  void initState() {
    super.initState();
    searchOnStoppedTyping = Timer(Duration.zero, () {});
    //listener to handle focus changes
    _focusNode.addListener(_handleFocusChange);
    //listener to handle scroll events on the scroll controller
    scrollController.addListener(_onScroll);
  }

  void _handleSearchChange(String value) {
  /*Duration to wait after the user stops typing before triggering a search.
    This helps in reducing network calls on every character input and ensures
    that the search request is only sent after a brief pause when the user
    finishes typing or pauses briefly.*/
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping.isActive) {
      searchOnStoppedTyping.cancel();
    }
    if (value.isNotEmpty) {
      searchOnStoppedTyping = Timer(
          duration, () => context.read<DashboardCubit>().search(value.trim()));
    }
  }
  //Function to hide the keyboard when user scrolls the list
  void _onScroll() {
    if (_focusNode.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
  //Function to trigger _isSearchTapped bool
  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      setState(() {
        _isSearchTapped = true;
      });
    }
  }

  @override
  void dispose() {
    if (searchOnStoppedTyping.isActive) {
      searchOnStoppedTyping.cancel();
    }
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            SearchResultList(
              scrollController: scrollController,
            ),
            AnimatedSearchInput(
              isSearchTapped: _isSearchTapped,
              focusNode: _focusNode,
              onChanged: _handleSearchChange,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResultList extends StatelessWidget {
  final ScrollController scrollController;
  const SearchResultList({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: Column(
        children: [
          Expanded(
            child: BlocConsumer<DashboardCubit, DashboardState>(
              builder: (context, state) {
                if (state is DashboardLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DashboardLoaded) {
                  return LocationsList(
                    scrollController: scrollController,
                  );
                } else if (state is DashboardError) {
                  return const Center(child: Text(AppStrings.errorOccurred));
                } else {
                  return const Center(child: Text(AppStrings.enterKeywords));
                }
              },
              listener: (context, state) {
                if (state is DashboardError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(AppStrings.errorOccurred)),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LocationsList extends StatelessWidget {
  final ScrollController scrollController;
  const LocationsList({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DashboardCubit>().state;
    if (state is DashboardLoaded) {
      return Padding(
        padding: const EdgeInsets.only(top: AppConstants.listTopPadding),
        child: ListView.separated(
          controller: scrollController,
          itemCount: state.apiResponse.locations.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppConstants.listItemSeparatorHeight),
          itemBuilder: (context, index) {
            final location = state.apiResponse.locations[index];
            return MatchThumbnail(location: location);
          },
        ),
      );
    }
    return const SizedBox();
  }
}

class AnimatedSearchInput extends StatelessWidget {
  final bool isSearchTapped;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const AnimatedSearchInput({
    super.key,
    required this.isSearchTapped,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: AppConstants.searchInputAnimationDuration,
      top: isSearchTapped ? 10 : MediaQuery.of(context).size.height / 2 - 25,
      left: 20,
      right: 20,
      child: SearchInput(
        focusNode: focusNode,
        onChanged: onChanged,
      ),
    );
  }
}
