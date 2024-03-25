import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/domain/packageModel/packageModel.dart';
import 'package:travel_app/domain/wishModel/wishModel.dart';
import 'package:travel_app/infrastructure/favoret_repo/favouret.dart';

part 'favoret_event.dart';
part 'favoret_state.dart';

class FavoretBloc extends Bloc<FavoretEvent, FavoretState> {
  Wish wish = Wish();
  FavoretBloc(this.wish) : super(FavoretInitial()) {
    on<GetWishEvent>(_getWish);
    on<AddWishEvent>(_addtWish);
    on<RemoveWishEvent>(_removeWish);
    on<searchEvent>(_searchWish);
  }

  Future<void> _getWish(GetWishEvent event, Emitter<FavoretState> emit) async {
    emit(WishLoadingState());
    await Future.delayed(Duration(milliseconds: 500));
    try {
      List<WishModel> data = await wish.getWishList();
      print(data);
      emit(WishLoadedState(listWish: data));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _addtWish(AddWishEvent event, Emitter<FavoretState> emit) async {
    await wish.addWishList(packageModel: event.packageModel);
    List<WishModel> data = await wish.getWishList();
    print(data);
    emit(WishLoadedState(listWish: data));
  }

  FutureOr<void> _removeWish(
      RemoveWishEvent event, Emitter<FavoretState> emit) async {
    await wish.removeWish(event.w_uid);
    List<WishModel> data = await wish.getWishList();
    print(data);
    emit(WishLoadedState(listWish: data));
  }

  FutureOr<void> _searchWish(
      searchEvent event, Emitter<FavoretState> emit) async {
    emit(WishLoadingState());
    try {
      if (event.searchQuery.isNotEmpty && event.searchQuery.length>0) {
        List<WishModel> data = await wish.searchPackage(event.searchQuery);
        print(data);
        emit(WishLoadedState(listWish: data));
      } else {
        List<WishModel> data = await wish.getWishList();
        print(data);
        emit(WishLoadedState(listWish: data));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
