import 'package:auto_route/auto_route.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/presentation/screens/other/cubit/other_cubit.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/custom_snackbar.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyScreen extends StatefulWidget {
  PrivacyScreen({Key key}) : super(key: key);

  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  OtherCubit _otherCubit;

  @override
  void initState() {
    super.initState();
    _otherCubit = getItInstance<OtherCubit>();
    _otherCubit.getPage('privacypolicy');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
        child: CustomAppBar(
            title: StringConst.PRIVACY_POLICY_SCREEN,
            leading: InkWell(
              onTap: () => ExtendedNavigator.root.pop(),
              child: Icon(Icons.arrow_back_ios),
            ),
            trailing: [
              new whatappIconwidget(isHeader:true)

            ],
            hasTrailing: true),
      ),
      body: BlocProvider(
        create: (context) => _otherCubit,
        child: PrivacyPage(),
      ),
    );
  }
}

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: BlocBuilder<OtherCubit, OtherState>(
        builder: (context, state) {
          if (state is OtherInitial) {
            return AppLoading();
          } else if (state is Loading) {
            return AppLoading();
          } else if (state is Loaded) {
            return SingleChildScrollView(
              child: Html(
                data: state.page.data,
                padding: EdgeInsets.all(16.0),
                onLinkTap: (url) {
                  print("Opening $url...");
                },
                // customRender: (node, children) {
                //   if (node is dom.Element) {
                //     switch (node.localName) {
                //       case "custom_tag": // using this, you can handle custom tags in your HTML
                //         return Column(children: children);
                //     }
                //   }
                // },
              ),
            );
          } else {
            return SnackBarWidgets.buildErrorSnackbar(
                context, 'Page not found.');
          }
        },
      ),
    );
  }
}
