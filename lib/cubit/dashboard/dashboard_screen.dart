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
  final TextEditingController _controller = TextEditingController();
  StreamSubscription<DashboardState>? _textSubscription;
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
     // Subscribe to text updates from the DashboardCubit's stream.
    _subscribeToTextUpdates();
  }

  void _subscribeToTextUpdates() {
    _textSubscription = context.read<DashboardCubit>().stream.listen((state) {
      if (state is DashboardLoaded) {
         // If the text in the search input (_controller.text) is different from
        // the text in the state (state.textInSearch), update the controller's text.
      
        if (_controller.text != state.textInSearch) {
          _controller.text = state.textInSearch;
          setState(() {});
        }
      }
    });
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
      // The Timer calls the search method of the DashboardCubit with the trimmed value.
      searchOnStoppedTyping = Timer(duration, () => context.read<DashboardCubit>().search(value.trim()));
    }
  }

  //Function to hide the keyboard when user scrolls the list
  void _onScroll() {
    if (_focusNode.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  //Function to trigger _isSearchTapped bool
  //Initially when textfield is inactive it is placed at the center
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
    _textSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            //Result from the search list
            SearchResultList(
              scrollController: scrollController,
            ),
            //Search textfield - position updates when tapped
            AnimatedSearchInput(
              isSearchTapped: _isSearchTapped,
              controller: _controller,
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
              listener: (context, state) {
                //Error state
                //only placed in listener - not part of UI declaration
                if (state is DashboardError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(AppStrings.errorOccurred)),
                  );
                }
              },
              builder: (context, state) {
                //Loading state
                if (state is DashboardLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                //Success state
                else if (state is DashboardLoaded) {
                  return LocationsList(
                    scrollController: scrollController,
                  );
                }
                //default state
                else {
                  return const Center(child: SizedBox());
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
          separatorBuilder: (context, index) => const SizedBox(height: AppConstants.listItemSeparatorHeight),
          itemBuilder: (context, index) {
            final location = state.apiResponse.locations[index];
            return GestureDetector(
                onTap: () {
                  context.read<DashboardCubit>().selectPoint(locationPoint: location.name);
                },
                child: MatchThumbnail(location: location));
          },
        ),
      );
    }
    return const SizedBox();
  }
}

//StatelessWidget that animates its position when a search input is tapped.
class AnimatedSearchInput extends StatelessWidget {
  final bool isSearchTapped;
  // A focus node that manages the focus state of the search input field.
  // Is required to manipulate the keyboard focus/unfocus functionality
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const AnimatedSearchInput({super.key, required this.isSearchTapped, required this.focusNode, required this.onChanged, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Returns an AnimatedPositioned widget which animates its position based
    // on the value of isSearchTapped. Center at beginning and top when tapped
    return AnimatedPositioned(
      duration: AppConstants.searchInputAnimationDuration,
      // Top position of the widget, changes based on whether the search input is tapped.
      top: isSearchTapped ? 10 : MediaQuery.of(context).size.height / 2 - 50,
      left: 20,
      right: 20,
      child: SearchInput(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
      ),
    );
  }
}
