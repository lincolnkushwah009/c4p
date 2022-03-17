import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'arrow_clipper.dart';

class HomePageController {
  void Function() methodA;
}

class FamilyMemberList extends StatefulWidget {
  final List<FamilyMainResult> userFamily;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final int selectedId;
  final ValueChanged<int> onChange;
  final HomePageController controller;
  OverlayEntry overlayEntry;

  FamilyMemberList(
      {Key key,
      this.userFamily,
      this.borderRadius,
      this.selectedId,
      this.backgroundColor = AppColors.white,
      this.onChange,
      this.overlayEntry,
      this.controller})
      : assert(userFamily != null),
        super(key: key);
  @override
  _FamilyMemberListState createState() =>
      _FamilyMemberListState(this.controller);
}

class _FamilyMemberListState extends State<FamilyMemberList>
    with SingleTickerProviderStateMixin {
  GlobalKey _key;
  bool isMenuOpen = false;
  Offset buttonPosition;
  Size buttonSize;

  BorderRadius _borderRadius;
  AnimationController _animationController;
  _FamilyMemberListState(HomePageController _controller) {
    print('_FamilyMemberListState');
    _controller.methodA = methodA;
  }

  @override
  void initState() {
    print('initState');
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _borderRadius = widget.borderRadius ?? BorderRadius.circular(4);
    _key = LabeledGlobalKey("button_icon");
    super.initState();
  }

  void methodA() {
    print('methodA');
    closeMenu();
    // _overlayEntry.remove();
  }

  @override
  void dispose() {
    print('dispose');
    _animationController.dispose();
    if (widget.overlayEntry != null) widget.overlayEntry.remove();
    super.dispose();
  }

  findButton() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void closeMenu() {
    if (widget.overlayEntry != null) {
      widget.overlayEntry.remove();
      widget.overlayEntry = null;
    }

    _animationController.reverse();
    isMenuOpen = !isMenuOpen;
  }

  void openMenu() {
    findButton();
    _animationController.forward();
    widget.overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(widget.overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    print('userFamily ===============================>>>>>>>>>>>>>>>>>>>' +
        widget.userFamily.toString());
    return Container(
      key: _key,
      child: InkWell(
        onTap: () {
          if (isMenuOpen) {
            closeMenu();
          } else {
            openMenu();
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(right: Sizes.PADDING_16),
          child: SvgPicture.asset(
            ImagePath.PROFILE_ICON,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        ThemeData theme = Theme.of(context);
        double widthOfScreen = assignWidth(context: context, fraction: 1.0);
        double heightOfScreen = assignHeight(context: context, fraction: 1.0);
        return Positioned(
          top: buttonPosition.dy + buttonSize.height - 15,
          left: buttonPosition.dx - widthOfScreen / 2.2,
          width: widthOfScreen / 1.75,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(0.85, 0),
                  child: ClipPath(
                    clipper: ArrowClipper(),
                    child: Container(
                      height: 18,
                      width: 25,
                      decoration: BoxDecoration(
                        color: widget.backgroundColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: (widget.userFamily != null &&
                          widget.userFamily.length > 0)
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 6),
                                    color: Colors.black12)
                              ]),
                          height: widget.userFamily.length == 1
                              ? widget.userFamily.length * 100.0
                              : heightOfScreen - 150,
                          child: ListView(
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                ...List.generate(
                                    widget.userFamily != null
                                        ? widget.userFamily.length
                                        : 0, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      widget.onChange(index);
                                      closeMenu();
                                    },
                                    child: MemberItem(
                                      family_member: widget
                                          .userFamily[index].family_member,
                                      selectedId: widget.selectedId,
                                      theme: theme,
                                    ),
                                  );
                                }),
                                SpaceW60(),
                              ]),
                        )
                      : NoMember(widthOfScreen: widthOfScreen, theme: theme),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MemberItem extends StatelessWidget {
  const MemberItem({
    Key key,
    @required this.family_member,
    @required this.selectedId,
    @required this.theme,
  }) : super(key: key);

  final FamilyMember family_member;
  final int selectedId;

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
        color: family_member.id == selectedId
            ? AppColors.drawerBackColor
            : AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          CircularProfileAvatar(
            family_member.profile_pic != null && family_member.profile_pic != ""
                ? family_member.profile_pic
                : "", //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
            radius: 25, // sets radius, default 50.0
            backgroundColor: Colors
                .transparent, // sets background color, default Colors.white
            borderWidth: 1, // sets border, default 0.0
            initialsText: Text(
              "",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ), // sets initials text, set your own style, default Text('')
            borderColor: family_member.id == selectedId
                ? AppColors.primaryColor
                : AppColors
                    .primaryColor, // sets border color, default Colors.white
            elevation:
                4.0, // sets elevation (shadow of the profile picture), default value is 0.0
            foregroundColor: AppColors.primaryColor.withOpacity(
                0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
            cacheImage:
                true, // allow widget to cache image against provided url
            // sets on tap
            showInitialTextAbovePicture:
                false, // setting it true will show initials text above profile picture, default false
          ),
          SpaceW12(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                family_member.name != null && family_member.name != ""
                    ? family_member.name.intelliTrim().capitalize()
                    : '---',
                style: theme.textTheme.bodyText1.copyWith(
                    color: AppColors.blackShade4, fontWeight: FontWeight.w900),
              ),
              Text(
                family_member.relation != null && family_member.relation != ""
                    ? family_member.relation.intelliTrim().capitalize()
                    : '---',
                style: theme.textTheme.caption
                    .copyWith(color: AppColors.greyShade8),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class NoMember extends StatelessWidget {
  const NoMember({
    Key key,
    @required this.widthOfScreen,
    @required this.theme,
  }) : super(key: key);

  final double widthOfScreen;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthOfScreen / 1.75,
      height: 80.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 6),
                color: Colors.black12)
          ]),
      child: Center(
        child: Text(
          'No family member.',
          style: theme.textTheme.caption.copyWith(
            color: AppColors.greyShade8,
          ),
        ),
      ),
    );
  }
}
