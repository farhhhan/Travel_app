import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/application/bloc/Bottom/bottom_nav_bloc.dart';
import 'package:travel_app/application/bloc/SignUp/bloc/countery_bloc.dart';
import 'package:travel_app/application/bloc/agecyprofile/getAgency/bloc/agency_bloc.dart';
import 'package:travel_app/application/bloc/agencyindvPack/agency_indpack_bloc.dart';
import 'package:travel_app/application/bloc/bookedList/package_bloc.dart';
import 'package:travel_app/application/bloc/bookedPackageBloc/bloc/package_uid_bloc.dart';
import 'package:travel_app/application/bloc/bookedpackage%20copy/package_bloc.dart';
import 'package:travel_app/application/bloc/chatBloc/bloc/chat_room_bloc.dart';
import 'package:travel_app/application/bloc/faverot/bloc/favoret_bloc.dart';
import 'package:travel_app/application/bloc/filter/bloc/filter_bloc.dart';
import 'package:travel_app/application/bloc/imageBloc/bloc/img_bloc_bloc.dart';
import 'package:travel_app/application/bloc/packageBloc/bloc/package_bloc.dart';
import 'package:travel_app/application/bloc/profileUser/bloc/user_bloc.dart';
import 'package:travel_app/application/bloc/todo_bloc/todo_bloc.dart';
import 'package:travel_app/infrastructure/agencyPackageRepo.dart';
import 'package:travel_app/infrastructure/agencyRepo.dart';
import 'package:travel_app/infrastructure/bookedRepo.dart';
import 'package:travel_app/infrastructure/bookingInternational.dart';
import 'package:travel_app/infrastructure/chatRepo.dart';
import 'package:travel_app/infrastructure/favoret_repo/favouret.dart';
import 'package:travel_app/infrastructure/imageSearvice.dart';
import 'package:travel_app/infrastructure/package.dart';
import 'package:travel_app/infrastructure/package_indivutal.dart';
import 'package:travel_app/infrastructure/profileAuth.dart';
import 'package:travel_app/presentation/commentScreens/startScreen.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase based on platform
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDuHbcxY5PxMOq6nJ-VcAkLxp4LjPTCaYI",
      projectId: "travel-8c5ff",
      messagingSenderId: "750098882666",
      appId: "1:750098882666:android:bc0eaa696a0a8573916a13",
      storageBucket: 'travel-8c5ff.appspot.com',
    ));
  } else if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyB0g0UoVfj9I2g8xv2Un5uXTBcPx-RccbQ",
          authDomain: "travel-8c5ff.firebaseapp.com",
          databaseURL: "https://travel-8c5ff-default-rtdb.firebaseio.com",
          projectId: "travel-8c5ff",
          storageBucket: "travel-8c5ff.appspot.com",
          messagingSenderId: "750098882666",
          appId: "1:750098882666:web:7f846612087066a7916a13",
          measurementId: "G-1RLMNS6LPG"),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MaterialsScreen());
}

class MaterialsScreen extends StatefulWidget {
  const MaterialsScreen({Key? key}) : super(key: key);

  @override
  State<MaterialsScreen> createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CountryBloc>(create: (context) => CountryBloc()),
        BlocProvider<BottomNavBloc>(create: (context) => BottomNavBloc()),
        BlocProvider<ImgBlocBloc>(
            create: (context) => ImgBlocBloc(ImagePickerServices())),
        BlocProvider<UserBloc>(create: (context) => UserBloc(UserProfile())),
        BlocProvider<PackageBloc>(
            create: (context) => PackageBloc(PackageSearvicesRepo())),
        BlocProvider<AgencyBloc>(
            create: (context) => AgencyBloc(AgencyProfoRepo())),
        BlocProvider<AgencyIndvBloc>(
            create: (context) => AgencyIndvBloc(AgencyindvRepo())),
        BlocProvider<TodoBloc>(
            create: (context) => TodoBloc(BookingInternational())),
        BlocProvider<BookedBloc>(create: (context) => BookedBloc(BookedRepo())),
        BlocProvider<PackageUidBloc>(
            create: (context) => PackageUidBloc(IndivtualPackageRepo())),
        BlocProvider<ChatRoomBloc>(
            create: (context) => ChatRoomBloc(MessageRepo())),
        BlocProvider<bookedHistoryBloc>(
            create: (context) => bookedHistoryBloc(BookedRepo())),
        BlocProvider<FavoretBloc>(create: (context) => FavoretBloc(Wish())),
        BlocProvider<FilterBloc>(create: (context) => FilterBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: const Color(0xFF0A1529),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFFB325),
            secondary: const Color(0xFFFFB325),
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: StartScreen(),
      ),
    );
  }
}
