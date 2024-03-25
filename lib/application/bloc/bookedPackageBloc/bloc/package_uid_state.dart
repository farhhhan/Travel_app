part of 'package_uid_bloc.dart';

sealed class PackageUidState extends Equatable {
   PackageUidState();
  
  @override
  List<Object> get props => [];
}

final class PackageUidInitial extends PackageUidState {}

class PackageLoadedState extends PackageUidState{
  List<PackageModel> Package;
   PackageLoadedState(this.Package);
  @override
  List<Object> get props => [Package];
}