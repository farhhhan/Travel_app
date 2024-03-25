import 'dart:async';
import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:travel_app/infrastructure/bookingInternational.dart';
import '../../../domain/data/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  BookingInternational bookingRepo;
  TodoBloc(this.bookingRepo) : super(TodoState()) {
    on<TodoStarted>(_onStarted);
    on<AddTodo>(_onAddTodo);
    on<RemoveTodo>(_onRemoveTodo);
    on<DatePicker>(_datePicker);
    on<bookedEvent>(_bookedEvent);
    on<afterSaveEvent>(_saveEvent);
  }

  void _onStarted(
    TodoStarted event,
    Emitter<TodoState> emit,
  ) {
    if (state.status == TodoStatus.success) return;
    emit(state.copyWith(todos: state.todos, status: TodoStatus.success));
  }

  void _onAddTodo(
    AddTodo event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      List<Todo> temp = [];
      temp.addAll(state.todos);
      temp.insert(0, event.todo);
      emit(state.copyWith(todos: temp, status: TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error));
    }
  }

  FutureOr<void> _saveEvent(
    afterSaveEvent event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      emit(state.copyWith(todos: [], status: TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error));
    }
  }

  void _onRemoveTodo(
    RemoveTodo event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      state.todos.remove(event.todo);
      emit(state.copyWith(todos: state.todos, status: TodoStatus.success,datePicker:DateTime.now()));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error));
    }
  }

  FutureOr<void> _datePicker(DatePicker event, Emitter<TodoState> emit) {
    emit(state.copyWith(datePicker: event.datePickers));
  }

  FutureOr<void> _bookedEvent(
      bookedEvent event, Emitter<TodoState> emit) async {
    await bookingRepo.bookingPackage(
      payment_status: event.payment_status,
        status: event.status,
        image: event.image,
        phone: event.gstaddress,
        payment: event.payment,
        packageName: event.packageName,
        TravellersList: event.TravellersList,
        Trevelling_date: event.Trevelling_date,
        traveller_email: event.traveller_email,
        traveller_country: event.traveller_country,
        traveller_number: event.traveller_number,
        agency_uid: event.agency_uid,
        p_uid: event.p_uid,
        treveller_state: event.treveller_state,
        treveller_city: event.treveller_city,
        u_uid: event.u_uid);
  }
}
