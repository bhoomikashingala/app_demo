import 'package:api_demo/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUpdateScreen extends StatefulWidget {
  final String? id;
  final String? name;
  final String? mobile;

  const AddUpdateScreen({Key? key, this.id, this.name, this.mobile})
      : super(key: key);

  @override
  _AddUpdateScreenState createState() => _AddUpdateScreenState();
}

class _AddUpdateScreenState extends State<AddUpdateScreen> {
  String? name = '';
  String? mobile = '';
  bool _isLoading=false;
  @override
  void initState() {
    if (widget.name != null && widget.mobile != null) {
      setState(() {
        name = widget.name;
        mobile = widget.mobile;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80, left: 100, right: 100),
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
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
              child: TextFormField(
                onChanged: (n)=>name =n,
                initialValue: name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  filled: true,
                  hintText: 'User Name',

                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10,left: 20,right: 20,bottom: 10),
              child: TextFormField(
                onChanged: (m)=>mobile=m,
                initialValue: mobile,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  filled: true,
                  hintText: 'Phone Number',

                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancel",style: TextStyle(fontSize: 18,color: Colors.black),)),

                TextButton(onPressed: _isLoading
                    ? null
                    :(){
                  if(widget.name!=null && widget.mobile!=null){
                    updateUser();
                  }else{
                    addUser();
                  }

                }, child: Text("Save",style: TextStyle(fontSize: 18,color: Colors.black),))
              ],
            )
          ],
        ),
      ),
    );
  }


  void addUser() async{
    if(name!.isNotEmpty&&mobile!.isNotEmpty){
      setState(()=> _isLoading=true);
      http.Response res=await http.post(Uri.parse('$baseUrl/users'),
      body: {
        "name":"$name",
        "mobile":"$mobile",
      },
      );
      if(res.statusCode==201){
        Navigator.pop(context,true);
        setState(()=> _isLoading=false);
      }
    }
  }

  void updateUser() async{
    if(name!.isNotEmpty&&mobile!.isNotEmpty){
      setState(()=> _isLoading=true);
      http.Response res= await http.put(Uri.parse('$baseUrl/users/${widget.id}'),
      body: {
        "name": "$name",
        "mobile": "$mobile",
      },
      );
      if(res.statusCode==200){
        Navigator.pop(context,true);
        setState(()=>_isLoading=false);
      }
    }
  }
}
