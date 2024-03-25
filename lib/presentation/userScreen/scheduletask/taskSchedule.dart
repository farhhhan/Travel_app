import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:travel_app/domain/packageModel/packageModel.dart';
import 'package:travel_app/domain/taskModel/taskModel.dart';
import 'package:travel_app/presentation/custome_widget/widgets/bottom_rounded_clipper.dart';
import 'package:travel_app/presentation/custome_widget/widgets/order_button.dart';
import 'package:travel_app/presentation/custome_widget/widgets/pizza_size.dart';
import 'package:travel_app/presentation/custome_widget/widgets/task_details.dart';

class TaskDetialsScreen extends StatefulWidget {
  TaskDetialsScreen({Key? key, required this.packageModel}) : super(key: key);
  PackageModel packageModel;

  @override
  _TaskDetialsScreenState createState() => _TaskDetialsScreenState();
}

class _TaskDetialsScreenState extends State<TaskDetialsScreen> {
  final PageController _titleSlideController = PageController();
  final PageController _imageSlideController = PageController(
    viewportFraction: 0.70,
  );
  final PageController _detailsSlideController = PageController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      _imageSlideController.animateToPage(1,
          duration: const Duration(milliseconds: 400), curve: Curves.linear);
    });
    _imageSlideController.addListener(() {
      _titleSlideController.jumpTo(_imageSlideController.offset * 0.148);
      _detailsSlideController.jumpTo(_imageSlideController.offset * 0.5621);
    });
  }

  @override
  void dispose() {
    _titleSlideController.dispose();
    _imageSlideController.dispose();
    _detailsSlideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: BottomRoundedClipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 450,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 8, 47, 81),
                    ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 45,
                        child: PageView.builder(
                          itemCount: widget.packageModel.activityList!.length,
                          controller: _titleSlideController,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            TaskModel task = TaskModel.fromMap(
                                widget.packageModel.activityList![index]);
                            return Text(
                              task.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 320,
                        child: AnimatedBuilder(
                            animation: _imageSlideController,
                            builder: (context, child) {
                              return PageView.builder(
                                itemCount:
                                    widget.packageModel.activityList!.length,
                                controller: _imageSlideController,
                                onPageChanged: (page) {},
                                itemBuilder: (context, index) {
                                  double value = 0.0;

                                  if (_imageSlideController
                                      .position.haveDimensions) {
                                    value = index.toDouble() -
                                        (_imageSlideController.page ?? 0);
                                    value = (value * 0.7).clamp(-1, 1);
                                  }
                                  TaskModel task = TaskModel.fromMap(
                                      widget.packageModel.activityList![index]);
                                  return Align(
                                    alignment: Alignment.topCenter,
                                    child: Transform.translate(
                                      offset:
                                          Offset(0, 10 + (value.abs() * 40)),
                                      child: Transform.scale(
                                        scale: 1 - (value.abs() * 0.4),
                                        child: Transform.rotate(
                                          angle: value * 5,
                                        
                                          child: Container(
                                            height: 310,
                                            
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                              child: CachedNetworkImage(
                                                imageUrl: task.imageUrl,
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) =>
                                                    SkeletonAnimation(
                                                        child: Container(
                                                            color:
                                                                Colors.grey)),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedBuilder(
                        animation: _detailsSlideController,
                        builder: (context, child) {
                          return SizedBox(
                            height: 170,
                            child: PageView.builder(
                              itemCount:
                                  widget.packageModel.activityList!.length,
                              controller: _detailsSlideController,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                double value = 0.0;

                                if (_detailsSlideController
                                    .position.haveDimensions) {
                                  value = index.toDouble() -
                                      (_detailsSlideController.page ?? 0);
                                  value = (value * 0.9);
                                }
                                TaskModel task = TaskModel.fromMap(
                                    widget.packageModel.activityList![index]);
                                return Opacity(
                                  opacity: 1 - value.abs(),
                                  child: TaskDesc(
                                    task: task,
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: OrderButton(
        packageModel: widget.packageModel,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
