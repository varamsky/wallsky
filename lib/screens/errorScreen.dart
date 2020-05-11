import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:wallsky/screens/homeScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ErrorScreen extends StatefulWidget {

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  var networkSubscription;

  @override
  void initState() {
    super.initState();

    networkSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print("Connection Status has Changed\n\n$result");
      if ((result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi)) {

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()));

        Fluttertoast.showToast(
          msg: 'INTERNET IS BACK',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Error Screen');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Wallsky',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Carrington',
              fontSize: 42.0,
            ),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Container(
                child: Image.asset('assets/no_internet_connection.jpeg',fit: BoxFit.fill,),
              ),
            ),
            Text('\n\nOOPS, NO INTERNET CONNECTION!!\n\nPlease connect to the Internet.',style: TextStyle(fontSize: 18.0),),
          ],
        ),
      ),
    );
  }
}
