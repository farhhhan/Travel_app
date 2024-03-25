part of 'bottom_nav_bloc.dart';

sealed class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object> get props => [];
}
class changeEvent extends BottomNavEvent {
 int index;
 changeEvent(this.index);
  @override
  List<Object> get props => [index];
}
class LogoutEvent extends BottomNavEvent {
 int index;
 LogoutEvent(this.index);
  @override
  List<Object> get props => [index];
}
