part of 'package_bloc.dart';

sealed class BookedEvent extends Equatable {
  const BookedEvent();

  @override
  List<Object> get props => [];
}
class SearchEvent extends BookedEvent{
  String value;
  SearchEvent({required this.value});
    @override
  List<Object> get props => [value];
}
class GetBookedEvent extends BookedEvent{}