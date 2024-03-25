part of 'favoret_bloc.dart';

class FavoretState extends Equatable {
  bool? isWish;
  FavoretState({this.isWish});
  @override
  List<Object> get props => [isWish!];
}

final class FavoretInitial extends FavoretState {
  FavoretInitial() : super(isWish: false); // Set a default value for isWish
}

class WishLoadingState extends FavoretState {}

class WishLoadedState extends FavoretState {
  List<WishModel> listWish = [];
  WishLoadedState({required this.listWish});
  @override
  List<Object> get props => [listWish];
}
