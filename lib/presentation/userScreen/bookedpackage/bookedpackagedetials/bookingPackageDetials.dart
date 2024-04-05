import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:travel_app/application/bloc/agecyprofile/getAgency/bloc/agency_bloc.dart';
import 'package:travel_app/application/bloc/bookedPackageBloc/bloc/package_uid_bloc.dart';
import 'package:travel_app/domain/bookedModel/bookeModel.dart';
import 'package:travel_app/domain/packageModel/packageModel.dart';
import 'package:travel_app/domain/taskModel/taskModel.dart';
import 'package:travel_app/presentation/commentScreens/bottom_navigator.dart';
import 'package:travel_app/presentation/custome_widget/custom_agency.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import cached_network_image

class BookedPackageDetialsScreen extends StatefulWidget {
  BookedPackageDetialsScreen({required this.packageModel, Key? key})
      : super(key: key);

  final BookedModel packageModel;

  @override
  State<BookedPackageDetialsScreen> createState() =>
      _BookedPackageDetialsScreenState();
}

class _BookedPackageDetialsScreenState
    extends State<BookedPackageDetialsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<PackageUidBloc>()
        .add(GetPackageEvent(uid: widget.packageModel.p_uid.toString()));
    context
        .read<AgencyBloc>()
        .add(GetAgencyData(uid: widget.packageModel.agency_uid.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PackageUidBloc, PackageUidState>(
        builder: (context, state) {
          if (state is PackageUidInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PackageLoadedState) {
            PackageModel packageModel = state.Package[0];
            return CustomScrollView(
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
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20)),
                  ),
                  title: Text(
                    packageModel.packageName!,
                    style: GoogleFonts.abhayaLibre(
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  expandedHeight: 250,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            packageModel.imageUrlList![0],
                          ),
                          fit: BoxFit.fill,
                        ),
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(20)),
                      ),
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
                              '${packageModel.packageName}',
                              style: GoogleFonts.aDLaMDisplay(
                                fontSize: 22,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              '${packageModel.activityList!.length.toString()} Days',
                              style: GoogleFonts.aDLaMDisplay(
                                fontSize: 22,
                                fontWeight: FontWeight.w300,
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
                              child: Text('${packageModel.packageLocation}'),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '₹ ${packageModel.packagePayment}',
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
                                    color: Colors.black,
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
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(packageModel.packageDesc!),
                      ),
                      Divider(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Package Details',
                          style: GoogleFonts.aDLaMDisplay(
                            fontSize: 22,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 170,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: packageModel.activityList!.length,
                          itemBuilder: (context, index) {
                            TaskModel task = TaskModel.fromMap(
                                packageModel.activityList![index]);
                            print(task.imageUrl);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  print("Task url is ${task.imageUrl}");
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
                                              child: Container(
                                                  color: Colors.grey)),
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
                        child: Text(
                          'Package Location',
                          style: GoogleFonts.aDLaMDisplay(
                            fontSize: 22,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 400,
                        child: GoogleMap(
                          onMapCreated: (GoogleMapController controller) {},
                          markers: Set.of({
                            Marker(
                              markerId: MarkerId('1'),
                              position: LatLng(
                                packageModel.packageLat!,
                                packageModel.packageLong!,
                              ),
                            )
                          }),
                          initialCameraPosition: CameraPosition(
                            bearing: 192.8334901395799,
                            target: LatLng(
                              packageModel.packageLat!,
                              packageModel.packageLong!,
                            ),
                            zoom: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Travellers List',
                          style: GoogleFonts.aDLaMDisplay(
                            fontSize: 22,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 20,
                              columns: const [
                                DataColumn(label: Text('Name')),
                                DataColumn(label: Text('Age')),
                                DataColumn(label: Text('Gender')),
                                DataColumn(label: Text('Passport No')),
                                DataColumn(label: Text('Expiry')),
                                DataColumn(label: Text('Country')),
                                DataColumn(label: Text('PAN Number')),
                                DataColumn(label: Text('Proof')),
                              ],
                              rows: List.generate(
                                widget.packageModel.TravellersList.length,
                                (index) {
                                  Map<String, dynamic> traveler =
                                      widget.packageModel.TravellersList[index];
                                  return DataRow(cells: [
                                    DataCell(Text(traveler['name'])),
                                    DataCell(Text(traveler['age'])),
                                    DataCell(Text(traveler['gender'])),
                                    DataCell(Text(traveler['passportNumber'])),
                                    DataCell(Text(traveler['expiry'])),
                                    DataCell(Text(traveler['issueingCountry'])),
                                    DataCell(Text(traveler['panNumber'])),
                                    DataCell(GestureDetector(
                                        onTap: () {
                                          showImage(
                                              context, traveler['pasImage']);
                                        },
                                        child: Icon(Icons.image))),
                                  ]);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Contact Detials',
                          style: GoogleFonts.aDLaMDisplay(
                            fontSize: 22,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Phone',
                                  style: GoogleFonts.aDLaMDisplay(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  widget.packageModel.traveller_number ??
                                      'No Number',
                                  style: GoogleFonts.aDLaMDisplay(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Email',
                                  style: GoogleFonts.aDLaMDisplay(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  widget.packageModel.traveller_email ??
                                      'No Number',
                                  style: GoogleFonts.aDLaMDisplay(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Country',
                                  style: GoogleFonts.aDLaMDisplay(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  widget.packageModel.traveller_country ??
                                      'No Number',
                                  style: GoogleFonts.aDLaMDisplay(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'State',
                                  style: GoogleFonts.aDLaMDisplay(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  widget.packageModel.treveller_state ??
                                      'No State',
                                  style: GoogleFonts.aDLaMDisplay(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'City',
                                  style: GoogleFonts.aDLaMDisplay(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  widget.packageModel.treveller_city ??
                                      'No Number',
                                  style: GoogleFonts.aDLaMDisplay(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'GST Address',
                                  style: GoogleFonts.aDLaMDisplay(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 190,
                                  child: Text(
                                    widget.packageModel.gstaddress ??
                                        'No Number',
                                    style: GoogleFonts.aDLaMDisplay(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      widget.packageModel.status == 'Rejected'
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rejected',
                                    style: GoogleFonts.aDLaMDisplay(
                                      fontSize: 22,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${widget.packageModel.reasons}',
                                    style: GoogleFonts.aDLaMDisplay(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 20,
                            ),
                      (widget.packageModel.status == 'Aprove' ||
                              widget.packageModel.status == 'Success')
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Contact Agency',
                                    style: GoogleFonts.aDLaMDisplay(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Agency Email',
                                    style: GoogleFonts.aDLaMDisplay(
                                      fontSize: 16,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  BlocBuilder<AgencyBloc, AgencyState>(
                                    builder: (context, state) {
                                      if (state is AgencyLoadingState) {
                                        return Shimmer.fromColors(
                                          child: CustomAgency(agencyData: []),
                                          baseColor: Colors.transparent,
                                          highlightColor: Colors.grey,
                                        );
                                      } else if (state is AgencyLodedState) {
                                        return Row(
                                          children: [
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              '${state.agencyData[0].email}',
                                              style: GoogleFonts.aDLaMDisplay(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Text('Error occurred');
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 20,
                            ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return SizedBox();
          }
        },
      ),
      bottomNavigationBar: widget.packageModel.status == 'Aprove'
          ? Container(
              height: 100,
              decoration: BoxDecoration(color: Colors.black87),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Current Status',
                        style: TextStyle(
                          letterSpacing: 2,
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '₹ ${widget.packageModel.totalPayment}',
                        style: TextStyle(
                          letterSpacing: 2,
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Razorpay razorpay = Razorpay();
                      var options = {
                        'key': 'rzp_test_1DP5mmOlF5G5ag',
                        'amount': widget.packageModel.totalPayment,
                        'name': 'Acme Corp.',
                        'description': 'Fine T-Shirt',
                        'retry': {'enabled': true, 'max_count': 1},
                        'send_sms_hash': true,
                        'prefill': {
                          'contact': '8888888888',
                          'email': 'test@razorpay.com'
                        },
                        'external': {
                          'wallets': ['paytm']
                        }
                      };
                      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                          handlePaymentErrorResponse);
                      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (success) {
                        handlePaymentSuccessResponse(context);
                      });

                      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                          handleExternalWalletSelected);
                      razorpay.open(options);
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: widget.packageModel.status == 'pending'
                              ? Colors.orange
                              : widget.packageModel.status == 'Success'
                                  ? Colors.green
                                  : widget.packageModel.status == 'Rejected'
                                      ? Colors.red
                                      : widget.packageModel.status == 'Aprove'
                                          ? Colors.yellow
                                          : Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          '${widget.packageModel.status}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(),
    );
  }

  void handlePaymentErrorResponse(BuildContext context, String errorMessage) {
    showAlertDialog(context, "Payment Failed", errorMessage);
  }

  void handlePaymentSuccessResponse(BuildContext context) {
    showAlertDialog(context, "Payment Successful", '');
    context.read<PackageUidBloc>().add(
        UpdatePaymentEvent(status: 'Success', uid: widget.packageModel.uid!));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => UserBottomNavScreen()),
        (route) => false);
  }

  void handleExternalWalletSelected(BuildContext context, String walletName) {
    showAlertDialog(context, "External Wallet Selected", walletName);
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showImage(BuildContext context, String image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: SizedBox(
                  height: 200,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              Positioned(
                top: 10.0,
                right: 10.0,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.black45),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
