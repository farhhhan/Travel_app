import 'package:flutter/material.dart';
import 'package:travel_app/domain/userModel/userModel.dart';
import 'package:travel_app/presentation/themeData/themeDataColors.dart';

class UserDetails extends StatelessWidget {
  UserDetails({super.key, required this.userModel});
  UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20),
      decoration: BoxDecoration(
          color: Colors.grey[600], borderRadius: BorderRadius.circular(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                "My Profile",
                style: ThemeDataColors.roboto(
                  colors: Colors.white,
                  fontsize: 22
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Container(
                  width: 80.00,
                  height: 80.00,
                  decoration: BoxDecoration(
                    color: Colors.amber[600],
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage(userModel.profile),
                      fit: BoxFit.fitHeight,
                    ),
                  )),
              const SizedBox(
                width: 25,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${userModel.name}",
                    style: ThemeDataColors.normalText(fontsize: 20,colors: Colors.white)
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "${userModel.email}",
                      style:ThemeDataColors.normalText(fontsize: 17,colors: Colors.white)
                    ),
                  ),
                  Text(
                    "User ID: 156A860",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                        fontSize: 14),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const TabBar(
            indicatorPadding: EdgeInsets.all(5),
            indicatorColor: Colors.amber,
            labelColor: Colors.black,
            labelStyle: TextStyle(
                fontFamily: "Averta",
                fontWeight: FontWeight.w600,
                fontSize: 16),
            tabs: [
              Tab(text: "Account"),
              Tab(text: "Payments"),
              Tab(text: "History"),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
