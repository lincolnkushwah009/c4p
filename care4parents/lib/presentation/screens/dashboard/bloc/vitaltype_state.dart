part of 'vitaltype_bloc.dart';

@immutable
abstract class VitaltypeState {}

class VitaltypeInitial extends VitaltypeState {}

class TypeLoadError extends VitaltypeState {
  final AppErrorType errorType;

  TypeLoadError(this.errorType);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeLoadError &&
          runtimeType == other.runtimeType &&
          errorType == other.errorType;

  @override
  int get hashCode => errorType.hashCode;
}

class Loading extends VitaltypeState {
  final Type event;

  Loading(this.event);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Loading &&
          runtimeType == other.runtimeType &&
          event == other.event;

  @override
  int get hashCode => event.hashCode;
}

// class LoadedTypeList extends VitaltypeState {
//   final List<VitalTypeResult> list;

//   const LoadedTypeList({
//     this.list,
//   }) : super();

//   @override
//   List<Object> get props => [list];
// }

class ChangedListType extends VitaltypeState {
  final List<VitalTopResult> list;
  final bool isDummy;
  final String ecgFile;
  final String ecgFile1;
  final bool loaded;

  ChangedListType(this.list, {this.isDummy = false, this.ecgFile = '', this.ecgFile1 = '', this.loaded: false });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangedListType &&
          runtimeType == other.runtimeType &&
          list == other.list &&
          isDummy == other.isDummy &&
          ecgFile == other.ecgFile &&
          ecgFile1 == other.ecgFile1 &&
          loaded == other.loaded;

  @override
  int get hashCode => list.hashCode;
}

class ChangedRecordListType extends VitaltypeState {
  final List<VitalTypeResult> list;
  final bool showGraph;
 
  ChangedRecordListType(this.list, this.showGraph,);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangedRecordListType &&
          runtimeType == other.runtimeType &&
          list == other.list &&
          showGraph == other.showGraph ;

  @override
  int get hashCode => list.hashCode;
}

// class LoadedAllTypeList extends VitaltypeState {
//   final List<VitalTopResult> top_list;

//   const LoadedAllTypeList({
//     this.top_list,
//   }) : super();

//   @override
//   List<Object> get props => [top_list];
// }
