import 'dart:io';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/di/get_it.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/layout/adaptive.dart';
import 'package:care4parents/presentation/routes/app_routes.gr.dart';
import 'package:care4parents/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:care4parents/presentation/screens/upload_report/bloc/upload_report_bloc.dart';
import 'package:care4parents/presentation/widgets/app_loading.dart';
import 'package:care4parents/presentation/widgets/custom_app_bar.dart';
import 'package:care4parents/presentation/widgets/custom_snackbar.dart';
import 'package:care4parents/presentation/widgets/primary_button.dart';
import 'package:care4parents/presentation/widgets/round_seconday_button.dart';
import 'package:care4parents/presentation/widgets/spaces.dart';
import 'package:care4parents/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pedantic/pedantic.dart';
import 'package:formz/formz.dart';
import '../../../widgets/booking_text_form_field.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key key}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  UploadReportBloc _uploadReportBloc;
  DateFormat dFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    _uploadReportBloc = getItInstance<UploadReportBloc>();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle titleTextStyle =
        theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700);

    double widthOfScreen = assignWidth(context: context, fraction: 1.0);
    double heightOfScreen = assignHeight(context: context, fraction: 1.0);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.HEIGHT_56),
        child: CustomAppBar(
          title: StringConst.UPLOAD_REPORT,
          leading: InkWell(
            onTap: () => ExtendedNavigator.root.pop(),
            child: Icon(Icons.arrow_back_ios),
          ),
          hasTrailing: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: heightOfScreen * 0.9,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => _uploadReportBloc,
              ),
            ],
            child: BlocListener<UploadReportBloc, UploadReportState>(
              listener: (context, state) {
                if (state.status.isSubmissionFailure) {
                  SnackBarWidgets.buildErrorSnackbar(
                      context, StringConst.sentence.UPLOAD_FAILED);
                }
                if (state.status.isSubmissionSuccess) {
                  ExtendedNavigator.root.pop();
                }
              },
              child: new ListView(
                children: [
                  Column(
                    children: [
                      SpaceH12(),
                      SpaceH8(),
                      _MembersInput(),
                      SpaceH8(),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: Sizes.MARGIN_8,
                              left: Sizes.MARGIN_20,
                              right: Sizes.MARGIN_16),
                          child: Text(
                            StringConst.label.SERVICE,
                            style: titleTextStyle,
                          ),
                        ),
                      ),
                      _MemberDropDown(),
                      SpaceH8(),
                      _DateInput(),
                      SpaceH8(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: _UploadButton(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: _SubmitButton(),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget formFieldTitle({@required String fieldTitle, TextStyle textStyle}) {
  return Container(
    margin: EdgeInsets.only(bottom: Sizes.MARGIN_4),
    padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_26),
    child: Text(fieldTitle, textAlign: TextAlign.start, style: textStyle),
  );
}

class _SubmitButton extends StatelessWidget {
  // UploadReportBloc _uploadReportBloc;

  Future getPdfAndUpload() async {}
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadReportBloc, UploadReportState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const AppLoading()
            : PrimaryButton(
                onPressed: () {
                  context.read<UploadReportBloc>().add(UploadReportSubmitted());
                },
                // : () {
                //     // print(state.member);
                //     print(state.member);
                //     print(state.file);
                //     SnackBarWidgets.buildErrorSnackbar(
                //         context, StringConst.sentence.PEAF);
                //   },
                title: CommonButtons.SUBMIT,
                theme: Theme.of(context),
              );
      },
    );
  }
}

class _UploadButton extends StatefulWidget {
  @override
  __UploadButtonState createState() => __UploadButtonState();
}

class __UploadButtonState extends State<_UploadButton> {
  String _file = '';

  _pickDocument() async {
    // setState(() {
    //   _path = result;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadReportBloc, UploadReportState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
                width: 150, // <-- Your width
                child: RaisedButton(
                    color: AppColors.lightButton,
                    textColor: AppColors.white,
                    hoverColor: AppColors.lightButton,
                    onPressed: () async {
                      // _pickDocument();
                      String result;
                      try {
                        // setState(() {
                        //   _path = '-';
                        //   _pickFileInProgress = true;
                        // });

                        // FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
                        //   allowedFileExtensions: _checkByCustomExtension
                        //       ? _extensionController.text
                        //           .split(' ')
                        //           .where((x) => x.isNotEmpty)
                        //           .toList()
                        //       : null,
                        //   allowedUtiTypes: _iosPublicDataUTI
                        //       ? null
                        //       : _utiController.text
                        //           .split(' ')
                        //           .where((x) => x.isNotEmpty)
                        //           .toList(),
                        //   allowedMimeTypes: _checkByMimeType
                        //       ? _mimeTypeController.text
                        //           .split(' ')
                        //           .where((x) => x.isNotEmpty)
                        //           .toList()
                        //       : null,
                        // );

                        result = await FlutterDocumentPicker.openDocument();
                        print('result' + result);
                        setState(() {
                          _file = result.split('/').last;
                        });
                        context.read<UploadReportBloc>().add(
                              FileChanged(result),
                            );
                      } catch (e) {
                        print(e);
                        result = 'Error: $e';
                      } finally {
                        // setState(() {
                        //   _pickFileInProgress = false;
                        // });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(CommonButtons.UPLOAD),
                        Icon(Icons.file_upload)
                      ],
                    ))),
            if (_file != '')
              Text(
                'File : ${_file}',
              )
          ],
        );
      },
    );
  }
}

class _MemberDropDown extends StatefulWidget {
  @override
  __MemberDropDownState createState() => __MemberDropDownState();
}

class ServiceType {
  const ServiceType(this.id, this.service);

  final int id;
  final String service;
}

class __MemberDropDownState extends State<_MemberDropDown> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = assignWidth(context: context, fraction: 1.0);
    return BlocBuilder<UploadReportBloc, UploadReportState>(
        buildWhen: (previous, current) => previous.service != current.service,
        builder: (context, state) {
          // print('state' + state.service.id.toString());
          return Container(
            width: width * 0.92,
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.grey10,
              border: Border.all(color: AppColors.white),
              // boxShadow: [Shadows.bgCardShadow],
            ),
            child: Row(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                      elevation: 10,
                      dropdownColor: AppColors.grey10,
                      value: state.service != null
                          ? state.service
                          : const ServiceType(3, 'Lab'),
                      items: [
                        const ServiceType(3, 'Lab'),
                        const ServiceType(14, 'Radiology')
                      ].map<DropdownMenuItem<ServiceType>>(
                          (ServiceType serviceType) {
                        // print(serviceType.service.t);
                        // print('serviceType.service' + serviceType.service);
                        return DropdownMenuItem<ServiceType>(
                          value: serviceType,
                          child: Container(
                              child: Text((serviceType == null ||
                                      serviceType.service == null)
                                  ? '----'
                                  : serviceType.service),
                              width: width * 0.8),
                        );
                      }).toList(),
                      onChanged: (ServiceType serviceType) async {
                        // FocusScope.of(context).requestFocus(FocusNode());

                        context.read<UploadReportBloc>().add(
                              ServiceChanged(serviceType),
                            );
                      },
                      hint: Text(StringConst.label.MEMBER_NAME,
                          style: theme.textTheme.bodyText2.copyWith(
                            color: AppColors.black,
                          )),
                      style: theme.textTheme.bodyText2.copyWith(
                        color: AppColors.black,
                      ),
                      icon: Icon(Feather.chevron_down,
                          color: AppColors.primaryColor)),
                ),
              ],
            ),
          );
        });
  }
}

class _MembersInput extends StatefulWidget {
  @override
  __MembersInputState createState() => __MembersInputState();
}

class __MembersInputState extends State<_MembersInput> {
  var _controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadReportBloc, UploadReportState>(
        buildWhen: (previous, current) => previous.member != current.member,
        builder: (context, state) {
          final text =
              state.member != null && state.member.family_member.name != null
                  ? state.member.family_member.name.toString()
                  : '';
          _controller = TextEditingController.fromValue(
            TextEditingValue(
              text: text ?? "",
              selection: TextSelection.collapsed(offset: text?.length ?? 0),
            ),
          );

          // print(' _controller.text' + _controller.text);
          return BookingTextFormField(
              key: const Key('appointmentForm_memberpInput_textField'),
              controller: _controller,
              hintText: StringConst.label.MEMBER_NAME,
              fieldTitle: StringConst.label.MEMBER_NAME,
              suffixIcon: Icon(
                Feather.chevron_down,
                color: AppColors.primaryColor,
              ),
              hasSuffixIcon: true,
              prefixIconHeight: Sizes.ICON_SIZE_18,
              onChanged: (sp) => {},
              errorText: null,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());

                await ExtendedNavigator.root
                    .push(Routes.searchMemberScreen)
                    .then(
                      (selectedFamily) => context.read<UploadReportBloc>().add(
                            ServiceMemberChanged(selectedFamily),
                          ),
                    );
              });
        });
  }
}

class _DateInput extends StatefulWidget {
  @override
  __DateInputState createState() => __DateInputState();
}

class __DateInputState extends State<_DateInput> {
  var _controller = TextEditingController(text: '');
  DateFormat dFormat = DateFormat('yyyy-MM-dd');

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      // setState(() {
      //   selectedDate = picked;
      // });
      context.read<UploadReportBloc>().add(
            ServiceDateChanged(dFormat.format(picked)),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadReportBloc, UploadReportState>(
      buildWhen: (previous, current) => previous.date != current.date,
      builder: (context, state) {
        DateTime date = DateTime.now();
        final text = state.date.value != ''
            ? state.date.value.toString()
            : dFormat.format(date);
        // print('text======${state.date.value.toString()}');
        _controller = TextEditingController(
          text: text ?? dFormat.format(date),
          // selection: TextSelection.collapsed(offset: text?.length ?? 0),
        );

        return BookingTextFormField(
            controller: _controller,
            key: const Key('appointmentForm_dateInput_textField'),
            hintText: StringConst.label.SELECT_DATE,
            fieldTitle: StringConst.label.SELECT_DATE,
            prefixIconHeight: Sizes.ICON_SIZE_18,
            onChanged: (sp) => {},
            errorText: null,
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              _selectDate(context);
              // await ExtendedNavigator.root.push(Routes.calenderScreen).then(
              //       (date_time) => context.read<UploadReportBloc>().add(
              //             ServiceDateChanged(date_time),
              //           ),
              //     );
            });
      },
    );
  }
}
