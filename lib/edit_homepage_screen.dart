import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePageEditData extends StatefulWidget {
  final String name;
  final String email;
  final String age;
  final String gender;
  final String userId;
  const HomePageEditData({super.key, required this.name, required this.email, required this.age, required this.gender, required this.userId});

  @override
  State<HomePageEditData> createState() => _HomePageEditDataState();
}

class _HomePageEditDataState extends State<HomePageEditData> {
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref("edugaon").child("users");
  final _formKey = GlobalKey<FormState>();
  TextEditingController upNameController = TextEditingController();
  TextEditingController upEmailController = TextEditingController();
  TextEditingController upAgeController = TextEditingController();
  TextEditingController upGenderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    upNameController = TextEditingController(text: widget.name);
    upEmailController = TextEditingController(text: widget.email);
    upAgeController = TextEditingController(text: widget.age);
    upGenderController = TextEditingController(text: widget.gender);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("RealTime Database")),),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextField(
              controller: upNameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: upEmailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: upAgeController,
              decoration: InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: upGenderController,
              decoration: InputDecoration(labelText: "Gender"),
            ),

            SizedBox(height: 20,),
            ElevatedButton(onPressed: () {
              updateUser();

            }, child: Text("Edit Data")),



          ],
        ),
      ),
    );
  }

  Future<void> updateUser() async {
    var id = widget.userId;
    print(" user id is $id");
    try{await databaseRef.child(id).update({
      'name': upNameController.text,
      'email': upEmailController.text,
      'age': upAgeController.text,
      'gender': upGenderController.text,
    }).then((value){
      var a = value;
      setState(() {});});
    Navigator.pop(context);}
    on FirebaseException
        catch(r){
      print("Error : ${r.message}");
      Fluttertoast.showToast(msg: "${r.message}");
        }
  }



}
