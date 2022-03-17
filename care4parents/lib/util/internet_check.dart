// import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
class InternetCheck {
  final Connectivity _connectivity;

  InternetCheck(this._connectivity);
  Future<bool> check() async {
    final ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  dynamic checkInternet(Function func) {
    check().then((intenet) {
      if (intenet != null && intenet) {
        func(true);
      } else {
        func(false);
      }
    });
  }
}
