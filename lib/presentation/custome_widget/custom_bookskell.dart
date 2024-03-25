import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class CustomBookSkeltom extends StatelessWidget {
  const CustomBookSkeltom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Row(
            children: [
              custom_skel(heiht: 130, width: 100),
              Column(
                children: [
                  custom_skel(heiht: 20, width: 130),
                  custom_skel(heiht: 20, width: 80)
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class custom_skel extends StatelessWidget {
  custom_skel({
     this.radius
    ,super.key, required this.heiht, required this.width});
  double heiht;
  double width;
  double? radius;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SkeletonAnimation(
        child: Container(
          height: heiht,
          width: width,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(radius ?? 20)),
        ),
      ),
    );
  }
}