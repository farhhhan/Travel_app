import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import cached_network_image package
import 'package:travel_app/domain/advertesment/adModel.dart';
import 'package:travel_app/domain/packageModel/packageModel.dart';
import 'package:travel_app/presentation/userScreen/filter_search/widgets/package_card.dart';
import 'package:travel_app/presentation/userScreen/home/user_home.dart';
import 'package:travel_app/presentation/userScreen/package/packageDetials.dart';


class CustomSliderOne extends StatelessWidget {
  const CustomSliderOne({
    Key? key,
    required this.packageList,
    required this.ratio,
    required this.center,
    required this.isCard
  }) : super(key: key);

  final List<PackageModel> packageList;
  final double ratio;
  final bool center;
  final bool isCard;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CarouselSlider.builder(
        itemCount: packageList.length,
        itemBuilder: (BuildContext context, int index, int pageViewIndex) {
          if(isCard){
            return Padding(
              padding: const EdgeInsets.only(left:10.0,bottom: 5),
              child: PackageCard(packageModel:packageList[index]),
            );
          }else{
            return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PackageDetailScreen(packageModel: packageList[index]),
                ),
                );
              },
              child: Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     custom_scrollText(content: '${packageList[index].packageName}', size: 24),
                     custom_scrollText(content: '${packageList[index].packageLocation}', size: 12)
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      packageList[index].imageUrlList![0],
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          );
          }
        },
        options: CarouselOptions(
          scrollPhysics: BouncingScrollPhysics(),
          autoPlayAnimationDuration: Duration(seconds: 2),
          autoPlay: true,
          aspectRatio: .1,
          animateToClosest: true,
          viewportFraction: ratio,
          enlargeCenterPage: center,
        ),
      ),
    );
  }
}

class CustomAd extends StatelessWidget {
  const CustomAd({
    Key? key,
    required this.addlist,
    required this.ratio,
  }) : super(key: key);

  final List<adModel> addlist;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: CarouselSlider.builder(
        itemCount: addlist.length,
        itemBuilder: (BuildContext context, int index, int pageViewIndex) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: addlist[index].imageUrl,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Center(
                        child: SkeletonAnimation(
                            child: Container(
                      color: Colors.black38,
                    ))),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          scrollPhysics: BouncingScrollPhysics(),
          autoPlayAnimationDuration: Duration(seconds: 2),
          autoPlay: true,
          aspectRatio: .1,
          animateToClosest: true,
          viewportFraction: ratio,
          enlargeCenterPage: true,
        ),
      ),
    );
  }
}
