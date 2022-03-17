part of 'other_cubit.dart';

abstract class OtherState extends Equatable {
  const OtherState();

  @override
  List<Object> get props => [];
}

class OtherInitial extends OtherState {}

class Loading extends OtherState {
  const Loading();
}

class Loaded extends OtherState {
  final PageResult page;
  const Loaded(this.page);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Loaded && o.page == page;
  }

  @override
  int get hashCode => page.hashCode;
}

class LoadedFaq extends OtherState {
  final List<Faq> list;
  const LoadedFaq(this.list);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LoadedFaq && o.list == list;
  }

  @override
  int get hashCode => list.hashCode;
}

class LoadedVital extends OtherState {
  final List<DataMain> list;
  const LoadedVital(this.list);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LoadedVital && o.list == list;
  }

  @override
  int get hashCode => list.hashCode;
}

class LoadedTrend extends OtherState {
  final List<Report> list;
  const LoadedTrend(this.list);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LoadedVital && o.list == list;
  }

  @override
  int get hashCode => list.hashCode;
}

class LoadedBanner extends OtherState {
  final Banners banner;
  const LoadedBanner(this.banner);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LoadedBanner && o.banner == banner;
  }

  @override
  int get hashCode => banner.hashCode;
}

class Error extends OtherState {
  final String message;
  const Error(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Error && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
