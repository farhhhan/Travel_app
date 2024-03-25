part of 'agency_indpack_bloc.dart';

sealed class AgencyIndvEvent extends Equatable {
  const AgencyIndvEvent();

  @override
  List<Object> get props => [];
}
class SearchEvent extends AgencyIndvEvent{
  String value;
    String uid;
  SearchEvent({required this.value,required this.uid});
    @override
  List<Object> get props => [value];
}
class GetAgencyIndvEvent extends AgencyIndvEvent{
  String uid;
  GetAgencyIndvEvent({required this.uid});
      @override
  List<Object> get props => [uid];
}