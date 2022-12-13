import 'package:flutter/material.dart';

import '../utils/extensions/int.dart';
import 'common_text.dart';

class FetchSummaryWidget extends StatelessWidget {
  const FetchSummaryWidget({
    super.key,
    required this.totalCount,
    required this.currentPage,
    required this.maxPage,
  });

  final int totalCount;
  final int currentPage;
  final int maxPage;

  static const path = '/foo/';
  static const name = 'FetchSummaryWidget';

  @override
  Widget build(BuildContext context) {
    return CommonTextWidget(
      'Complete ${totalCount.withComma} pieces'
      '（${currentPage.withComma} / '
      '${maxPage.withComma} '
      'page)',
    );
  }
}
