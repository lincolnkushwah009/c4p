part of 'home_list_bloc.dart';

 class HomeListState extends Equatable {

  const HomeListState(  {this.status = FormzStatus.pure,

    this.msg = const NotEmptyField.pure(),
  this.fm_counts= const NotEmptyField.pure(),

  });
  final FormzStatus status;
  final NotEmptyField msg,fm_counts;
  HomeListState copyWith({
    FormzStatus status,
    NotEmptyField msg,
    NotEmptyField fm_counts
  }) {
    return HomeListState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
        fm_counts:fm_counts??this.fm_counts

    );
  }
  @override
  List<Object> get props => [status,msg,fm_counts];
}


