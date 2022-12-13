import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> get isNetworkConnected async {
  final result = await Connectivity().checkConnectivity();
  return result != ConnectivityResult.none;
}
