part of 'favoret_bloc.dart';

class FavoretEvent extends Equatable {
  const FavoretEvent();

  @override
  List<Object> get props => [];
}

class GetWishEvent extends FavoretEvent {
  const GetWishEvent();

  @override
  List<Object> get props => [];
}
class AddWishEvent extends FavoretEvent {
  PackageModel packageModel;
   AddWishEvent({required this.packageModel});

  @override
  List<Object> get props => [packageModel];
}

class RemoveWishEvent extends FavoretEvent {
  String w_uid;
  RemoveWishEvent({required this.w_uid});

  @override
  List<Object> get props => [w_uid];
}
class IsWishEvent extends FavoretEvent {
  String p_uid;
  IsWishEvent({required this.p_uid});

  @override
  List<Object> get props => [p_uid];
}
class searchEvent extends FavoretEvent {
  String searchQuery;
  searchEvent({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}