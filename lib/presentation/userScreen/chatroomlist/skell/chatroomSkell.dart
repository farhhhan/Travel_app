import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/presentation/custome_widget/custom_bookskell.dart';

class custom_chatSKell extends StatelessWidget {
  const custom_chatSKell({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return custom_chstList();
        },
      ),
    );
  }
}
class custom_chstList extends StatelessWidget {
  const custom_chstList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        custom_skel(
          heiht: 60,
          width: 60,
          radius: 120,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            custom_skel(heiht: 20, width: 130),
            custom_skel(heiht: 20, width: 80)
          ],
        ),
      ],
    );
  }
}