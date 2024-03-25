part of 'agency_bloc.dart';

sealed class AgencyEvent extends Equatable {
  const AgencyEvent();

  @override
  List<Object> get props => [];
}
class GetAgencyData extends AgencyEvent{
  String uid;
  GetAgencyData({required this.uid});
  
  @override
  List<Object> get props => [uid];
}
  
  
