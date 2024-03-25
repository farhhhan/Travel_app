import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/domain/advertesment/adModel.dart';
import 'package:travel_app/domain/packageModel/packageModel.dart';
import 'package:travel_app/infrastructure/package.dart';

part 'package_event.dart';
part 'package_state.dart';

class PackageBloc extends Bloc<PackageEvent, PackageState> {
  PackageSearvicesRepo packageSearvicesRepo;
  PackageBloc(this.packageSearvicesRepo) : super(PackageState()) {
    on<GetPackagesEvent>(_getPackage);
  }

  FutureOr<void> _getPackage(
      GetPackagesEvent event, Emitter<PackageState> emit) async {
    emit(PackageLoading());
    await Future.delayed(Duration(milliseconds: 800));
    try {
      final allPackage = await packageSearvicesRepo.getPackage();
      final bestPackage = await packageSearvicesRepo.getBest();
      final popularPackage = await packageSearvicesRepo.getPopular();
      final trendingPackage = await packageSearvicesRepo.getTrending();
      final recommendedPackage = await packageSearvicesRepo.getRecommented();
      final admodelList = await packageSearvicesRepo.getAd();
      print(allPackage);
      emit(packageLoaded(
        adList: admodelList,
          listPackages: allPackage,
          listBest: bestPackage,
          listPopular: popularPackage,
          listRecomented: recommendedPackage,
          listTrending: trendingPackage));
    } catch (e) {
      print(e.toString());
    }
  }
}
