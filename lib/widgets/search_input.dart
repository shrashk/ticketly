import 'package:flutter/material.dart';
import 'package:ticketly/constants.dart';

class SearchInput extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;
  final TextEditingController controller;

  const SearchInput({super.key, required this.onChanged, required this.focusNode, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        hintText: AppStrings.searchHint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
      ),
    );
  }
}
