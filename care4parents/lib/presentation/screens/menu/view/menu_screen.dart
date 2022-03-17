import 'package:auto_route/auto_route.dart';
import 'package:care4parents/presentation/screens/menu/bloc/drawer_bloc.dart';
import 'package:care4parents/presentation/screens/menu/view/menu_constant.dart';
import 'package:flutter/material.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatelessWidget {
  final bool isFamily;

  MenuScreen({
    Key key,
    this.isFamily = false,
  }) : super(key: key);

  List<MenuItem> menuList = DrawerConstants.menuList;
  List<MenuItem> menuFamilyList = DrawerConstants.menuFamilyList;
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.white,
        child: _buildMenu(),
      ),
    );
  }

  Widget _buildMenu() {
    return (ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: isFamily ? menuFamilyList.length : menuList.length,
      itemBuilder: (BuildContext context, int index) =>
          BlocBuilder<DrawerBloc, DrawerState>(
        builder: (BuildContext context, DrawerState state) => _buildDrawerItem(
            context, isFamily ? menuFamilyList[index] : menuList[index], state),
      ),
    ));
  }

  Widget _buildDrawerItem(
      BuildContext context, MenuItem data, DrawerState state) {
    ThemeData theme = Theme.of(context);

    return (Stack(
      children: [
        if (data.header)
          _buildDrawerHeader(context)
        else if (data.isLast)
          _buildLogout(context, theme, data)
        else
          Container(
            child: ListTile(
              selected: state.selectedItem == data.drawerSelection,
              selectedTileColor: AppColors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: Sizes.PADDING_24,
              ),

              title: new Row(children: [

                Icon(
                  data.iconData,
                  color: state.selectedItem == data.drawerSelection
                      ? AppColors.primaryColor
                      : AppColors.primaryColor,
                  size:14,
                ),
                Transform(
                  transform:
                  Matrix4.translationValues(Sizes.MARGIN_16, 0.0, 0.0),
                  child: Text(
                    data.title,
                    style: theme.textTheme.bodyText1.copyWith(
                      color: state.selectedItem == data.drawerSelection
                          ? AppColors.primaryColor
                          : AppColors.blackShade10,
                    ),
                  ),
                )
              ],),
              onTap: () {
                _handleItemClick(context, data.drawerSelection);

                data.onTap();
              },
            ),
          ),
      ],
    ));
  }

  Widget _buildDrawerHeader(context) {
    ThemeData theme = Theme.of(context);
    double width = assignWidth(context: context, fraction: 1);
    return Container(

      height: assignHeight(context: context, fraction: 0.2),
      child: DrawerHeader(
        decoration: BoxDecoration(
          color: AppColors.drawerBackColor,
        ),
        child: Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.LOGO,
                width: width * 0.4,


                fit: BoxFit.cover,
              ),
            ],
          ),

        ),
      ),
    );
  }

  void _handleItemClick(BuildContext context, DrawerItem item) {
    BlocProvider.of<DrawerBloc>(context).add(NavigateTo(item));
    ExtendedNavigator.root.pop();
  }

  Widget _buildLogout(context, theme, data) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.only(top: Sizes.MARGIN_60),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: Sizes.PADDING_24,
          ),

          title: new Row(children: [
            Icon(data.iconData, color: AppColors.primaryColor, size:14,),
            Transform(
              transform: Matrix4.translationValues(Sizes.MARGIN_16, 0.0, 0.0),
              child: Text(
                data.title,

                style: theme.textTheme.bodyText1
                    .copyWith(color: AppColors.primaryColor),
              ),
            )
          ],),
          onTap: () {
            _handleItemClick(context, data.drawerSelection);
            data.onTap();
          },
        ),
      ),
    );
  }
}
