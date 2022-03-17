import 'package:auto_route/auto_route.dart';
import 'package:care4parents/helper/shared_preferences.dart';

class AuthGuard extends RouteGuard {
  @override
  Future<bool> canNavigate(ExtendedNavigatorState<RouterBase> navigator,
      String routeName, Object arguments) async {
    print("This is AuthGuard canNavigate: $routeName,$arguments");
    String token = await SharedPreferenceHelper.getTokenPref();
    return token != null;
  }
}
