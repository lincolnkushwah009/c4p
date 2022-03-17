import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/domain/entities/subscription.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/settings/bloc/profile_bloc.dart';
import 'package:care4parents/presentation/screens/subscription_list/subscription_list.dart';
import 'package:care4parents/presentation/screens/subscription_list/view/subscription_card_widget.dart';
import 'package:care4parents/presentation/widgets/app_error_widget.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/divider_widget.dart';
import 'package:care4parents/presentation/widgets/new_record.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:care4parents/presentation/screens/menu/menu.dart';

class SubscriptionListScreen extends StatefulWidget {
  SubscriptionListScreen({Key key}) : super(key: key);

  @override
  _SubscriptionListScreenState createState() => _SubscriptionListScreenState();
}

class _SubscriptionListScreenState extends State<SubscriptionListScreen> {
  DrawerBloc _drawerBloc;
  SubscriptionListBloc _subscriptionListBloc;
  DateFormat newFormat = DateFormat("yyyy-MM-dd");

  var scaffoldKey = GlobalKey<ScaffoldState>();
  // List<Subscription> subscriptions = [
  //   Subscription(
  //       id: 1354,
  //       name: 'John',
  //       subscription_date: '2021-04-12',
  //       package: 'Gold',
  //       amount: "200"),
  //   Subscription(
  //       id: 354,
  //       name: 'John1',
  //       subscription_date: '2021-04-01',
  //       package: 'Gold',
  //       amount: "200")
  // ];

  @override
  void initState() {
    super.initState();
    _subscriptionListBloc = getItInstance<SubscriptionListBloc>();
    _drawerBloc = getItInstance<DrawerBloc>();
    _subscriptionListBloc.add(GetInvoices());
  }

  void _openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => _subscriptionListBloc,
          ),
          BlocProvider(
            create: (context) => _drawerBloc,
          ),
        ],
        child: BlocBuilder<DrawerBloc, DrawerState>(builder: (context, state) {
          return Scaffold(
              key: scaffoldKey,
              drawer: MenuScreen(),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
                child: CustomAppBar(
                    onLeadingTap: () => _openDrawer(),
                    title: StringConst.INVOICE,
                    trailing: [
                      new whatappIconwidget(isHeader:true)

                    ],
                    hasTrailing: true),
              ),
              body: BlocBuilder<SubscriptionListBloc, SubscriptionListState>(
                  builder: (context, state) {
                if (state is Loading) return AppLoading();
                if (state is Loaded)
                  return Container(
                    child: (state.invoices?.isEmpty ?? true)
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(Sizes.PADDING_14),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    StringConst.sentence.NOT_FOUND,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.subtitle1
                                        .copyWith(color: AppColors.noDataText),
                                  ),
                                  SpaceH36(),
                                  // Container(
                                  //   margin: const EdgeInsets.symmetric(
                                  //       horizontal: Sizes.MARGIN_48),
                                  //   child: CustomButton(
                                  //       color: AppColors.primaryColor,
                                  //       height: Sizes.HEIGHT_50,
                                  //       borderRadius: Sizes.RADIUS_4,
                                  //       textStyle:
                                  //           theme.textTheme.subtitle1.copyWith(
                                  //         color: AppColors.white,
                                  //       ),
                                  //       onPressed: () => onBookPress(),
                                  //       title: CommonButtons.BOOK),
                                  // ),
                                ],
                              ),
                            ),
                          )
                        : ListView(
                            // physics: BouncingScrollPhysics(),
                            children: [
                              ..._buildSubscriptionListTile(
                                  context: context, data: state.invoices)
                            ],
                          ),
                  );

                return Container();
              }));
        }));
  }

  void _launchURL(url)  =>{
    ExtendedNavigator.root.push(Routes.PdfViewer,
        arguments: PdfViewScreenArguments(
          pdfUrl:url, )
    )

  };
  List<Widget> _buildSubscriptionListTile({
    @required BuildContext context,
    @required List<Invoice> data,
  }) {
    List<Widget> items = [];
    TextTheme textTheme = Theme.of(context).textTheme;

    for (int index = 0; index < data.length; index++) {
      Invoice sub = data[index];

      print("mmmm"+sub.toJson().toString());
      DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(sub.date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputDate = newFormat.format(inputDate);
      print(outputDate);
      items.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_10),
          child: SubscriptionCardWidget(
            invoice_no: '#' + sub.invoiceNo,
            name: sub.familyMembers != null && sub.familyMembers.name != null
                ? sub.familyMembers.name
                : '',
            subscription_date: outputDate != null ? outputDate : '',
            paymentLink: sub.paymentLink != null ? sub.paymentLink : '',
            amount: sub.totalAmount,
            openLink: () {
              print("paymentLink>> " + sub.paymentLink);
              _launchURL(sub.paymentLink);
            },
            status: sub.status,
            openInvoiceLink: () {
              print("invoiceFile>> " + sub.invoiceFile);
              _launchURL(sub.invoiceFile);
            },
          ),
        ),
      );
    }

    return items;
  }

  void refreshData() {
    // _profileBloc.add(GetProfile());
  }

  Future<bool> onGoBack(dynamic value) async {
    refreshData();
    return true;
  }
}

void goToSubscription() {
  ExtendedNavigator.root.push(Routes.subscriptionAddScreen);
}
