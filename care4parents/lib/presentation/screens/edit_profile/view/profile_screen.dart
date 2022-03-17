import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/domain/entities/user_entity.dart';
import 'package:care4parents/presentation/screens/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:care4parents/presentation/screens/edit_profile/bloc/image_picker_bloc.dart';
import 'package:care4parents/presentation/screens/edit_profile/view/profile_form.dart';
import 'package:care4parents/presentation/widgets/bg_card.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/custom_snackbar.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/presentation/widgets/whatappIconwidget.dart';
import 'package:care4parents/util/screen_utill.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
// import 'package:device_info/device_info.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:formz/formz.dart';

const kSpacingUnit = 10;

class ProfileScreen extends StatefulWidget {
  final UserEntity user;
  ProfileScreen({this.user});
  @override
  _ProfileScreenState createState() => _ProfileScreenState(this.user);
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserEntity _user;
  _ProfileScreenState(UserEntity user) {
    this._user = user;
  }
  EditProfileBloc _editProfileBloc;

  @override
  void initState() {
    super.initState();
    _editProfileBloc = getItInstance<EditProfileBloc>();
    _editProfileBloc.add(EditProfileLoadEvent(_user.email, _user.name,
        _user.phone_number, _user.address, _user.country));

    print("conffirm>>"+_user.confirmed.toString());
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
        child: CustomAppBar(
          title: StringConst.PROFILE_SCREEN,
          leading: InkWell(
            onTap: () => ExtendedNavigator.root.pop(),
            child: Icon(Icons.arrow_back_ios),
          ),
            trailing: [
              new whatappIconwidget(isHeader:true)

            ],
            hasTrailing: true
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          // shrinkWrap: true,
          // padding: EdgeInsets.zero,
          child: BlocProvider(
            create: (context) => _editProfileBloc,
            child: BlocListener<EditProfileBloc, EditProfileState>(
              listener: (context, state) {
                if (state.profile_status.isSubmissionFailure) {
                  SnackBarWidgets.buildErrorSnackbar(
                      context, StringConst.sentence.ERROR_MESSAGE);
                }
                if (state.profile_status.isSubmissionSuccess) {
                  SnackBarWidgets.buildErrorSnackbar(
                      context, StringConst.sentence.ERROR_MESSAGE);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TopProfile(
                    profile: _user.profilephoto,
                    name: _user.name,
                    widthOfScreen: widthOfScreen,
                    heightOfScreen: heightOfScreen,
                    theme: theme,
                  ),
                  SpaceH8(),
                  Container(
                    height: heightOfScreen,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.white,
                          AppColors.white,
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(Sizes.RADIUS_10),
                      ),
                    ),
                    child: EditProfileForm(user: _user),
                  ),
                  SpaceH8(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TopProfile extends StatefulWidget {
  const TopProfile({
    Key key,
    @required this.profile,
    this.name,
    @required this.widthOfScreen,
    @required this.heightOfScreen,
    @required this.theme,
  }) : super(key: key);

  final String profile, name;
  final double widthOfScreen;
  final double heightOfScreen;
  final ThemeData theme;

  @override
  _TopProfileState createState() => _TopProfileState();
}

class _TopProfileState extends State<TopProfile> {
  EditProfileBloc _editProfileBloc;
  ImagePickerBloc _imagePickerBloc;
  // File _image;

  @override
  void initState() {
    super.initState();
    _editProfileBloc = getItInstance<EditProfileBloc>();
    _imagePickerBloc = getItInstance<ImagePickerBloc>();
  }

  selectImage(context) {
    AppImagePicker().showSheet(context, (result) {
      if (result is String) {
        print('Error' + result);
        // AppToast.show(result);

      }
      if (result is File) {
        _imagePickerBloc.add(ImagePicked(result));

        print('result >>' + result.toString());
        _editProfileBloc.add(ProfileImage(result));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BgCard(
      padding: EdgeInsets.zero,
      width: widget.widthOfScreen,
      height: widget.heightOfScreen * 0.2,
      borderRadius: const BorderRadius.all(
        const Radius.circular(Sizes.RADIUS_10),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: BlocProvider(
              create: (context) => _imagePickerBloc,
              child: Stack(
                children: <Widget>[
                  BlocBuilder<ImagePickerBloc, ImagePickerState>(
                    builder: (context, state) {
                      if (state is ImagePickerSuccess) {
                        return CircleAvatar(
                            radius: kSpacingUnit.w * 5,
                            backgroundImage: FileImage(state.image));
                      } else {
                        return
//                          CircleAvatar(
//                          radius: kSpacingUnit.w * 5,
//                          backgroundImage: NetworkImage(widget.profile != null
//                              ? '${StringConst.BASE_URL}' + widget.profile
//                              : 'https://via.placeholder.com/200'),
//                        );

                            CircularProfileAvatar(
                          widget.profile != null && widget.profile != ""
                              ? '${StringConst.BASE_URL}' + widget.profile
                              : "", //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                          radius:
                              kSpacingUnit.w * 5, // sets radius, default 50.0
                          backgroundColor: Colors
                              .transparent, // sets background color, default Colors.white
                          borderWidth: 1, // sets border, default 0.0
                          initialsText: Text(
                            widget.name.characters.first,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ), // sets initials text, set your own style, default Text('')
                          borderColor: AppColors
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
                        );
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () => {selectImage(context)},
                      child: Container(
                        height: kSpacingUnit.w * 3.5,
                        width: kSpacingUnit.w * 3.5,
                        decoration: BoxDecoration(
                          color: AppColors.white50,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          heightFactor: kSpacingUnit.w * 2.5,
                          widthFactor: kSpacingUnit.w * 2.5,
                          child: Icon(
                            Icons.create,
                            color: AppColors.primaryColor,
                            size: ScreenUtil().setSp(kSpacingUnit.w * 2.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

typedef OptionsSuccessBlock = Function(dynamic result);

final List<String> optionslist = ["Take photo", "Choose from gallery"];

class AppImagePicker {
  File _image;
  final picker = ImagePicker();

  /// 选项列表 Function<T> : imageFile or saveBool or errorString
  void showSheet(
    BuildContext context,
    OptionsSuccessBlock optionsBlock, {
    bool isCrop = true,
    String saveImageFilePath,
  }) async {
    List items = optionslist.toList();
    // bool isSave = (saveImageFilePath != null);
    // String saveTitle = "保存图片";
    // if (isSave) {
    //   items.add(saveTitle);
    // }
    _show(context, items, (title) {
      Navigator.pop(context);
      // if (isSave) {
      //   if (saveImageFilePath != null) {
      //     // saveFileToGallery(saveImageFilePath, optionsBlock);
      //   }
      // } else {
      _optionsHandlder(title, isCrop, optionsBlock);
      // }
    });
  }

  /// choose image
  Future<dynamic> pickImage({OptionsSuccessBlock optionsBlock}) async {
    var isGranted = await Permission.photos.request().isGranted;
    if (isGranted == true) {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (optionsBlock != null) optionsBlock(File(pickedFile.path));
      return File(pickedFile.path);
    } else {
      String info = "No image pick.";
      if (optionsBlock != null) optionsBlock(info);
      return info;
    }
  }

  /// camera
  Future<dynamic> takePhoto({OptionsSuccessBlock optionsBlock}) async {
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      if (iosInfo.isPhysicalDevice == false) {
        String info = "IOS simulator testing.";
        if (optionsBlock != null) optionsBlock(info);
        return info;
      }
    }
    var isGranted = await Permission.camera.request().isGranted;
    if (isGranted == true) {
      var imageFile = await picker.getImage(source: ImageSource.camera);
      if (optionsBlock != null) optionsBlock(File(imageFile.path));
      return File(imageFile.path);
    } else {
      String info = "No camera image pick.";
      if (optionsBlock != null) optionsBlock(info);
      return info;
    }
  }

  // /// crop image
  // Future<File> cropImage(File croppedFile,
  //     {OptionsSuccessBlock optionsBlock}) async {
  //   File imageFile = await ImageCropper.cropImage(
  //     sourcePath: croppedFile.path,
  //     toolbarTitle: 'Cropper',
  //     toolbarColor: Colors.blue,
  //     toolbarWidgetColor: Colors.white,
  //   );
  //   if (optionsBlock != null) optionsBlock(imageFile);
  //   return imageFile;
  // }

  // Future<dynamic> saveImageToGallery(
  //     Uint8List imageBytes, OptionsSuccessBlock saveBlock) async {
  //   var isGranted = await Permission.photos.request().isGranted;
  //   print(isGranted);
  //   if (isGranted == true) {
  //     final result = await ImageGallerySaver.saveImage(imageBytes,
  //         quality: 60, name: "scriptkill");
  //     if (saveBlock != null) saveBlock(result);
  //     return result;
  //   } else {
  //     String info = "img gallery";
  //     if (saveBlock != null) saveBlock(info);
  //     return info;
  //   }
  // }

//   Future<dynamic> saveFileToGallery(
//       String filePath, OptionsSuccessBlock saveBlock) async {
//     var isGranted = await Permission.photos.request().isGranted;
//     if (isGranted == true) {
//       final result = await ImageGallerySaver.saveFile(filePath);
//       if (saveBlock != null) saveBlock(result);
//       return result;
//     } else {
//       String info = "file";
//       if (saveBlock != null) saveBlock(info);
//       return info;
//     }
//   }
}

extension on AppImagePicker {
  void _optionsHandlder(
      String title, bool isCrop, OptionsSuccessBlock optionsBlock) async {
    var f;
    if (title == "Take photo") {
      f = await takePhoto();
    }
    if (title == "Choose from gallery") {
      f = await pickImage();
    }
    // if (isCrop == true && f != null && f is File) {
    //   f = await cropImage(f);
    // }
    if (f != null && optionsBlock != null) {
      optionsBlock(f);
    }
  }

  void _show(BuildContext context, List<String> items,
      Function(String title) selected) async {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                        children: items
                            .map((i) => GestureDetector(
                                  onTap: () => selected(i),
                                  child: Container(
                                      width: double.infinity,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0.h),
                                      child: Text(
                                        i,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                      color: Colors.white),
                                ))
                            .toList()),
                    ListTile(
                      title: Text(
                        'Close',
                        style: TextStyle(color: AppColors.redShade5),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 10.0.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
