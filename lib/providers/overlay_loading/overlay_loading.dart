import 'package:hooks_riverpod/hooks_riverpod.dart';

final overlayLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);
