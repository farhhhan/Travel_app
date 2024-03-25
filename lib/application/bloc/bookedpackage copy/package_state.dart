part of 'package_bloc.dart';

class BookedHistoryState extends Equatable {
  const BookedHistoryState();

  @override
  List<Object> get props => [];
}

class Bookedloaded extends BookedHistoryState {
  List<BookedModel> bookedList;
  Bookedloaded({required this.bookedList});
}

class bookedingLoading extends BookedHistoryState {}
