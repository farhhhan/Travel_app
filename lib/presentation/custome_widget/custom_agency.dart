import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:travel_app/domain/userModel/userModel.dart';
import 'package:travel_app/presentation/userScreen/agencyshow/agencyPackages.dart';

class CustomAgency extends StatelessWidget {
  CustomAgency({Key? key, required this.agencyData}) : super(key: key);

  final List<UserModel> agencyData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AgencyIndvScreen(
              agencyModel: agencyData[0],
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(20),
            ),
            height: 100,
            child: ListView.builder(
              itemCount: agencyData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 30),
                        CircleAvatar(
                          maxRadius: 30,
                         child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  20), 
                              child: CachedNetworkImage(
                                imageUrl: agencyData[index].profile,
                                fit: BoxFit.fill,
                                placeholder: (context, url) =>
                                    SkeletonAnimation(
                                        child: Container(color: Colors.grey)),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150, 
                              child: Text(
                                '${agencyData[index].name}',
                                style: GoogleFonts.aboreto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                '${agencyData[index].email}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
