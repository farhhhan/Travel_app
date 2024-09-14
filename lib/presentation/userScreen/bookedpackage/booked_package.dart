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
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                DateFormat.MMMEd().format(DateTime.now()),
                style: GoogleFonts.abhayaLibre(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ),
            const custom_showDate(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Schedules',
                style: ThemeDataColors.roboto(
                  colors: Colors.white,
                  fontsize: 28,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<BookedBloc, BookedState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const CustomBookSkeltom();
                  } else if (state is LoadedState) {
                    if (state.bookedList.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Looks Empty. No upcoming trips available',
                              style: GoogleFonts.abhayaLibre(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Book Your Trip'),
                            ),
                          ],
                        ),
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
                      child: Text(
                        'Error Occurred',
                        style: GoogleFonts.abhayaLibre(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
