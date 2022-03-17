part of 'vitaltype_bloc.dart';

@immutable
abstract class VitaltypeEvent {}

class ChangeListType extends VitaltypeEvent {
  final List<VitalTopResult> listType;
  final bool isDummy;
  final String ecgFile;
  final String ecgFile1;
  final bool loaded;

  ChangeListType({this.listType , this.isDummy = false , this.ecgFile, this.ecgFile1, this.loaded});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeListType &&
          runtimeType == other.runtimeType &&
          listType == other.listType &&
          isDummy == other.isDummy &&
          ecgFile == other.ecgFile &&
          ecgFile1 == other.ecgFile1 &&
          loaded == other.loaded;

  @override
  int get hashCode => listType.hashCode;
}

class ChangeRecordListType extends VitaltypeEvent {
  final List<VitalTypeResult> listType;
  final bool showGraph;


  ChangeRecordListType({this.listType, this.showGraph = true });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeRecordListType &&
          runtimeType == other.runtimeType &&
          listType == other.listType ;

  @override
  int get hashCode => listType.hashCode;
}


class GetVitalType extends VitaltypeEvent {
  GetVitalType({this.startDate, this.endDate, this.mobile});

  final String startDate;
  final String endDate;
  final String mobile;

  @override
  String toString() => 'GetVitalType';
}

// class ChangeListType extends VitaltypeEvent {
//   final List<VitalTopResult> listType;

//   ChangeListType(this.listType);

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           other is ChangeListType &&
//               runtimeType == other.runtimeType &&
//               listType == other.listType;

//   @override
//   int get hashCode => listType.hashCode;
// }

class CheckItemListType extends VitaltypeEvent {
  final int index;

  CheckItemListType(this.index);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckItemListType &&
          runtimeType == other.runtimeType &&
          index == other.index;

  @override
  int get hashCode => index.hashCode;
}

class CheckRecordListType extends VitaltypeEvent {
  final bool showGraph;

  CheckRecordListType(this.showGraph);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckRecordListType &&
          runtimeType == other.runtimeType &&
          showGraph == other.showGraph;

  @override
  int get hashCode => showGraph.hashCode;
}


class PdfChange extends VitaltypeEvent {
  final VitalTypeResult item;

  PdfChange(this.item);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PdfChange &&
          runtimeType == other.runtimeType &&
          item == other.item;

  @override
  int get hashCode => item.hashCode;
}


class ChnageDateListType extends VitaltypeEvent {
  final int index;
  final DateTime startDate;
  final DateTime endDate;
  final String mobile;

  ChnageDateListType(this.index, this.startDate, this.endDate, this.mobile);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChnageDateListType &&
          runtimeType == other.runtimeType &&
          index == other.index &&
          startDate == other.startDate &&
          endDate == other.endDate;

  @override
  int get hashCode => index.hashCode;
}
class ChnageRecordType extends VitaltypeEvent {
  final String type;

  ChnageRecordType(this.type);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChnageRecordType &&
          runtimeType == other.runtimeType &&
          type == other.type ;

  @override
  int get hashCode => type.hashCode;
}

// class GetVitalTypes extends VitaltypeEvent {
//   const GetVitalTypes({this.mobile});

//   // final String startDate;
//   // final String endDate;
//   final String mobile;

//   @override
//   String toString() => 'GetVitalTypes';
//   @override
//   List<Object> get props => [mobile];
// }

class GetListTypes extends VitaltypeEvent {
  GetListTypes(this.mobile);
  final String mobile;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetListTypes && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
