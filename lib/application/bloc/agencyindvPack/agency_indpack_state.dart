part of 'agency_indpack_bloc.dart';

 class AgencyIndvState extends Equatable {
  const AgencyIndvState();
  
  @override
  List<Object> get props => [];
}

 class AgencyIndvLodedstate extends AgencyIndvState {
  List<PackageModel> packageList;
  AgencyIndvLodedstate({required this.packageList});
}
class LoadingState extends AgencyIndvState{}