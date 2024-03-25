part of 'bottom_nav_bloc.dart';

 class BottomNavState extends Equatable {
  int index;
   BottomNavState({ this.index=0});

   BottomNavState copyWith({required int index}){
    return BottomNavState(index: index ?? this.index);
   }
  
  @override
  List<Object> get props => [index];
}
class BottomNavInitialState extends BottomNavState{
  BottomNavInitialState({required super.index});
}

