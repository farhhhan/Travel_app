import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/application/bloc/Bottom/bottom_nav_bloc.dart';
import 'package:travel_app/presentation/userScreen/auth/login/user_login.dart';
import 'package:travel_app/presentation/userScreen/wishlist/wish.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({Key? key}) : super(key: key);

  User? user = FirebaseAuth.instance.currentUser;
  final Uri _shopexprivacy = Uri.parse(
      'https://www.freeprivacypolicy.com/live/8c29f4bc-3cec-4541-9124-cc04121e6da8');
  Future<void> privacy() async {
    if (!await launchUrl(_shopexprivacy)) {
      throw Exception('could not laounch $_shopexprivacy');
    }
  }

  final Uri _shopexTerms = Uri.parse(
      'https://www.termsofusegenerator.net/live.php?token=hQXkuWCxl79GsIhmdqIhyu3HzaJypFd4');
  Future<void> terms() async {
    if (!await launchUrl(_shopexTerms)) {
      throw Exception('could not laounch $_shopexTerms');
    }
  }

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
                onTap: () async {
                  await terms();
                },
                leading: Icon(
                  Icons.edit_document,
                  color: Colors.blue,
                ),
                title: Text(
                  'Terms &  Use',
                )),
            ListTile(
              onTap: () async {
                await privacy();
              },
              leading: Icon(
                Icons.privacy_tip,
                color: Colors.blue,
              ),
              title: Text(
                'Privacy Policy',
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.lock,
                color: Colors.blue,
              ),
              onTap: () {
                showDailoges(context,'Do you want logout');
              },
              title: Text(
                'Logout',
              ),
              trailing: Icon(
                Icons.logout,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('V 2.0.0',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 22,
                        fontWeight: FontWeight.w800)),
              ],
            ),
          ],
        ));
  }

  void showDailoges(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert Dialog'),
          content: Text('${content}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  context.read<BottomNavBloc>().add(LogoutEvent(0));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserLoginScreen()),
                      (route) => false);
                });
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

}
