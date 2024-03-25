import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/application/bloc/bookedList/package_bloc.dart';
import 'package:travel_app/domain/bookedModel/bookeModel.dart';
import 'package:travel_app/presentation/custome_widget/custom_showdate.dart';
import 'package:travel_app/presentation/themeData/themeDataColors.dart';
import 'package:travel_app/presentation/custome_widget/custom_bookskell.dart';
import 'package:travel_app/presentation/userScreen/history/custom_widget/custom_historyCard.dart';

class BookedScreen extends StatefulWidget {
  const BookedScreen({Key? key}) : super(key: key);

  @override
  State<BookedScreen> createState() => _BookedScreenState();
}

class _BookedScreenState extends State<BookedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookedBloc>().add(GetBookedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '${DateFormat.MMMEd().format(DateTime.now())}',
              style: GoogleFonts.abhayaLibre(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
         custom_showDate(),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text('Schedules',
                  style: ThemeDataColors.roboto(
                      colors: Colors.white, fontsize: 28)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 400,
            child: BlocBuilder<BookedBloc, BookedState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return CustomBookSkeltom();
                } else if (state is LoadedState) {
                  if (state.bookedList.length <= 0) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Booking Is Empty',
                            style: GoogleFonts.aBeeZee(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Book Your trip'))
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.bookedList.length,
                    itemBuilder: (context, index) {
                      BookedModel booked = state.bookedList[index];
                      return custom_history(booked: booked);
                    },
                  );
                } else {
                  return Center(
                    child: Text('Error Occurred'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
