import 'package:cached_network_image/cached_network_image.dart'; // Import CachedNetworkImage package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:travel_app/application/bloc/Bottom/bottom_nav_bloc.dart';
import 'package:travel_app/application/bloc/imageBloc/bloc/img_bloc_bloc.dart';
import 'package:travel_app/application/bloc/packageBloc/bloc/package_bloc.dart';
import 'package:travel_app/application/bloc/profileUser/bloc/user_bloc.dart';
import 'package:travel_app/presentation/custome_widget/custom_slider.dart';
import 'package:travel_app/presentation/custome_widget/homeSkelton.dart';
import 'package:travel_app/presentation/custome_widget/widgets/bottom_rounded_clipper.dart';
import 'package:travel_app/presentation/userScreen/package/packageDetials.dart';
import 'package:travel_app/presentation/userScreen/seeall/see_all.dart';
import 'package:travel_app/theme/firebase_notification.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PackageBloc>().add(GetPackagesEvent());
    context.read<UserBloc>().add(GetUserEvent());
     context.read<ImgBlocBloc>().add(SaveEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      body: BlocBuilder<PackageBloc, PackageState>(
        builder: (context, state) {
          if (state is PackageLoading) {
            return Center(
              child: HomeScreenSkelton(),
            );
          } else if (state is packageLoaded) {
            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        ClipPath(
                          clipper: BottomRoundedClipper(),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 260,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 8, 47, 81),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 2,
                          left: 20,
                          right: 20,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BlocBuilder<UserBloc, UserProfileState>(
                                builder: (context, state) {
                                  if (state is UserLodedState) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500
                                            ),"Hi ${state.agencyData[0].name},"),
                                            Text(style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                        ),"Here are your trip"),
                                          ],
                                        ),

                                        
                                        GestureDetector(
                                          onTap: (){
                                             context.read<BottomNavBloc>().add(changeEvent(3));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              radius:
                                                  30.0, // Adjust the radius as needed
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                      state.agencyData[0].profile),
                                              backgroundColor: Colors.transparent,
                                              onBackgroundImageError: (_, __) {
                                                // Optional: Handle image loading error
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey,
                                        child: Icon(Icons.person,
                                            color: Colors.white),
                                      ),
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('hello');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SeeAllScreen(
                                              name: 'Search Package',
                                              packagelist: state.listPackages,
                                            )),
                                  );
                                },
                                behavior: HitTestBehavior.translucent,
                                child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(
                                          Icons.search,
                                          color: Colors.black,
                                          weight: 900,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text('Search',
                                            style: TextStyle(color: Colors.black))
                                      ],
                                    )),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              state.adList.isNotEmpty
                                  ? custome_homeText(text: 'New Offers')
                                  : SizedBox()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverAppBar(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(20))),
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    expandedHeight: 200, // Adjusted height
                    flexibleSpace: FlexibleSpaceBar(
                      background: InkWell(
                        onTap: () {},
                        child: CustomAd(addlist: state.adList, ratio: .97),
                      ),
                    ),
                    elevation: 10,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              custome_homeText(text: 'Best Package'),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SeeAllScreen(
                                            name: 'Best',
                                            packagelist: state.listBest,
                                          ),
                                        ));
                                  },
                                  child: Text('See All'))
                            ],
                          ),
                        ),
                        state.listBest.isNotEmpty
                            ? CustomSliderOne(
                                isCard: false,
                                center: false,
                                packageList: state.listBest,
                                ratio: .5)
                            : SizedBox(),
                        SizedBox(
                          height: 20,
                        ),
                        state.listRecomented.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    custome_homeText(text: 'Recommended Package'),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SeeAllScreen(
                                                  name: 'Recommended',
                                                  packagelist:
                                                      state.listRecomented,
                                                ),
                                              ));
                                        },
                                        child: Text('See All'))
                                  ],
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 20,
                        ),
                        state.listRecomented.isNotEmpty
                            ? CustomSliderOne(
                                isCard: false,
                                center: true,
                                packageList: state.listRecomented,
                                ratio: .8,
                              )
                            : SizedBox(),
                        custome_homeText(text: 'New Packages'),
                      ],
                    ),
                  ),
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 0.75,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        if (index < state.listPackages.length) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PackageDetailScreen(
                                        packageModel: state.listPackages[index]),
                                  ),
                                );
                              },
                              child: Container(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      custom_scrollText(
                                        content:
                                            '${state.listPackages[index].packageName}',
                                        size: 24,
                                      ),
                                      custom_scrollText(
                                          content:
                                              '${state.listPackages[index].packageLocation}',
                                          size: 12)
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      state.listPackages[index].imageUrlList![0],
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                      childCount: state.listPackages.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 100),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: Text('Something went wrong!'),
            );
          }
        },
      ),
    );
  }
}

class custom_scrollText extends StatelessWidget {
  custom_scrollText({super.key, required this.content, required this.size});
  String content;
  double size;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [(Colors.white), (Colors.white)], // Example gradient colors
        ).createShader(bounds);
      },
      child: TextScroll(
        content,
        mode: TextScrollMode.endless,
        velocity: Velocity(pixelsPerSecond: Offset(70, 0)),
        delayBefore: Duration(milliseconds: 600),
        numberOfReps: 5,
        pauseBetween: Duration(milliseconds: 70),
        style: GoogleFonts.aBeeZee(
          color: Colors.white,
          fontSize: size,
          fontWeight: FontWeight.w900,
        ),
        textAlign: TextAlign.right,
        selectable: true,
      ),
    );
  }
}

class custome_homeText extends StatelessWidget {
  custome_homeText({super.key, required this.text});
  String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: [(Colors.white), (Colors.white)],
          ).createShader(bounds);
        },
        child: Text(
          text,
          style: GoogleFonts.aBeeZee(fontSize: 22, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
