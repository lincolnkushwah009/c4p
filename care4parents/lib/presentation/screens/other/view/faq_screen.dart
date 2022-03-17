import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/family_member.dart';
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
import 'package:care4parents/presentation/screens/menu/menu.dart';
import 'package:care4parents/helper/shared_preferences.dart';

class FaqScreen extends StatefulWidget {
  FaqScreen({Key key}) : super(key: key);

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  OtherCubit _otherCubit;
  DrawerBloc _drawerBloc;
  FamilyMember member;
  bool isLoading = true;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    asyncSharePref();

    _otherCubit = getItInstance<OtherCubit>();
    _drawerBloc = getItInstance<DrawerBloc>();
    _otherCubit.getPageHeader('faqs');
  }

  void asyncSharePref() async {
    member = await SharedPreferenceHelper.getFamilyPref();
    print('member ------------------' + member.toString());
    setState(() {
      isLoading = false;
    });
  }

  void _openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _drawerBloc,
        ),
        BlocProvider(
          create: (context) => _otherCubit,
        )
      ],
      child: BlocBuilder<DrawerBloc, DrawerState>(builder: (context, state) {
        return isLoading
            ? Scaffold(body: AppLoading())
            : Scaffold(
                key: scaffoldKey,
                drawer: MenuScreen(isFamily: member != null ? true : false),
                backgroundColor: AppColors.white,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
                  child: CustomAppBar(
                      title: StringConst.FAQ_SCREEN,
                      onLeadingTap: () => _openDrawer(),
                      trailing: [
                        new whatappIconwidget(isHeader:true)

                      ],
                      hasTrailing: true),
                ),
                body: Page(),
              );
      }),
    );
  }
}

class Page extends StatelessWidget {
  const Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: BlocBuilder<OtherCubit, OtherState>(
        builder: (context, state) {
          if (state is OtherInitial) {
            return AppLoading();
          } else if (state is Loading) {
            return AppLoading();
          } else if (state is LoadedFaq) {
            return FoldingCellFaq(list: state.list);
            // child: Html(
            //   data: state.list[0].content,
            //   padding: EdgeInsets.all(16.0),
            //   onLinkTap: (url) {
            //     print("Opening $url...");
            //   },
            // ),

          } else {
            return SnackBarWidgets.buildErrorSnackbar(
                context, 'Page not found.');
          }
        },
      ),
    );
  }
}

/// Example 2 folding cell inside [ListView]
class FoldingCellFaq extends StatefulWidget {
  const FoldingCellFaq({
    Key key,
    @required this.list,
  }) : super(key: key);

  final List<Faq> list;

  @override
  _FoldingCellFaqState createState() => _FoldingCellFaqState(this.list);
}

class _FoldingCellFaqState extends State<FoldingCellFaq> {
  List<Faq> _list;

  _FoldingCellFaqState(List<Faq> list) {
    this._list = list;
  }
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.all(8.0),
      // color: Color(0xFF2e282a),
      child: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            Faq faq = _list[index];
            if (!faq.show) {
              return GestureDetector(
                  onTap: () {
                    toggle(faq);
                  },
                  child: _buildFrontWidget(faq, theme));
            } else {
              return GestureDetector(
                  onTap: () {
                    toggle(faq);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Sizes.RADIUS_10),
                      ),
                      color: AppColors.grey10,
                    ),
                    margin: EdgeInsets.only(top: Sizes.MARGIN_12),
                    child: Column(children: [
                      _buildInnerTopWidget(faq, theme),
                      _buildInnerBottomWidget(faq, theme)
                    ]),
                  ));
            }
          }),
    );
  }

  Widget _buildFrontWidget(Faq model, ThemeData theme) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(Sizes.RADIUS_10),
              ),
              color: AppColors.grey10,
            ),
            // height: 100,
            margin: EdgeInsets.only(top: Sizes.MARGIN_12),
            child: GestureDetector(
              onTap: () {
                toggle(model);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        "${model.header}" + "",
                        textAlign: TextAlign.start,
                        style: theme.textTheme.caption.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Icon(
                      Icons.expand_more,
                      color: AppColors.black50,
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }

  Widget _buildInnerTopWidget(Faq model, ThemeData theme) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    "${model.header}",
                    style: theme.textTheme.caption.copyWith(
                        color: AppColors.black, fontWeight: FontWeight.w700),
                  ),
                ),
                Icon(
                  Icons.expand_less,
                  color: AppColors.black50,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInnerBottomWidget(Faq model, ThemeData theme) {
    return Builder(builder: (context) {
      return Container(
        alignment: Alignment.topCenter,
        child: Html(
          data: model.content,
          padding: EdgeInsets.all(8.0),
        ),
      );
    });
  }

  void toggle(Faq model) {
    final tile = _list.firstWhere((item) => item.header == model.header);

    setState(() => tile.show = !tile.show);
  }
}
