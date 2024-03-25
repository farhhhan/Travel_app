part of 'package_uid_bloc.dart';

sealed class PackageUidEvent extends Equatable {
  const PackageUidEvent();

  @override
  List<Object> get props => [];
}

class GetPackageEvent extends PackageUidEvent {
  String uid;
  GetPackageEvent({required this.uid});
  @override
  List<Object> get props => [uid];
}

class UpdatePaymentEvent extends PackageUidEvent {
  String uid;
  String status;
  UpdatePaymentEvent({required this.status, required this.uid});
  List<Object> get props => [uid, status];
}
