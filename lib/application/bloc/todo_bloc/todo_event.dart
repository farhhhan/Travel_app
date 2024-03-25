part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class TodoStarted extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo todo;

  const AddTodo(this.todo);

  @override
  List<Object?> get props => [todo];
}

class RemoveTodo extends TodoEvent {
  final Todo todo;

  const RemoveTodo(this.todo);

  @override
  List<Object?> get props => [todo];
}

class AlterTodo extends TodoEvent {
  final int index;

  const AlterTodo(this.index);

  @override
  List<Object?> get props => [index];
}
class afterSaveEvent extends TodoEvent {
  const afterSaveEvent();
  @override
  List<Object?> get props => [];
}

class DatePicker extends TodoEvent {
  final DateTime datePickers;

  const DatePicker(this.datePickers);

  @override
  List<Object?> get props => [datePickers];
}

// ignore: must_be_immutable
class bookedEvent extends TodoEvent {
  final packageName;
  List<Todo> TravellersList;
  final String Trevelling_date;
  String traveller_email;
  String traveller_country;
  String traveller_number;
  String agency_uid;
  String p_uid;
  String treveller_state;
  String treveller_city;
    String gstaddress;
  String u_uid;
  String image;
  String payment;
  String status;
  String payment_status;
  bookedEvent({
    required this.payment_status,
    required this.status,
    required this.payment,
    required this.image,
    required this.gstaddress,
    required this.packageName,
    required this.TravellersList,
    required this.Trevelling_date,
    required this.traveller_email,
    required this.traveller_country,
    required this.traveller_number,
    required this.agency_uid,
    required this.p_uid,
    required this.treveller_state,
    required this.treveller_city,
    required this.u_uid,
  });
  @override
  List<Object?> get props => [];
}
