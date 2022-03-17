import 'package:auto_route/auto_route.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/divider_widget.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';

import 'booking_text_form_field.dart';

class SearchServiceScreen extends StatefulWidget {
  SearchServiceScreen({Key key}) : super(key: key);
  // final String title;

  @override
  _SearchServiceScreenState createState() => new _SearchServiceScreenState();
}

class _SearchServiceScreenState extends State<SearchServiceScreen> {
  TextEditingController editingController = TextEditingController();

  final List<String> duplicateItems = [
    "Physiotherapy",
        "Home Care",
    "Investigations-sample collection",
    "Vaccination",
    "X-Ray at home",
    "ECG",
    "Order Medicines",
    "Other",
  ];





var items = List<String>();

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
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
            title: StringConst.SERVICE_SCREEN,
            leading: InkWell(
                onTap: () => ExtendedNavigator.root.pop(),
                child: Icon(Icons.arrow_back_ios_outlined)),
            hasTrailing: false),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BookingTextFormField1(
                key: const Key('loginForm_emailInput_textField'),
                hintText: StringConst.label.SEARCH_SERVICE,
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
                padding: EdgeInsets.symmetric(horizontal: Sizes.PADDING_16),
                width: widthOfScreen,
                height: heightOfScreen * 0.2,
                borderRadius: const BorderRadius.all(
                  const Radius.circular(Sizes.RADIUS_24),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: InkWell(
                              onTap: () =>
                                  ExtendedNavigator.root.pop(items[index]),
                              child: Text('${items[index]}')),
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
      ),
    );
  }
}
