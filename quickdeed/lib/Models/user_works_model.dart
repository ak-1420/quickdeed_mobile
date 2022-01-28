class UserWorksModel {
  String workName = "";
  String userName = "";
  String workStatus = "";
  String workType = "";
  double amount = 0.0;
  bool isPosted = false; // this it to define wheather this work is posted by userName or not

  UserWorksModel({
    this.userName = "",
    this.workName = "",
    this.workStatus = "",
    this.workType = "",
    this.amount = 0.0,
    this.isPosted = false
 });

}