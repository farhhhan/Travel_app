import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import cached_network_image
import 'package:travel_app/application/bloc/agencyindvPack/agency_indpack_bloc.dart';
import 'package:travel_app/domain/userModel/userModel.dart';
import 'package:travel_app/presentation/custome_widget/homeSkelton.dart';
import 'package:travel_app/presentation/userScreen/package/packageDetials.dart';

class AgencyIndvScreen extends StatefulWidget {
  AgencyIndvScreen({required this.agencyModel, Key? key}) : super(key: key);
  final UserModel agencyModel;

  @override
  _AgencyIndvScreenState createState() => _AgencyIndvScreenState();
}

class _AgencyIndvScreenState extends State<AgencyIndvScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context
        .read<AgencyIndvBloc>()
        .add(GetAgencyIndvEvent(uid: widget.agencyModel.uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading:   Row(
                children: [
                  SizedBox(width: 15,),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        maxRadius: 20,
                        backgroundColor: Colors.white,
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Flexible(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 220,
                      ),
                      Text(
                        widget.agencyModel.name,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.agencyModel.email,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                background: CachedNetworkImage(
                  imageUrl: widget.agencyModel.profile,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>SkeletonAnimation(child: Container(

                  )), 
                  errorWidget: (context, url, error) => Icon(Icons.error), 
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CupertinoSearchTextField(
                    controller: _searchController,
                    placeholder: 'Search',
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    onChanged: (value) {
                      context.read<AgencyIndvBloc>().add(SearchEvent(
                          value: value, uid: widget.agencyModel.uid));
                    },
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: BlocBuilder<AgencyIndvBloc, AgencyIndvState>(
            builder: (context, state) {
              if (state is AgencyIndvLodedstate) {
                return CustomScrollView(
                  slivers: [
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PackageDetailScreen(
                                    packageModel: state.packageList[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider( 
                                    state.packageList[index].imageUrlList![0],
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextScroll(
                                      '${state.packageList[index].packageName}',
                                      mode: TextScrollMode.endless,
                                      velocity: Velocity(
                                          pixelsPerSecond: Offset(70, 0)),
                                      delayBefore: Duration(milliseconds: 600),
                                      numberOfReps: 5,
                                      pauseBetween: Duration(milliseconds: 70),
                                      style: GoogleFonts.aBeeZee(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      textAlign: TextAlign.right,
                                      selectable: true,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: TextScroll(
                                        '${state.packageList[index].packageLocation}',
                                        mode: TextScrollMode.endless,
                                        velocity: Velocity(
                                            pixelsPerSecond: Offset(70, 0)),
                                        delayBefore:
                                            Duration(milliseconds: 600),
                                        numberOfReps: 5,
                                        pauseBetween:
                                            Duration(milliseconds: 70),
                                        style: GoogleFonts.aBeeZee(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900,
                                        ),
                                        textAlign: TextAlign.right,
                                        selectable: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: state.packageList.length,
                      ),
                    ),
                  ],
                );
              } else if (state is LoadingState) {
                return custom_gridviews(
                  count: 10,
                  height: 300,
                  widht: 300,
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
