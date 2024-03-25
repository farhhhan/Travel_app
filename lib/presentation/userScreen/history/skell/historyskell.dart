import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/presentation/custome_widget/custom_bookskell.dart';

class custom_historySKell extends StatelessWidget {
  const custom_historySKell({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return custom_skel(
            heiht: 120,
            width: 400,
            radius: 10,
          );
        },
      ),
    );
  }
}
