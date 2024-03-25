part of 'package_bloc.dart';

 class PackageState extends Equatable {
   PackageState();
  
  @override
  List<Object> get props => [];
}
class packageLoaded extends PackageState{
  List<PackageModel> listPackages;
  List<PackageModel> listRecomented;
  List<PackageModel> listPopular;
  List<PackageModel> listBest;
  List<PackageModel> listTrending;
  List<adModel> adList;

  packageLoaded({required this.listPackages,required this.listRecomented,
  required this.listBest,
  required this.adList,
  required this.listPopular,
  required this.listTrending
  });

    @override
  List<Object> get props => [listPackages,listRecomented,listTrending,listBest,listPopular,adList];
}

class PackageLoading extends PackageState{}