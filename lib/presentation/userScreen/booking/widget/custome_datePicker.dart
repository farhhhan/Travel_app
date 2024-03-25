
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/application/bloc/todo_bloc/todo_bloc.dart';
import 'package:travel_app/domain/packageModel/packageModel.dart';
import 'package:travel_app/presentation/themeData/themeDataColors.dart';

class custome_datePicker extends StatelessWidget {
  const custome_datePicker({
    super.key,
    required this.packageModel,
  });

  final PackageModel packageModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${packageModel.packageName} - ${packageModel.activityList!.length - 1}N / ${packageModel.activityList!.length}D',
              style: ThemeDataColors.gbowlbyone(fontsize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                void showDatePickers() {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1990),
                    lastDate: DateTime(2050),
                  ).then((value) {
                    context
                        .read<TodoBloc>()
                        .add(DatePicker(value!));
                  });
                }
    
                return Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showDatePickers();
                      },
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Pick-Date',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${DateFormat('d').format((state.datePicker == null ? DateTime.now() : state.datePicker!))}',
                            style: GoogleFonts.nunito(
                              fontSize: 60,
                              fontWeight: FontWeight.w400,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${DateFormat('EE').format(state.datePicker == null ? DateTime.now() : state.datePicker!)}',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              SizedBox(
                                height: 20,
                                child: VerticalDivider(
                                  color: Colors.black,
                                  width: 10,
                                  thickness: 2,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                '${DateFormat('MMMM').format(state.datePicker == null ? DateTime.now() : state.datePicker!)}',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${DateFormat('yyyy').format(state.datePicker == null ? DateTime.now() : state.datePicker!)}',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Text(
                          ' ${packageModel.activityList!.length - 1}N / ${packageModel.activityList!.length}D'),
                    ),
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Return-Date',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "${DateFormat('d').format((state.datePicker == null ? DateTime.now() : state.datePicker!).add(Duration(days: packageModel.activityList!.length)))}",
                          style: GoogleFonts.nunito(
                            fontSize: 60,
                            fontWeight: FontWeight.w400,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${DateFormat('EE').format((state.datePicker == null ? DateTime.now() : state.datePicker!).add(Duration(days: packageModel.activityList!.length)))}',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            SizedBox(
                              height: 20,
                              child: VerticalDivider(
                                color: Colors.black,
                                width: 10,
                                thickness: 2,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              '${DateFormat('MMMM').format((state.datePicker == null ? DateTime.now() : state.datePicker!).add(Duration(days: packageModel.activityList!.length)))}',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${DateFormat('yyyy').format((state.datePicker == null ? DateTime.now() : state.datePicker!).add(Duration(days: packageModel.activityList!.length)))}',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
