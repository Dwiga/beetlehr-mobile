import 'package:flutter/material.dart';

import 'inputs.dart';

class SearchTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final VoidCallback? onClear;

  const SearchTextInput({
    Key? key,
    required this.controller,
    this.hint,
    this.onClear,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RegularTextInput(
      controller: controller,
      inputAction: TextInputAction.search,
      prefixIcon: const Icon(Icons.search),
      hintText: hint ?? 'Search...',
      suffix: controller.text.isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                controller.clear();
                onClear?.call();
              },
            )
          : null,
    );
  }
}
