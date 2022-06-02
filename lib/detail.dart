import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api.dart';
import 'main.dart';

class DetailPage extends StatefulWidget {
  final String? id;
  const DetailPage({Key? key, this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  User? user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Contact"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 80,),
              child: Container(
                width: 80,
                height: 80,
                decoration: const ShapeDecoration(
                  shape: StadiumBorder(),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.orange, Colors.yellow, Colors.deepOrange],
                  ),
                ),
                child: MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const StadiumBorder(),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 40,
                  ),
                  onPressed: () {
                    print('Hello!');
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
         " ${user?.mobile ?? ''}",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(30)),
                child: Icon(
                  Icons.phone,
                  size: 30,
                ),
              ),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(30)),
                child:  Icon(
                  Icons.message,
                  size: 30,
                ),
              ),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(30)),
                child: Icon(
                  Icons.video_call,
                  size: 30,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 20),
                child: Icon(Icons.phone,size: 30,),
              ),
              Text("${user?.mobile}",style: TextStyle(fontSize: 18),),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,bottom: 20),
            child: Text("Message : ${user?.mobile ?? ''}",style: TextStyle(fontSize: 18),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,bottom: 20),
            child: Text("Voice Call : ${user?.mobile ?? ''}",style: TextStyle(fontSize: 18),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,bottom: 10),
            child: Text("Video Call : ${user?.mobile ?? ''}",style: TextStyle(fontSize: 18),),
          ),
        ],
      ),
      // body: Column(children: [
      //   Padding(
      //     padding: const EdgeInsets.only(top: 40,left: 50),
      //     child: Text("${user?.name}"),
      //   ),
      //   Text("${user?.mobile}"),
      //
      //  ]),
    );
  }

  void getUser() async {
    http.Response res =
        await http.get(Uri.parse('$baseUrl/users/${widget.id}'));

    print(widget.id);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      setState(() {
        user = User(
          name: decoded['name'],
          mobile: decoded['mobile'],
          createdAt: decoded['createdAt'],
        );
      });
    }
  }
}
