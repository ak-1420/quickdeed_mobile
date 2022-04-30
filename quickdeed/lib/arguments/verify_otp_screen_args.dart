

// this class is to define arguments
// thar are passed to verify_otp_screen

class VerifyOtpArguments {
  final String verificationId;
  final String phoneNumber;

  VerifyOtpArguments({required this.phoneNumber , required this.verificationId});

}