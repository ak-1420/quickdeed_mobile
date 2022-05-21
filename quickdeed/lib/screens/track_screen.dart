import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({Key? key}) : super(key: key);

  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {

  final workStatusController = TextEditingController();
  var _razorpay = Razorpay();

  var options = {
    'key': 'rzp_test_7oiIEflD1lI1Ag',
    'amount': 500 * 100, // in paisa
    'name': 'Quick Deed',
    'timeout':300, // in seconds
    'description': 'paying for work completion',
    'prefill': {
      'contact': '7660941707',
      'email': 'test@razorpay.com'
    }
  };

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print('Payment Done!');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('Payment Fail');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    print('external wallet');
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black87,
        title: Text("Track the work",
          style: GoogleFonts.pacifico(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(255 , 255 , 255 , 1)
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // show the progress
                SizedBox(height: 20.h,),
                CircularPercentIndicator(
                  radius: 90.r,
                  animation: true,
                  animationDuration: 5000,
                  lineWidth: 10.0,
                  percent: 1.0,
                  circularStrokeCap: CircularStrokeCap.butt,
                  backgroundColor: Colors.white,
                  progressColor: Colors.green,
                  center: Text("100%" , style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.w600
                  ),),
                ),
                SizedBox(height: 40.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: SizedBox(
                        width: 145.w,
                        height: 44.h,
                        child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(19, 18, 18, 1)),
                              foregroundColor: MaterialStateProperty.all(Colors.white),

                            ),
                            onPressed: () {
                              // TODO: show a toast of success
                              // ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                              //   content: Text("pay amount through online"),
                              // ));
                              
                              // open razorpay payment
                              _razorpay.open(options);
                            },
                            child: Text("pay online",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20.sp,
                              ),)
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: SizedBox(
                        width: 145.w,
                        height: 44.h,
                        child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(19, 18, 18, 1)),
                              foregroundColor: MaterialStateProperty.all(Colors.white),

                            ),
                            onPressed: () {
                              // // TODO: show a toast of success
                              // ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                              //   content: Text("connecting ..."),
                              // ));
                              // video call
                              Navigator.pushNamed(context, '/video');
                            },
                            child: Text("video call",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20.sp,
                              ),)
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h,),
                SizedBox(
                  width: 320.w,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: workStatusController,
                    maxLines: null,
                    onChanged: (workStatus) {
                      print(workStatus);
                    },
                    style:TextStyle(
                      fontSize: 16.sp,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
                              color: Colors.black87,
                              width: 2.0,
                              style: BorderStyle.solid
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
                              color: Colors.black87,
                              width: 2.0,
                              style: BorderStyle.solid
                          )
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "update the work status",
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                      hintStyle: GoogleFonts.rubik(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color:const Color.fromRGBO(0, 0, 0, 1)
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: SizedBox(
                    width: 145.w,
                    height: 44.h,
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(19, 18, 18, 1)),
                          foregroundColor: MaterialStateProperty.all(Colors.white),

                        ),
                        onPressed: () {
                          // TODO: show a toast of success
                          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                            content: Text("work status updated successfully!"),
                          ));
                        },
                        child: Text("submit",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 20.sp,
                          ),)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
   _razorpay.clear();
    super.dispose();
  }
}
