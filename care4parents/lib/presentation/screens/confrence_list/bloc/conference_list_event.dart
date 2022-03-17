part of 'conference_list_bloc.dart';

abstract class ConferenceListEvent extends Equatable {
  const ConferenceListEvent();

  @override
  List<Object> get props => [];
}

class GetConference extends ConferenceListEvent {
  const GetConference();

  @override
  List<Object> get props => [];
}
