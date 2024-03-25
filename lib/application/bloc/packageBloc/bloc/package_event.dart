part of 'package_bloc.dart';

sealed class PackageEvent extends Equatable {
  const PackageEvent();

  @override
  List<Object> get props => [];
}
class GetPackagesEvent extends PackageEvent{}