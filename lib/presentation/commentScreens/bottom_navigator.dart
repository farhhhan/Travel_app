import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/application/bloc/Bottom/bottom_nav_bloc.dart';
import 'package:travel_app/application/bloc/profileUser/bloc/user_bloc.dart';
import 'package:travel_app/presentation/userScreen/bookedpackage/booked_package.dart';
import 'package:travel_app/presentation/userScreen/chatroomlist/chat_list.dart';
import 'package:travel_app/presentation/userScreen/home/user_home.dart';
import 'package:travel_app/presentation/userScreen/my_profile/page.dart';


class UserBottomNavScreen extends StatefulWidget {
  const UserBottomNavScreen({Key? key}) : super(key: key);

  @override
  State<UserBottomNavScreen> createState() => _UserBottomNavScreenState();
}

class _UserBottomNavScreenState extends State<UserBottomNavScreen> {
  final List<Widget> _screens = [
    const UserHomeScreen(),
    const ChatRoomListScreen(),
    const BookedScreen(),
    const MyProfilePage(),
  ];

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      body: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          return _screens[state.index];
        },
      ),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.infinite,
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            height: 75,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.8),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildNavItem(Icons.home_outlined, 0),
                _buildNavItem(Icons.chat, 1),
                _buildNavItem(Icons.list, 2),
                _buildProfile(Icons.person, 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<BottomNavBloc>().add(changeEvent(index));
          },
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: state.index == index
                  ? Colors.blue.withOpacity(0.7)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: state.index == index ? Colors.white : Colors.grey,
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfile(IconData icon, int index) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<BottomNavBloc>().add(changeEvent(index));
          },
          borderRadius: BorderRadius.circular(15),
          child: BlocBuilder<UserBloc, UserProfileState>(
            builder: (context, state) {
              if (state is UserLodedState) {
                if (state.agencyData.isNotEmpty) {
                  return GestureDetector(
                    onTap: () {
                      context.read<BottomNavBloc>().add(changeEvent(index));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 20.0, // Adjust the radius as needed
                        backgroundImage: CachedNetworkImageProvider(
                            state.agencyData[0].profile),
                        backgroundColor: Colors.transparent,
                        onBackgroundImageError: (_, __) {
                          // Optional: Handle image loading error
                        },
                      ),
                    ),
                  );
                }
              }
              // Return a default profile icon if user data is not available
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
