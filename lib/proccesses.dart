import 'package:flutter/material.dart';

class Processes extends StatelessWidget {
  String process;
  Processes(this.process);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Processes Information",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 26),),  backgroundColor: Colors.indigo,),
      body:
          ListView(
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [SizedBox(height: 20,),
              Container(
              padding: EdgeInsets.all(10),
              child:   Text("Processes: ${process} ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold
                  )),
            ),
        ],
      ),
    );
  }
}
