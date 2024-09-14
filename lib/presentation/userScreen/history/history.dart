import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/application/bloc/bookedpackage%20copy/package_bloc.dart';
import 'package:travel_app/domain/bookedModel/bookeModel.dart';
import 'package:travel_app/presentation/userScreen/history/custom_widget/custom_historyCard.dart';
import 'package:travel_app/presentation/userScreen/history/skell/historyskell.dart';

class BookedHistory extends StatefulWidget {
  const BookedHistory({super.key});

  @override
  State<BookedHistory> createState() => _BookedHistoryState();
}

class _BookedHistoryState extends State<BookedHistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<bookedHistoryBloc>().add(GetBookedHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<bookedHistoryBloc, BookedHistoryState>(
              builder: (context, state) {
                if (state is bookedingLoading) {
                  return custom_historySKell();
                } else if (state is Bookedloaded) {
                  if (state.bookedList.length <= 0) {
                    return ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Your History Is Empty',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              'Book Your Trip',
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
                                child: Text('Empty  Booking'))
                          ],
                        ),
                      ],
                    );
                  }
                  return ListView.builder(
                    itemCount: state.bookedList.length,
                    itemBuilder: (context, index) {
                      BookedModel booked = state.bookedList[index];
                      return CustomHistory(booked: booked);
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
