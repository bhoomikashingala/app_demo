import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api.dart';
import 'detail.dart';

void main() {
  runApp(MyApp());
}

String baseUrl = 'https://628f15b70e69410599d4f4cb.mockapi.io';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   List<User> users = [];
//   User? user;
//   String? id;
//   bool _isLoading = false;
//   String name = '';
//   String imgUrl = '';
//   String mobile='';
//   bool _isDeleting = false;
//
//   @override
//   void initState() {
//     getUsers();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//
//
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: ()=>showAlert(),child:Icon(Icons.add),
//         ),
//         body: _isLoading
//             ? const Center(child: CircularProgressIndicator.adaptive())
//             : ListView.builder(
//                 itemCount: users.length,
//                 itemBuilder: (context, index) => ListTile(
//                   // onLongPress: () {
//                   //   showUpdateAlert(
//                   //     name: users[index].name,
//                   //     url: users[index].url,
//                   //     id: users[index].id,
//                   //   );
//                   // },
//                       onTap: () {
//                         //inavigate with id
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (BuildContext context) =>
//                                     DetailPage(id: users[index].id)));
//                       },
//                   trailing: IconButton(
//                       onPressed: _isDeleting
//                           ? null
//                           : () {
//                         deleteEntry(users[index].id);
//                       },
//                       icon: Icon(
//                         Icons.delete,
//                         color: _isDeleting ? Colors.grey : Colors.red,
//                       )),
//                       leading:Icon(Icons.person),
//                       title: Text('${users[index].name}'),
//                       // subtitle: Text('${users[index].createdAt}'),
//                     )));
//   }
//   void getUsers() async {
//     setState(() => _isLoading = true);
//     http.Response res = await http.get(Uri.parse('$baseUrl/users/'));
//
//     if (res.statusCode == 200) {
//       var decoded = jsonDecode(res.body);
//       decoded.forEach((v) {
//         setState(() {
//           users.add(User(
//             id: v['id'],
//             name: v['name'],
//             createdAt: v['createdAt'],
//           ));
//         });
//       });
//       setState(() => _isLoading = false);
//     }
//   }
//
//   showAlert() async {
//     var res = await showDialog(
//         context: context, builder: (context) => const AddUpdateScreen());
//     if (res != null && res == true) {
//       getUsers();
//     }
//   }
//
//   showUpdateAlert({name, url, id}) async {
//     var res = await showDialog(
//         context: context,
//         builder: (context) => AddUpdateScreen(
//           name: name,
//           url: url,
//           id: id,
//         ));
//     if (res != null && res == true) {
//       getUsers();
//     }
//   }
//
//
//   void deleteEntry(String? id) async {
//     setState(() => _isDeleting = true);
//     http.Response res = await http.delete(Uri.parse('$baseUrl/users/$id'));
//
//     if (res.statusCode == 200) {
//       getUsers();
//       setState(() => _isDeleting = false);
//     }
//   }
// }
//
// class AddUpdateScreen extends StatefulWidget {
//   const AddUpdateScreen({Key? key, name, url, id}) : super(key: key);
//
//   get id => null;
//
//   @override
//   State<AddUpdateScreen> createState() => _AddUpdateScreenState();
// }
//
// class _AddUpdateScreenState extends State<AddUpdateScreen> {
//   String? name = '';
//   String? mobile = '';
//   bool _isLoading = false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextFormField(
//             decoration: const InputDecoration(hintText: 'Name'),
//             onChanged: (n) => name = n,
//           ),
//           TextFormField(
//             decoration: const InputDecoration(hintText: 'Url'),
//             keyboardType: TextInputType.number,
//             onChanged: (u) => mobile = u,
//           ),
//           TextButton(
//               onPressed: _isLoading
//                   ? null
//                   : () {
//                 addUser();
//               },
//               child: const Text("Submit"))
//         ],
//       ),
//     );
//   }
//
//   void addUser() async {
//     if (name!.isNotEmpty && mobile!.isNotEmpty) {
//       setState(() => _isLoading = true);
//       http.Response res = await http.post(
//         Uri.parse('$baseUrl/users'),
//         body: {
//           "name": "$name",
//           "mobile": "$mobile",
//         },
//       );
//
//       if (res.statusCode == 201) {
//         var decoded = jsonDecode(res.body);
//         Navigator.pop(context, true);
//
//         // https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/559.jpg
//         setState(() => _isLoading = false);
//       }
//     }
//   }
//   void updateUser() async {
//     if (name!.isNotEmpty && mobile!.isNotEmpty) {
//       setState(() => _isLoading = true);
//       http.Response res = await http.put(
//         Uri.parse('$baseUrl/users/${widget.id}'),
//         body: {
//           "name": "$name",
//           "avatar": "$mobile",
//         },
//       );
//       print(res.statusCode);
//       if (res.statusCode == 200) {
//         Navigator.pop(context, true);
//         // https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/559.jpg
//         setState(() => _isLoading = false);
//       }
//     }
//   }
// }
// class User {
//   final String? id;
//   final String? name;
//   final String? url;
//   final String? createdAt;
//   final String? mobile;
//
//   User({this.id, this.name, this.url, this.createdAt,this.mobile});
// }
