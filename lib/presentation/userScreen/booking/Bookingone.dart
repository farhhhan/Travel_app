import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:travel_app/application/bloc/todo_bloc/todo_bloc.dart';
import 'package:travel_app/domain/data/todo.dart';
import 'package:travel_app/domain/packageModel/packageModel.dart';
import 'package:travel_app/presentation/commentScreens/bottom_navigator.dart';
import 'package:travel_app/presentation/userScreen/booking/theme/styles.dart';
import 'package:travel_app/presentation/userScreen/booking/travellers/addPersonDetials.dart';
import 'package:travel_app/presentation/userScreen/booking/widget/custom_builder.dart';
import 'package:travel_app/presentation/userScreen/booking/widget/custome_datePicker.dart';
import 'package:travel_app/presentation/userScreen/intsplash/sendingInterNational.dart';

class BookingShowOneScreen extends StatelessWidget {
  BookingShowOneScreen({
    Key? key,
    required this.packageModel,
    required this.isInternational,
  }) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  bool isInternational;
  PackageModel packageModel;
  String? Country;
  String? States;
  String? city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text('Review Page', style: BookingStyles.appBarTitleStyle),
          subtitle: Text('${packageModel.packageName}',
              style: BookingStyles.appBarSubtitleStyle),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    elevation: 1,
                    child: custome_datePicker(packageModel: packageModel),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trevellers Detials',
                          style: BookingStyles.getTitleTextStyle(
                            Colors.grey[400]
                          ),
                        ),
                        Text(
                          'Travellers detials & Information will be sent to -',
                          style: BookingStyles.getSubtitleTextStyle(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddTaskScreen(
                                  isInternational: isInternational,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      'Traveller',
                                      style: BookingStyles.getTitleTextStyle(Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        custom_builder(),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Contact Information',
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Booking detials & communication will be sent to -',
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                CustomTextField(
                                  controller: emailController,
                                  labelText: 'EMAIL ID',
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a name';
                                    } else if (!RegExp(r'^[a-zA-Z]+$')
                                        .hasMatch(value)) {
                                      return 'Please enter valid name';
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  controller: phoneController,
                                  labelText: 'MOBILE',
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your age';
                                    } else if (int.tryParse(value) == null) {
                                      return 'Please enter a valid age';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  color:Colors.blueAccent ,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  shadowColor: Colors.grey[500],
                                  elevation: 10,
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: CSCPicker(
                                      layout: Layout.vertical,
                                      flagState: CountryFlag.ENABLE,
                                      onCountryChanged: (value) {
                                        Country = value;
                                      },
                                      onStateChanged: (value) {
                                        States = value;
                                      },
                                      onCityChanged: (value) {
                                        city = value;
                                      },
                                      selectedItemStyle: TextStyle(
                                        color: Colors.black
                                      ),
                                      countrySearchPlaceholder: 'Country',
                                      stateSearchPlaceholder: 'State',
                                      citySearchPlaceholder: 'City',
                                      countryDropdownLabel: 'Select Country',
                                      cityDropdownLabel: 'Select City',
                                      stateDropdownLabel: 'Select State',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  controller: gstController,
                                  labelText: 'GST Address',
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your age';
                                    } else if (int.tryParse(value) == null) {
                                      return 'Please enter a valid age';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 120,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 120,
                )
              ],
            ),
          ),
          BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(color: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '₹${totoalAmount(state.todos.length, packageModel.packagePayment!)}',
                            style: BookingStyles.getTotalAmountTextStyle(),
                          ),
                          Text(
                            'Per Person',
                            style:
                                BookingStyles.getTotalAmountSubtitleTextStyle(),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          if (state.datePicker != null &&
                              state.todos.length > 0) {
                            if (isInternational) {
                              print(Country);

                              context.read<TodoBloc>().add(bookedEvent(
                                  payment_status: 'Pending',
                                  status: 'Pending',
                                  payment: totoalAmount(state.todos.length,
                                          packageModel.packagePayment!)
                                      .toString(),
                                  image: packageModel.imageUrlList![0],
                                  gstaddress: gstController.text,
                                  TravellersList: state.todos,
                                  Trevelling_date: state.datePicker.toString(),
                                  agency_uid: packageModel.uid!,
                                  p_uid: packageModel.puid!,
                                  packageName: packageModel.packageName,
                                  traveller_country: Country!,
                                  traveller_email: emailController.text,
                                  traveller_number: phoneController.text,
                                  treveller_city: city!,
                                  treveller_state: States!,
                                  u_uid:
                                      FirebaseAuth.instance.currentUser!.uid));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SplashBooked()));
                            } else {
                              Razorpay razorpay = Razorpay();
                              var options = {
                                'key': 'rzp_test_1DP5mmOlF5G5ag',
                                'amount': totoalAmount(state.todos.length,
                                    packageModel.packagePayment!),
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
                              razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                                  (success) {
                                handlePaymentSuccessResponse(
                                  context: context,
                                  successMessage: '',
                                  todoList: state.todos,
                                  dateTrip: state.datePicker!,
                                );
                              });

                              razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                                  handleExternalWalletSelected);
                              razorpay.open(options);
                            }
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              'Book Now',
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void handlePaymentErrorResponse(BuildContext context, String errorMessage) {
    showAlertDialog(context, "Payment Failed", errorMessage);
  }

  void handlePaymentSuccessResponse(
      {required BuildContext context,
      required String successMessage,
      required List<Todo> todoList,
      required DateTime dateTrip}) {
    print(Country);

    context.read<TodoBloc>().add(bookedEvent(
        payment_status: 'Success',
        status: 'Success',
        payment: totoalAmount(todoList.length, packageModel.packagePayment!)
            .toString(),
        image: packageModel.imageUrlList![0],
        gstaddress: gstController.text,
        TravellersList: todoList,
        Trevelling_date: dateTrip.toString(),
        agency_uid: packageModel.uid!,
        p_uid: packageModel.puid!,
        packageName: packageModel.packageName,
        traveller_country: Country!,
        traveller_email: emailController.text,
        traveller_number: phoneController.text,
        treveller_city: city!,
        treveller_state: States!,
        u_uid: FirebaseAuth.instance.currentUser!.uid));
    showAlertDialog(context, "Payment Successful", successMessage);
    context.read<TodoBloc>().add(afterSaveEvent());
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

  int totoalAmount(int count, String price) {
    int ammount = int.parse(price.toString());
    int totalAmount = ammount * count;
    return totalAmount;
  }
}
