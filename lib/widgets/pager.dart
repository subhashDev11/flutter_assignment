import 'package:flutter/material.dart';

class PagerWidget extends StatelessWidget {
  const PagerWidget({
    super.key,
    required this.canShowPreviousPage,
    required this.canShowNextPage,
    required this.showPreviousPage,
    required this.showNextPage,
  });

  final bool canShowPreviousPage;
  final bool canShowNextPage;
  final void Function() showPreviousPage;
  final void Function() showNextPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: canShowPreviousPage ? showPreviousPage : null,
          child: const Text('Previous page'),
        ),
        TextButton(
          onPressed: canShowNextPage ? showNextPage : null,
          child: const Text('Following page'),
        ),
      ],
    );
  }
}
