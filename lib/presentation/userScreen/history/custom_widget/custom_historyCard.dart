
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:travel_app/domain/bookedModel/bookeModel.dart';
import 'package:travel_app/presentation/userScreen/bookedpackage/bookedpackagedetials/bookingPackageDetials.dart';

class custom_history extends StatelessWidget {
  const custom_history({
    super.key,
    required this.booked,
  });

  final BookedModel booked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.grey[700],
        elevation: .4,
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
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: 100,
                 
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
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${DateFormat('dMMMyyy').format(DateTime.parse(booked.Trevelling_date! ))}",
                      style: GoogleFonts.aBeeZee(fontSize: 16,
                      fontWeight: FontWeight.w700
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: Text(
                        "${booked.packageName}",
                        style: GoogleFonts.aBeeZee(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      maxRadius: 6,
                      backgroundColor: booked.status=='pending'? Colors.orange :booked.status=='Success'? Colors.green : Colors.blue ,
                    ),
                    SizedBox(width: 10,),
                    Text(
                      '${booked.status}',
                      style: GoogleFonts.aBeeZee(fontSize: 14,
                      color: booked.status=='pending'? Colors.orange :booked.status=='Success'? Colors.green : Colors.blue
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
  }
}