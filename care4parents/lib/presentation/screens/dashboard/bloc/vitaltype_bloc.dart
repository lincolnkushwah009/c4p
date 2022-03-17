import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:care4parents/data/models/family_main_result.dart';
import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/vital_top_result.dart';
import 'package:care4parents/data/models/vital_type_result.dart';
import 'package:care4parents/domain/entities/app_error.dart';
import 'package:care4parents/domain/entities/type_params.dart';
import 'package:care4parents/domain/usecases/subscription.dart';
import 'package:care4parents/helper/shared_preferences.dart';
import 'package:care4parents/presentation/screens/dashboard/view/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'vitaltype_event.dart';
part 'vitaltype_state.dart';

class VitaltypeBloc extends Bloc<VitaltypeEvent, VitaltypeState> {
  final GetVitalList getVitalList;
  final GetVitalLists getVitalLists;

  final _loadingController = StreamController<bool>();
  Stream<bool> get loadingStream => _loadingController.stream;

  void setIsLoading(bool loading) => _loadingController.add(loading);

  List<VitalTopResult> _listTodo;
  List<VitalTypeResult> _listType;
  String _ecgFile1;
  String _ecgFile;

  VitaltypeBloc({@required this.getVitalList, @required this.getVitalLists})
      : super(VitaltypeInitial()) {
    on<GetListTypes>(
      (event, emit) async {
        await _mapGetVitalType(event, state, emit);
      },
      transformer: sequential(),
    );
    on<ChangeListType>(
      (event, emit) async {
        await _changeListTodo(event, emit);
      },
      transformer: sequential(),
    );
    on<CheckItemListType>(
      (event, emit) async {
        await _checkItemListTodo(event);
      },
      transformer: sequential(),
    );
    on<ChnageDateListType>(
      (event, emit) async {
        await _changeItemDate(event, emit);
      },
      transformer: sequential(),
    );
    on<PdfChange>(
      (event, emit) async {
        await _pdfItemListTodo(event);
      },
      transformer: sequential(),
    );
    on<ChangeRecordListType>(
      (event, emit) async {
        await _changeRecordList(event);
      },
      transformer: sequential(),
    );
    on<ChnageRecordType>(
      (event, emit) async {
        await _recordVitalPage(event, emit);
      },
      transformer: sequential(),
    );
  }

  // @override
  // Stream<VitaltypeState> mapEventToState(
  //   VitaltypeEvent event,
  // ) async* {
  //   switch (event.runtimeType) {
  //     case GetListTypes:
  //       // yield* _mapGetVitalType(event, state);
  //       break;
  //     case ChangeListType:
  //       // yield* _changeListTodo(event);
  //       break;
  //     case CheckItemListType:
  //       // yield* _checkItemListTodo(event);
  //       break;
  //     case ChnageDateListType:
  //       // yield* _changeItemDate(event);
  //       break;
  //     case PdfChange:
  //       // yield* _pdfItemListTodo(event);
  //       break;
  //     case ChangeRecordListType:
  //       yield* _changeRecordList(event);
  //       break;
  //     case ChnageRecordType:
  //       // yield* _recordVitalPage(event);
  //       break;
  //     default:
  //   }
  // }

  _changeListTodo(ChangeListType event, Emitter<VitaltypeState> emit) async {
    // print('event'+event.ecgFile1.toString());
    // print('event'+event.ecgFile.toString());
    // print('event _ecgFile'+_ecgFile.toString());
    // print('event _ecgFile1'+_ecgFile1.toString());
    _listTodo = event.listType;
    if (event.ecgFile != null) {
      _ecgFile = event.ecgFile.toString();
    }
    if (event.ecgFile1 != null) {
      _ecgFile1 = event.ecgFile1.toString();
    }

    emit(ChangedListType(event.listType,
        isDummy: event.isDummy,
        ecgFile: event.ecgFile,
        ecgFile1: event.ecgFile1.toString(),
        loaded: event.loaded));
  }

  Stream<VitaltypeState> _changeRecordList(ChangeRecordListType event) async* {
    print(
        'event.showGraph =======================' + event.showGraph.toString());
    if (event.listType != null) {
      _listType = event.listType;
    }
    yield ChangedRecordListType(
        event.listType != null ? event.listType : _listType, event.showGraph);
  }

  _checkItemListTodo(CheckItemListType event) async {
    final item = _listTodo[event.index];
    _listTodo[event.index] = item.copyWith(showGraph: !item.showGraph);
    this.add(ChangeListType(
        listType: List.of(_listTodo),
        ecgFile: _ecgFile,
        ecgFile1: _ecgFile1,
        loaded: true));
  }

  _changeVitalPage(CheckItemListType event) async {
    final item = _listTodo[event.index];
    _listTodo[event.index] = item.copyWith(showGraph: !item.showGraph);
    this.add(ChangeListType(
        listType: List.of(_listTodo),
        ecgFile: _ecgFile,
        ecgFile1: _ecgFile1,
        loaded: true));
  }

  _pdfItemListTodo(PdfChange event) async {
    this.add(ChangeListType(
        listType: List.of(_listTodo),
        ecgFile: jsonDecode(event.item.ecgfiles)['docurl'],
        loaded: false));
  }

  _changeItemDate(
      ChnageDateListType event, Emitter<VitaltypeState> emit) async {
    print('event.index' + event.index.toString());
    DateFormat parseFormat = DateFormat("yyyy-MM-dd HH:mm");
    final item = _listTodo[event.index];
    Either<AppError, List<VitalTypeResult>> either =
        await getVitalList(TypeParams(
      mobile: event.mobile,
      startdate:
          event.startDate != null ? parseFormat.format(event.startDate) : "",
      enddate: event.endDate != null
          ? parseFormat
              .format(event.endDate.add(const Duration(hours: 23, minutes: 59)))
          : "",
      type: Constants.switchTypeByIndex(event.index),
      datetype: event.startDate != null
          ? Constants.switchTypeByIndex(event.index)
          : '',
    ));

    emit(either.fold(
      // ignore: missing_return
      (l) {
        _listTodo[event.index] = item.copyWith(
            startDate: event.startDate != null ? event.startDate : null,
            endDate: event.endDate != null ? event.endDate : null,
            list: []);
        this.add(ChangeListType(
            listType: List.of(_listTodo),
            ecgFile: _ecgFile,
            ecgFile1: _ecgFile1,
            loaded: false));
      },
      // ignore: missing_return
      (list) {
        print('event.startDate' + event.startDate.toString());
        _listTodo[event.index] = item.copyWith(
            startDate:
                event.startDate.toString() != 'null' ? event.startDate : null,
            endDate: event.endDate.toString() != 'null' ? event.endDate : null,
            list: list);
        this.add(ChangeListType(
            listType: List.of(_listTodo),
            ecgFile: _ecgFile,
            ecgFile1: _ecgFile1,
            loaded: true));
      },
    ));
  }

  _recordVitalPage(ChnageRecordType event, Emitter<VitaltypeState> emit) async {
    emit(Loading(ChangedRecordListType));
    FamilyMainResult member;
    FamilyMember f_member;
    print('event.type' + event.type.toString());
    member = await SharedPreferenceHelper.getSelectedFamilyPref();
    f_member = await SharedPreferenceHelper.getFamilyPref();

    print(f_member);

    Either<AppError, List<VitalTypeResult>> either = await getVitalList(
        TypeParams(
            mobile:
                member != null ? member.family_member.phone : f_member.phone,
            type: event.type,
            datetype: '',
            startdate: '',
            enddate: ''));

    emit(either.fold(
      // ignore: missing_return
      (l) {
        this.add(ChangeRecordListType(listType: []));
      },
      // ignore: missing_return
      (list) {
        this.add(ChangeRecordListType(listType: list));
      },
    ));
  }

  _mapGetVitalType(GetListTypes event, VitaltypeState state,
      Emitter<VitaltypeState> emit) async {
    emit(Loading(ChangedListType));
    Either<AppError, List<List<VitalTypeResult>>> either =
        await getVitalLists(TypeParams(
      mobile: event.mobile,
    ));

    emit(either.fold(
      (l) {
        return TypeLoadError(
          l.appErrorType,
        );
      },
      // ignore: missing_return
      (list) {
        print('list is here ================>' + list.toString());
        String vitalType;
        bool isDummy = false;
        for (var item in list) {
          if (!item.isEmpty && item[0].value == null) {
            // vitalType = item[0];
            // File file = await createFileOfPdfUrl(jsonDecode(item[0].ecgfiles)['docurl']);
            vitalType = jsonDecode(item[0].ecgfiles)['docurl'];
          }

          //  vitalType = f.path;
          if (item.isEmpty) {
            isDummy = true;
          } else {
            isDummy = false;
          }
        }
        print('vitalType ==============>>>>>>>>>>>>>>>>>>>' +
            vitalType.toString());

        List<VitalTopResult> topList = List<VitalTopResult>.from(list
            .map((item) => VitalTopResult(
                  list: item,
                  showGraph: true,
                  startDate: null,
                  endDate: null,
                  name: Constants.switchNameByIndex(list.indexOf(item)),
                ))
            .toList());
        print('topList' + topList.toString());
        print('isdummy' + isDummy.toString());
        // if(vitalType!= null){
        this.add(ChangeListType(
            listType: topList,
            isDummy: isDummy,
            ecgFile: vitalType,
            ecgFile1: '',
            loaded: false));

        // }
      },
    ));
  }

  File file;
  Future<File> createFileOfPdfUrl(path) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      final url = path;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getExternalStorageDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}
