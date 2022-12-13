import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../pages/repo/repo_page.dart';

final bottomTabs = <BottomTab>[

  BottomTab._(
    index: 1,
    label: 'Repos',
    path: RepoPage.path,
    iconData: FontAwesomeIcons.database,
    key: GlobalKey<NavigatorState>(),
  ),
];


class BottomTab {

  const BottomTab._({
    required this.index,
    required this.label,
    required this.path,
    required this.iconData,
    required this.key,
  });

  final int index;
  final String label;
  final String path;
  final IconData iconData;
  final GlobalKey<NavigatorState> key;

  static BottomTab getByIndex(int index) => bottomTabs.firstWhere(
        (b) => b.index == index,
        orElse: () => bottomTabs.first,
      );

  static BottomTab getByPath(String bottomTabPath) => bottomTabs.firstWhere(
        (b) => b.path == bottomTabPath,
        orElse: () => bottomTabs.first,
      );
}
