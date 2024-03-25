import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class HomeScreenSkelton extends StatelessWidget {
  const HomeScreenSkelton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               custom_buidSkel(height: 30, widht: 150, count: 1),
               custom_buidSkel(height: 30, widht: 100, count: 1),
               custom_buidSkel(height: 130, widht: 70, count: 8),
              custom_buidSkel(height: 200, widht: 400, count: 8),
                custom_buidSkel(height: 50, widht: 300, count: 1),
              custom_buidSkel(
                count: 8,
                height: 260,
                widht: 150,
              ),
              custom_buidSkel(height: 50, widht: 300, count: 1),
              custom_buidSkel(
                count: 8,
                height: 260,
                widht: 150,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class custom_buidSkel extends StatelessWidget {
   custom_buidSkel({
    super.key,
    required this.height,
    required this.widht,
    required this.count
  });
  double height;
  double widht;
   int count;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: SizedBox(
        height: height,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: count,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SkeletonAnimation(
                child: Container(
                  height: height,
                  width: widht,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(31, 189, 184, 184),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
class custom_gridviews extends StatelessWidget {
   custom_gridviews({
    super.key,
    required this.height,
    required this.widht,
    required this.count
  });
  double height;
  double widht;
   int count;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: SizedBox(
        child: GridView.builder(
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SkeletonAnimation(
                child: Container(
                  height: height,
                  width: widht,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(31, 189, 184, 184),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
