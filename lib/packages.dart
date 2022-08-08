import 'package:flutter/material.dart';

class Packages extends StatelessWidget {
  String packages;
  Packages(this.packages);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Packages Information",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 26),),  backgroundColor: Colors.indigo,),
      body:
      ListView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(10),
            child:   Text("Packages: ${packages} ",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold
                )),
          ),
        ],
      ),
    );
  }
}
