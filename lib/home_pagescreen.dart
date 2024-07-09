// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:testing_realtime_database_flutter/user_model.dart';
//
// import 'add_homepage.dart';
// import 'edit_homepage_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   var databaseRef = FirebaseDatabase.instance.ref("edugaon/users");
//
//   Future<List<Map<String, dynamic>>> getData() async {
//     var snapshot = await databaseRef.get();
//     if (snapshot.exists) {
//       return snapshot.children
//           .map((child) => Map<String, dynamic>.from(child.value as Map)).toList();
//     } else {
//       return [];
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Center(child: Text("User List"))),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         backgroundColor: Colors.greenAccent,
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => HomePageAddData(),
//             ),
//           );
//         },
//       ),
//       body: SafeArea(
//         child: StreamBuilder(
//           stream: databaseRef.onValue,
//           builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
//             if (!snapshot.hasData) {
//               return Center(child: CircularProgressIndicator());
//             } else {
//               Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map;
//               var keysList = data.keys.toList();
//               var modelList = <UserModal>[];
//
//               for (int a = 0; a < keysList.length; a++) {
//                 var key = keysList[a];
//
//                 modelList.add(UserModal(
//
//                     name: data[key]["name"].toString(),
//                     email: data[key]["email"].toString(),
//                     age: data[key]["age"].toString(),
//                     gender: data[key]["gender"].toString(),
//                     userId: data[key]["userId"].toString()));
//               }
//
//               print(modelList);
//               return ListView.builder(
//                   itemCount: modelList.length,
//                   itemBuilder: (context, index) {
//                     var dataModel = modelList[index];
//
//                     return Padding(
//                       padding: EdgeInsets.all(10.0),
//                       child: Container(
//                         height: 100,
//                         width: 300,
//                         decoration: BoxDecoration(
//                           border: Border.all(width: 2, color: Colors.red),
//                           color: Colors.lightGreenAccent,
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         child: ListView(
//                           children: [
//                             Center(
//                               child: Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceEvenly,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       Text(dataModel.userId.toString()),
//                                       Text(dataModel.name.toString()),
//                                       Text(dataModel.email.toString()),
//                                       Text(dataModel.age.toString()),
//                                       Text(dataModel.gender.toString()),
//
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       IconButton(
//                                           onPressed: () {
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       HomePageEditData(
//                                                         name: dataModel.name.toString(),
//                                                         email: dataModel.email.toString(),
//                                                         age:dataModel.age.toString(),
//                                                         gender: dataModel.gender.toString(),
//                                                         userId: dataModel.userId.toString()
//                                                       ),
//                                                 ));
//                                           },
//                                           icon: Icon(
//                                             Icons.edit,
//                                             color: Colors.green,
//                                           )),
//                                       IconButton(
//                                           onPressed: () {
//                                             deletUserData(dataModel.userId);
//                                             setState(() {});
//                                           },
//                                           icon: Icon(
//                                             Icons.delete,
//                                             color: Colors.red,
//                                           )),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   });
//             }
//           },
//         ),
//       ),
//     );
//   }
//   Future<void> deletUserData(String userId)async{
//     try{
//       await databaseRef.child("userId").remove();
//       Fluttertoast.showToast(msg: "delete Successfull");
//
//     }
//     catch(s){
//       Fluttertoast.showToast(msg: "error");
//
//
//     }
//
//   }
// }


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testing_realtime_database_flutter/user_model.dart';

import 'add_homepage.dart';
import 'edit_homepage_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var databaseRef = FirebaseDatabase.instance.ref("edugaon/users");

  Future<List<Map<String, dynamic>>> getData() async {
    var snapshot = await databaseRef.get();
    if (snapshot.exists) {
      return snapshot.children
          .map((child) => Map<String, dynamic>.from(child.value as Map))
          .toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("User List"))),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePageAddData(),
            ),
          ).then((value) {
            setState(() {});
          });
        },
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: databaseRef.onValue,
          builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            else {


              if (snapshot.data!.snapshot.value == null) {
                return Center(child: Text("No Data Available"));

              }

              Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map;

              var keysList = data.keys.toList();
              var modelList = <UserModal>[];

              for (int a = 0; a < keysList.length; a++) {
                var key = keysList[a];
                modelList.add(UserModal(
                  userId: data[key]["userId"].toString(),
                  name: data[key]["name"].toString(),
                  email: data[key]["email"].toString(),
                  age: data[key]["age"].toString(),
                  gender: data[key]["gender"].toString(),
                ));
              }

              return ListView.builder(
                itemCount: modelList.length,
                itemBuilder: (context, index) {
                  var dataModel = modelList[index];

                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      height: 140,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.red),
                        color: Colors.lightGreenAccent,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ListView(
                        children: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(dataModel.userId),
                                    Text(dataModel.name),
                                    Text(dataModel.email),
                                    Text(dataModel.age),
                                    Text(dataModel.gender),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomePageEditData(
                                              userId: dataModel.userId,
                                              name: dataModel.name,
                                              email: dataModel.email,
                                              age: dataModel.age,
                                              gender: dataModel.gender,
                                            ),
                                          ),
                                        ).then((value) {
                                          setState(() {});
                                        });
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        deleteUser(dataModel.userId);
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> deleteUser(String userId) async {
    try {
      await databaseRef.child(userId).remove();
      Fluttertoast.showToast(msg: "Delete Successful");
    } catch (e) {
      Fluttertoast.showToast(msg: "error");


    }
    }
}
