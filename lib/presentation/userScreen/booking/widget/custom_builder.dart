
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/application/bloc/todo_bloc/todo_bloc.dart';

class custom_builder extends StatelessWidget {
  const custom_builder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.status == TodoStatus.success) {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.todos.length,
              itemBuilder: (context, int i) {
                return Card(
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          backgroundColor: Colors.red,
                          label: 'Delete',
                          autoClose: true,
                          icon: Icons.delete,
                          onPressed: (context) {
                            context.read<TodoBloc>().add(
                                RemoveTodo(state.todos[i]));
                          },
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            print(
                                state.todos[i].toString());
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  Text(
                                    'Traveller ${i + 1} +',
                                    style:
                                        GoogleFonts.aBeeZee(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Name : ',
                                        style: GoogleFonts
                                            .aBeeZee(
                                          color:
                                              Colors.white,
                                          fontSize: 14,
                                          fontWeight:
                                              FontWeight
                                                  .w200,
                                        ),
                                      ),
                                      Text(
                                        state.todos[i].name,
                                        style: GoogleFonts
                                            .aBeeZee(
                                          color:
                                              Colors.white,
                                          fontSize: 16,
                                          fontWeight:
                                              FontWeight
                                                  .w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Age : ',
                                        style: GoogleFonts
                                            .aBeeZee(
                                          color:
                                              Colors.black,
                                          fontSize: 14,
                                          fontWeight:
                                              FontWeight
                                                  .w200,
                                        ),
                                      ),
                                      Text(
                                        state.todos[i].age,
                                        style: GoogleFonts
                                            .aBeeZee(
                                          color:
                                              Colors.black,
                                          fontSize: 14,
                                          fontWeight:
                                              FontWeight
                                                  .w200,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state.status == TodoStatus.initial) {
            return Center(child: SizedBox());
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
