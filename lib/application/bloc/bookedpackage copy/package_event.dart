part of 'package_bloc.dart';

sealed class BookedHistoryEvent extends Equatable {
  const BookedHistoryEvent();

  @override
  List<Object> get props => [];
}
class SearchEvent extends BookedHistoryEvent{
  String value;
  SearchEvent({required this.value});
    @override
  List<Object> get props => [value];
}
class GetBookedHistoryEvent extends BookedHistoryEvent{}