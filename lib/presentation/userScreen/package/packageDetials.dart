import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:travel_app/application/bloc/agecyprofile/getAgency/bloc/agency_bloc.dart';
import 'package:travel_app/application/bloc/faverot/bloc/favoret_bloc.dart';
import 'package:travel_app/domain/packageModel/packageModel.dart';
import 'package:travel_app/domain/taskModel/taskModel.dart';
import 'package:travel_app/presentation/custome_widget/widgets/order_button.dart';
import 'package:travel_app/presentation/userScreen/chat/chatScreen.dart';
import 'package:travel_app/presentation/custome_widget/custom_agency.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:travel_app/presentation/userScreen/scheduletask/taskSchedule.dart';

class PackageDetailScreen extends StatefulWidget {
  PackageDetailScreen({this.netImage, required this.packageModel, Key? key})
      : super(key: key);

  final PackageModel packageModel;
  final String? netImage;
  @override
  State<PackageDetailScreen> createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  @override
  void initState() {
    print(widget.packageModel.uid);
    super.initState();
    context
        .read<AgencyBloc>()
        .add(GetAgencyData(uid: widget.packageModel.uid.toString()));
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(
        widget.packageModel.packageLat!,
        widget.packageModel.packageLong!,
      ),
      zoom: 12,
    );

    return Scaffold(
      floatingActionButton: BlocBuilder<AgencyBloc, AgencyState>(
        builder: (context, state) {
          if (state is AgencyLodedState) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatsScreen(userModel: state.agencyData[0]),
                    ));
              },
              child: CircleAvatar(
                backgroundColor: Colors.green,
                maxRadius: 35,
                child: ClipOval(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.network(
                    'https://th.bing.com/th/id/OIP.hKmJjrBV7qERsW4IC4NF3QHaHa?pid=ImgDet&w=203&h=203&c=7&dpr=1.3',
                  ),
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('wish_lists')
                      .where('u_uid',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .where('p_uid', isEqualTo: widget.packageModel.puid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return CircleAvatar(
                        maxRadius: 30,
                        backgroundColor: Colors.white,
                        child: Center(
                          child: Icon(
                            Icons.favorite,
                            color: Colors.grey[300],
                            size: 40,
                          ),
                        ),
                      );
                    }
                    return InkWell(
                      onTap: () {
                        if (snapshot.data!.docs.length == 0) {
                          context.read<FavoretBloc>().add(
                              AddWishEvent(packageModel: widget.packageModel));
                        } else {
                          String? uid;
                          snapshot.data!.docs.forEach((element) {
                            uid = element['w_uid'];
                          });
                          context
                              .read<FavoretBloc>()
                              .add(RemoveWishEvent(w_uid: uid!));
                        }
                      },
                      child: CircleAvatar(
                        maxRadius: 30,
                        backgroundColor: Colors.white,
                        child: Center(
                          child: Icon(
                            Icons.favorite,
                            size: 40,
                            color: snapshot.data!.docs.length == 0
                                ? Colors.grey[300]
                                : Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
            title: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    Color(0xFF004EFF), // Deep Blue
                    Color(0xFF00D2FF),
                  ], // Example gradient colors
                ).createShader(bounds);
              },
              child: TextScroll(
                '${widget.packageModel.packageName}',
                mode: TextScrollMode.endless,
                velocity: Velocity(pixelsPerSecond: Offset(70, 0)),
                delayBefore: Duration(milliseconds: 600),
                numberOfReps: 5,
                pauseBetween: Duration(milliseconds: 70),
                style: GoogleFonts.abhayaLibre(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.right,
                selectable: true,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          widget.packageModel.imageUrlList?[0] ??
                              widget.netImage ??
                              '',
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),
            elevation: 10,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                BlocBuilder<AgencyBloc, AgencyState>(
                  builder: (context, state) {
                    if (state is AgencyLoadingState) {
                      return Shimmer.fromColors(
                        child: CustomAgency(agencyData: []),
                        baseColor: Colors.transparent,
                        highlightColor: Colors.grey,
                      );
                    } else if (state is AgencyLodedState) {
                      return CustomAgency(agencyData: state.agencyData);
                    } else {
                      return Text('Error occurred');
                    }
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.packageModel.packageName}',
                        style: GoogleFonts.aDLaMDisplay(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${widget.packageModel.activityList!.length.toString()} Days',
                        style: GoogleFonts.aDLaMDisplay(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_history),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text('${widget.packageModel.packageLocation}'),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '₹ ${widget.packageModel.packagePayment}',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Per Head',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Package Description',
                    style: GoogleFonts.aDLaMDisplay(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(widget.packageModel.packageDesc!),
                ),
                Divider(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Package Details',
                    style: GoogleFonts.aDLaMDisplay(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.packageModel.activityList!.length,
                    itemBuilder: (context, index) {
                      TaskModel task = TaskModel.fromMap(
                          widget.packageModel.activityList![index]);
                      print(task.imageUrl);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TaskDetialsScreen(
                                          packageModel: widget.packageModel,
                                        )));
                          },
                          child: Container(
                            height: 60,
                            width: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: task.imageUrl,
                                fit: BoxFit.fill,
                                placeholder: (context, url) =>
                                    SkeletonAnimation(
                                        child: Container(color: Colors.grey)),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        'Package Location',
                        style: GoogleFonts.aDLaMDisplay(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 400,
                  child: GoogleMap(
                    onMapCreated: (GoogleMapController controller) {},
                    markers: Set.of({
                      Marker(
                        markerId: MarkerId('1'),
                        position: LatLng(
                          widget.packageModel.packageLat!,
                          widget.packageModel.packageLong!,
                        ),
                      )
                    }),
                    initialCameraPosition: _kLake,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    OrderButton(
                      packageModel: widget.packageModel,
                    ),
                  ],
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
