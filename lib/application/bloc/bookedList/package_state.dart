part of 'package_bloc.dart';

 class BookedState extends Equatable {
  const BookedState();
  
  @override
  List<Object> get props => [];
}

 class LoadedState extends BookedState {
  List<BookedModel> bookedList;
  LoadedState({required this.bookedList});
}
class LoadingState extends BookedState{}