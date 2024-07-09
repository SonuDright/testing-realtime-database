import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePageAddData extends StatefulWidget {
  const HomePageAddData({super.key});

  @override
  State<HomePageAddData> createState() => _HomePageAddDataState();
}

class _HomePageAddDataState extends State<HomePageAddData> {
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref("edugaon").child("users");

  TextEditingController addNameController = TextEditingController();
  TextEditingController addEmailController = TextEditingController();
  TextEditingController addAgeController = TextEditingController();
  TextEditingController addGenderController = TextEditingController();

 Future<void> addUserData(String name,String email,String gender,String age)async{

 try{
  var id =  databaseRef.push().key;
   await databaseRef.child(id.toString()).set({
     "userId":id,
     "name":name,
     "email":email,
     "gender":gender,
     "age":age,
   });
 }catch(error){
  throw Exception(error);
 }

 }

 getData()async{
   // var data = await databaseRef.once().catchError((error){
   //   print("Error:${error.toString()}");
   // });
   // print("data:${data.snapshot.value}");


///id ke dwara Data get ////
   var data = await databaseRef.child('-O0EPCQQjIe8qc4aiVIi').once().catchError((error){
     print("Error:${error.toString()}");
   });

   print("data:${data.snapshot.value}");
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
              controller: addNameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: addEmailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: addAgeController,
              decoration: InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: addGenderController,
              decoration: InputDecoration(labelText: "Gender"),
            ),

            SizedBox(height: 20,),
            ElevatedButton(onPressed: () {

               addUserData(addNameController.text, addEmailController.text, addGenderController.text, addAgeController.text);
              setState(() {});
            }, child: Text("AddData")),



          ],
        ),
      ),
    );
  }
}
