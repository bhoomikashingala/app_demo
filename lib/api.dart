import 'dart:convert';

import 'package:api_demo/detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'add_update_screen.dart';
import 'main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> users = [];
  User? user;
  bool _isLoading = false;
  bool _isDeleting=false;
  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
        titleSpacing: 30,
        actions: [
          IconButton(onPressed: () => showAlert(), icon: Icon(Icons.add)),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator.adaptive())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) => ListTile(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DetailPage(id: users[index].id)));
                },
                    onLongPress: () {
                      showUpdateAlert(
                        name: users[index].name,
                        mobile: users[index].mobile,
                        id: users[index].id,
                      );
                    },
                    leading: Icon(Icons.person,size: 30,),
                    title: Text("${users[index].name}"),
                trailing: IconButton(
                    onPressed: _isDeleting
                        ? null
                        : () {
                      deleteEntry(users[index].id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: _isDeleting ? Colors.grey : Colors.red,
                    )),
                  )),
    );
  }

  //get data api
  void getUsers() async {
    setState(() => _isLoading = true);
    users.clear();
    http.Response res = await http.get(Uri.parse('$baseUrl/users/'));

    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      decoded.forEach((v) {
        setState(() {
          users.add(User(
              id: v['id'],
              name: v['name'],
              createdAt: v['createdAt'],
              mobile: v['mobile']));
        });
      });
      setState(() => _isLoading = false);
    }
  }

  showAlert() async {
    var res = await showDialog(
        context: context, builder: (context) => AddUpdateScreen());
    if (res != null && res == true) {
      getUsers();
    }
  }

  //upadte data api
  showUpdateAlert({name, mobile, id}) async {
    var res = await showDialog(
        context: context,
        builder: (context) => AddUpdateScreen(
              name: name,
              mobile: mobile,
              id: id,
            ));
    if (res != null && res == true) {
      getUsers();
    }
  }

  //delete data api
  void deleteEntry(String? id) async {
    setState(() => _isDeleting = true);
    http.Response res = await http.delete(Uri.parse('$baseUrl/users/$id'));

    if (res.statusCode == 200) {
      // getUsers();
      var tempList = users.where((user) =>  user.id != id).toList();
      setState(() {
        users = tempList;
      });
      setState(() => _isDeleting = false);
    }
  }
}

class User {
  final String? id;
  final String? name;
  final String? createdAt;
  final String? mobile;

  User({this.id, this.name, this.createdAt, this.mobile});
}
