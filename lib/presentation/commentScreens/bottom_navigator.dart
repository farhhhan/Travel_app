import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/application/bloc/Bottom/bottom_nav_bloc.dart';
import 'package:travel_app/presentation/userScreen/bookedpackage/booked_package.dart';
import 'package:travel_app/presentation/userScreen/chatroomlist/chat_list.dart';
import 'package:travel_app/presentation/userScreen/home/user_home.dart';
import 'package:travel_app/presentation/userScreen/my_profile/page.dart';

// class UserBottomNavScreen extends StatefulWidget {
//   const UserBottomNavScreen({super.key});

//   @override
//   State<UserBottomNavScreen> createState() => _UserBottomScreenState();
// }

// class _UserBottomScreenState extends State<UserBottomNavScreen> {
//   List<Widget> screens = [
//     const UserHomeScreen(),
//     const ChatRoomListScreen(),
//     const BookedScreen(),
//     const MyProfilePage(),
//   ];
//   int selectedIndex = 0;
//   @override
//   GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: BlocBuilder<BottomNavBloc, BottomNavState>(
//         builder: (context, state) {
//           return Scaffold(
//               extendBody: true,
//               bottomNavigationBar: CurvedNavigationBar(
//                 buttonBackgroundColor: Colors.grey[700],
//                 backgroundColor: Colors.transparent,
//                 color: Colors.black,
//                 key: _bottomNavigationKey,
//                 items: <Widget>[
//                   Icon(Icons.home_outlined, size: 30),
//                   Icon(Icons.chat, size: 30),
//                   Icon(Icons.list, size: 30),
//                   Icon(Icons.person, size: 30),
//                 ],
//                 onTap: (index) {
//                    context.read<BottomNavBloc>().add(changeEvent(index));
//                 },
//               ),
//               body: screens[state.index]);
//         },
//       ),
//     );
//   }
// }
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
                _buildNavItem(Icons.person, 3),
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
}
