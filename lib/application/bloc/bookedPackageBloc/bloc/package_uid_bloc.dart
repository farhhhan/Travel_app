import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/domain/packageModel/packageModel.dart';
import 'package:travel_app/infrastructure/package_indivutal.dart';

part 'package_uid_event.dart';
part 'package_uid_state.dart';

class PackageUidBloc extends Bloc<PackageUidEvent, PackageUidState> {
  final IndivtualPackageRepo indivtualPackageRepo;

  PackageUidBloc(this.indivtualPackageRepo) : super(PackageUidInitial()) {
    // Register event handlers in the constructor
    on<GetPackageEvent>(_getPackage);
    on<UpdatePaymentEvent>(_approvePayment);
  }
  Future<void> _getPackage(
      GetPackageEvent event, Emitter<PackageUidState> emit) async {
    try {
      emit(PackageUidInitial()); // Emit loading state
      final datas = await indivtualPackageRepo.get(puid: event.uid);
      emit(PackageLoadedState(datas)); // Emit loaded state with data
    } catch (e) {}
  }

  Future<void> _approvePayment(
      UpdatePaymentEvent event, Emitter<PackageUidState> emit) async {
    try {
      await indivtualPackageRepo.afterApprove(
          status: event.status, uid: event.uid);
      final datas = await indivtualPackageRepo.get(puid: event.uid);
      emit(PackageLoadedState(datas)); // Emit loaded state after payment update
    } catch (e) {}
  }
}
