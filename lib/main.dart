import 'dart:async';
import 'package:eventlogger/packages.dart';
import 'package:eventlogger/proccesses.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/foundation.dart';
import 'ctxt.dart';
import 'network.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Mouse Tracker Demo',
      home: MyMouseTracker(),
    );
  }
}

class MyMouseTracker extends StatefulWidget {


  @override
  _MyMouseTrackerState createState() => _MyMouseTrackerState();
}

class _MyMouseTrackerState extends State<MyMouseTracker> {
  double x = 0.0;
  double y = 0.0;
  List<String> keys = [];
  var _battery = Battery();
  int _batteryLevel

  = 0;
  BatteryState? _batteryState;
  StreamSubscription<BatteryState>? _batteryStateSubscription;

  getBatteryLevel() async {
    final level = await _battery.batteryLevel;
    setState(() {
      _batteryLevel = level;
    });
  }

  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }

  void getBatteryState() {
    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen((BatteryState state) {
          setState(() {
            _batteryState = state;
          });
        });
  }
String data="";
String who="";
  String network="";
  String ctxt="";
  fetch()async{
    String response;
    response=await rootBundle.loadString("assets/events.txt");
    setState(() {
      data=response;
    });
  }
  fetchWho()async{
    String response;
    response=await rootBundle.loadString("assets/who.txt");
    setState(() {
      who=response;
    });
  }
  fetchNet()async{
    String response;
    response=await rootBundle.loadString("assets/network.txt");
    setState(() {
      network=response;
    });
  }

  fetchCtxt()async{
    String response;
    response=await rootBundle.loadString("assets/ctxt.txt");
    setState(() {
      ctxt=response;
    });
  }
  String package="";
  fetchPackages()async{
    String response;
    response=await rootBundle.loadString("assets/packages.txt");
    setState(() {
      package=response;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPackages();
    fetchCtxt();
    fetchNet();
    fetchWho();
    fetch();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      getBatteryLevel();
    });
    getBatteryState();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerHover: _updateLocation, // not pressed
      onPointerMove: _updateLocation, // pressed
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) {
          final key = event.logicalKey;
          if (event is RawKeyDownEvent) {
            if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
              print("enter pressed");
            }
            setState(() {
              keys.add(key.keyLabel);
            });
          }
        },
        child: Scaffold(
         appBar: AppBar(
           backgroundColor: Colors.indigo,
           title: Center(child: Text("EVENT LOGGER",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 26),)),
         ),
          body: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            children:[
              Text("Clock: ${DateTime.now().toString()}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.indigo),),
              SizedBox(height: 20,),
              Text("Current logged in user: ${who}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.indigo),),
              Text("Battery level: $_batteryLevel %",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.indigo),),
              SizedBox(height: 20,),
              Text("Battery state: $_batteryState",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.indigo),),
              SizedBox(height: 20,),
              Text("Mouse coordinates: ${x.toStringAsFixed(2)},${y.toStringAsFixed(2)}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.indigo),),
              SizedBox(height: 20,),
              Text("Keyboard strokes: ${keys.take(20).toString()}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.indigo),),
              SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
               children: [
               Column(
                 children: [
                   Container(
                     padding: EdgeInsets.all(12.0),
                     margin: EdgeInsets.all(10.0),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(12.0),
                         color: Colors.indigo),
                     constraints: BoxConstraints(maxHeight: 300.0,minHeight: 200,maxWidth: 300,minWidth: 200),
                     child: IconButton(icon: Icon(Icons.file_copy,size: 75,color: Colors.white,),onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Ctxt(ctxt)));
                     },),),
                   Text("Context switches",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.indigo),),
                 ],
               ),
               SizedBox(width: 20,),
                 Column(
                   children: [
                     Container(
                       padding: EdgeInsets.all(12.0),
                       margin: EdgeInsets.all(10.0),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(12.0),
                           color: Colors.indigo),
                       constraints: BoxConstraints(maxHeight: 300.0,minHeight: 200,maxWidth: 300,minWidth: 200),
                       child: IconButton(icon: Icon(Icons.pageview,size: 75,color: Colors.white,),onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Packages(package)));
                       },),),
                     Text("Packages",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.indigo),),
                   ],
                 ),
                 SizedBox(width: 20,),
               Column(
                 children: [
                   Container(
                     padding: EdgeInsets.all(12.0),
                     margin: EdgeInsets.all(10.0),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(12.0),
                         color: Colors.indigo),
                     constraints: BoxConstraints(maxHeight: 300.0,minHeight: 200,maxWidth: 300,minWidth: 200),
                     child: IconButton(icon: Icon(Icons.contact_page,size: 75,color: Colors.white,),onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Processes(data)));
                     },),),
                   Text("Processes",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.indigo),),
                 ],
               ), SizedBox(width: 20,),
               Column(
                 children: [
                   Container(
                     padding: EdgeInsets.all(12.0),
                     margin: EdgeInsets.all(10.0),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(12.0),
                         color: Colors.indigo),
                     constraints: BoxConstraints(maxHeight: 300.0,minHeight: 200,maxWidth: 300,minWidth: 200),
                     child: IconButton(icon: Icon(Icons.network_check,size: 75,color: Colors.white,),onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Network(network)));
                     },),),
                   Text("Network",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.indigo),),
                 ],
               )
             ],),
            ],
          ),
        ),
      ),
    );
  }

}
