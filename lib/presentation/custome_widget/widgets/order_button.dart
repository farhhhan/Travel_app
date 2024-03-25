import 'package:flutter/material.dart';
import 'package:travel_app/domain/packageModel/packageModel.dart';
import 'package:travel_app/presentation/userScreen/booking/Bookingone.dart';

// ignore: must_be_immutable
class OrderButton extends StatelessWidget {
   OrderButton({
    super.key,
    required this.packageModel
  });
  PackageModel packageModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            )),
        onPressed: () {
            if (packageModel.packageType == 'Primium') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingShowOneScreen(
                                isInternational: true,
                                packageModel: packageModel),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingShowOneScreen(
                              isInternational: false,
                              packageModel: packageModel,
                            ),
                          ));
                    }
        },
        child: const Text(
          'Book Now',
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
