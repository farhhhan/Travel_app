import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:travel_app/domain/bookedModel/bookeModel.dart';
import 'package:travel_app/presentation/userScreen/bookedpackage/bookedpackagedetials/bookingPackageDetials.dart';

class CustomHistory extends StatelessWidget {
  const CustomHistory({
    super.key,
    required this.booked,
  });

  final BookedModel booked;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double imageSize = width * 0.25; // Adjust image size based on width
        double padding = width * 0.02; // Adjust padding based on width

        return Padding(
          padding: EdgeInsets.all(padding),
          child: Card(
            color: Colors.grey[700],
            elevation: 0.4,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BookedPackageDetialsScreen(
                              packageModel: booked,
                            )));
              },
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: imageSize,
                      width: imageSize,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: booked.image!,
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
                    SizedBox(width: padding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${DateFormat('dMMMyyyy').format(DateTime.parse(booked.Trevelling_date!))}",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          SizedBox(height: padding),
                          Text(
                            booked.packageName!,
                            style: GoogleFonts.aBeeZee(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: padding),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          maxRadius: 6,
                          backgroundColor: booked.status == 'pending'
                              ? Colors.orange
                              : booked.status == 'Success'
                              ? Colors.green
                              : Colors.blue,
                        ),
                        SizedBox(height: padding / 2),
                        Text(
                          booked.status!,
                          style: GoogleFonts.aBeeZee(
                              fontSize: 14,
                              color: booked.status == 'pending'
                                  ? Colors.orange
                                  : booked.status == 'Success'
                                  ? Colors.green
                                  : Colors.blue
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
