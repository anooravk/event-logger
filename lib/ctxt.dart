import 'package:flutter/material.dart';

class Ctxt extends StatelessWidget {
  String ctxt;
Ctxt(this.ctxt);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

     appBar: AppBar(title: Text("Context Switches",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 26),),  backgroundColor: Colors.indigo,),
      body:
          ListView(
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              SizedBox(height: 20,),
              Container(
              padding: EdgeInsets.all(10),
              child:   Text("context switches: ${ctxt} ",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold
                  )),
            ),
        ],
      ),
    );
  }
}
