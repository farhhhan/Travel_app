import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/application/bloc/Bottom/bottom_nav_bloc.dart';
import 'package:travel_app/application/bloc/profileUser/bloc/user_bloc.dart';
import 'package:travel_app/presentation/userScreen/auth/login/user_login.dart';
import 'package:travel_app/presentation/userScreen/wishlist/wish.dart';

class UserProfileScreen extends StatelessWidget {
   UserProfileScreen({Key? key}) : super(key: key);

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.circular(40),
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.person_outline,
                    color: Colors.blue,
                  ),
                  title: Text(
                    'Profile Detials',
                  ),
                  subtitle: Text('View & Edit Detials'),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue,
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WishScreen()));
                  },
                  title: Text(
                    'Wish List',
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.lock,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      context.read<BottomNavBloc>().add(LogoutEvent(0));
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserLoginScreen()),
                          (route) => false);
                    });
                  },
                  title: Text(
                    'Logount',
                  ),
                  trailing: Icon(
                    Icons.logout,
                    color: Colors.blue,
                  ),
                ),
              ],)
            );
  }
}
