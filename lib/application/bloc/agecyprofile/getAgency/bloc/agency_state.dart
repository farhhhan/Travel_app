part of 'agency_bloc.dart';

 class AgencyState extends Equatable {
  const AgencyState();
  
  @override
  List<Object> get props => [];
}

class AgencyLoadingState extends AgencyState{

  @override
  List<Object> get props => [];
}

class AgencyLodedState extends AgencyState{
  List<UserModel> agencyData;
   AgencyLodedState(this.agencyData);
  @override
  List<Object> get props => [agencyData];
}
