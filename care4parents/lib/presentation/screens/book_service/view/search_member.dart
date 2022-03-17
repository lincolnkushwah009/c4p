import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/divider_widget.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';

import 'booking_text_form_field.dart';

class SearchMemberScreen extends StatefulWidget {
  SearchMemberScreen({Key key}) : super(key: key);
  // final String title;

  @override
  _SearchMemberScreenState createState() => new _SearchMemberScreenState();
}

class _SearchMemberScreenState extends State<SearchMemberScreen> {
  TextEditingController editingController = TextEditingController();
  List<FamilyMainResult> members;
  List<FamilyMainResult> dummyMembers;
  bool loading = true;
  // final List<String> duplicateItems = [
  //   "Physiotherapy"
  //       "Home Care",
  //   "Investigations-sample collection",
  //   "Vaccination",
  //   "X-Ray at home ",
  //   "ECG",
  //   "Order Medicines",
  //   "Other",
  // ];
  // var items = List<String>();

  @override
  void initState() {
    super.initState();
    asyncSharePref();
  }

  void asyncSharePref() async {
    members = await SharedPreferenceHelper.getFamilyMermbersPref();
    dummyMembers = await SharedPreferenceHelper.getFamilyMermbersPref();

    // if (members != null && members.length > 0) {
    setState(() {
      loading = false;
    });
    // }
  }

  void filterSearchResults(String query) {
    List<FamilyMainResult> dummySearchList = List<FamilyMainResult>();
    dummySearchList.addAll(dummyMembers);
    if (query.isNotEmpty) {
      List<FamilyMainResult> dummyListData = List<FamilyMainResult>();
      dummySearchList.forEach((item) {
        if (item.family_member.name
            .toLowerCase()
            .contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        members.clear();
        members.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        members.clear();
        members.addAll(dummyMembers);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
        child: CustomAppBar(
            title: StringConst.MEMBER_SCREEN,
            leading: InkWell(
                onTap: () => ExtendedNavigator.root.pop(),
                child: Icon(Icons.arrow_back_ios_outlined)),
            hasTrailing: false),
      ),
      body: loading
          ? AppLoading()
          : (members != null && members.length > 0)
              ? Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BookingTextFormField1(
                          key: const Key('loginForm_emailInput_textField'),
                          hintText: StringConst.label.SEARCH_MEMBER,
                          prefixIcon: ImagePath.SEARCH_ICON,
                          prefixIconHeight: Sizes.ICON_SIZE_18,
                          onChanged: (value) => {filterSearchResults(value)},
                          errorText: null,
                          borderRadius: Sizes.RADIUS_20,
                        ),
                      ),
                      SpaceH24(),
                      Expanded(
                        child: BgCard(
                          padding: EdgeInsets.symmetric(
                              horizontal: Sizes.PADDING_16),
                          width: widthOfScreen,
                          height: heightOfScreen * 0.2,
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(Sizes.RADIUS_24),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: members != null ? members.length : 0,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: InkWell(
                                        onTap: () => ExtendedNavigator.root
                                            .pop(members[index]),
                                        child: Text(
                                            '${members[index].family_member.name.capitalize()}')),
                                  ),
                                  DividerGrey()
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(Sizes.PADDING_14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringConst.sentence.NOT_FOUND,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(color: AppColors.noDataText),
                        ),
                        SpaceH36(),
                      ],
                    ),
                  ),
                ),
    );
  }
}
