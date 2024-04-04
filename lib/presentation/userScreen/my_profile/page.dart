import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/application/bloc/profileUser/bloc/user_bloc.dart';
import 'package:travel_app/presentation/custome_widget/custom_bookskell.dart';
import 'package:travel_app/presentation/userScreen/history/history.dart';
import 'package:travel_app/presentation/userScreen/my_profile/widgets/user_details.dart';
import 'package:travel_app/presentation/userScreen/profile/user_profile.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserBloc>().add(GetUserEvent());
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<UserBloc, UserProfileState>(
                builder: (context, state) {
                   if(state is UserLodedState){
                    return   UserDetails(
                      userModel: state.agencyData[0],
                    );
                   }else{
                    return Center(
                      child: custom_skel(heiht: 200, width: 400)
                    );
                   }
                }
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    UserProfileScreen(),
                   BookedHistory(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
