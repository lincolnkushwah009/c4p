import 'dart:io';

import 'package:care4parents/apple_login/apple_sign_in.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/presentation/screens/login/bloc/login_bloc.dart';
import 'package:care4parents/presentation/widgets/auth/auth_app_bar.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:flutter/material.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;
  //static final facebookAppEvents = FacebookAppEvents();

  @override
  void initState() {
    super.initState();
    _loginBloc = getItInstance<LoginBloc>();
    if(Platform.isIOS){                                                      //check for ios if developing for both android & ios
      AppleSignIn.onCredentialRevoked.listen((_) {
        print("Credentials revoked");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AuthAppBar(),
            Container(
              height: heightOfScreen * 0.9+130,
              child: BlocProvider(
                create: (context) => _loginBloc,
                child:LoginForm()
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: new whatappIconwidget(isHeader:false),
    );
  }
}
