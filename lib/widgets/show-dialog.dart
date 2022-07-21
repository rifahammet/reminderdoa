import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doa/widgets/button.dart';

class ShowDialog{
  dynamic showDialogs({data="",contek,onPressed,isiwidget,judul,labelButton="Submit",headerColor=Colors.green,headerTextColor=Colors.white,isExpanded=false}){
    
     showDialog(
       barrierDismissible:false,
        context: contek,
        builder: (BuildContext context) {
          GlobalKey<FormState>? _key;
          return 
          
          AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return 
            
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Form(
                  //key: _key,
                  child:
                Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color:headerColor,
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.withOpacity(0.3))
                          )
                        ),
                        child: Center(child: Text(judul, style:TextStyle(color: headerTextColor, fontWeight: FontWeight.w700, fontSize: 20, fontStyle: FontStyle.italic, fontFamily: "Helvetica"))),
                      ),
                      
                      Container(
                        height: 3,
                        color: Colors.orange[700],
                        width: MediaQuery.of(context).size.width),
                        isExpanded ?Expanded(
                          child: 
                      
            SingleChildScrollView(child: 
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: isiwidget(data,setState)

                      ),),
                       ):Padding(
                        padding: EdgeInsets.all(10.0),
                        child: isiwidget(data,setState)
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Button().RaisedButon(data: data==""? judul:data, callBack: onPressed, label: labelButton)),
                    ],
                  ),
                ),
                 Positioned(
                  right: 15.0,
                  top: 17.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      radius: 12,
                      child: Icon(Icons.close, size: 24,),
                      backgroundColor: Colors.yellow,
                    ),
                  ),
                ),
              ],
            );
        })
          );
         
        });
        
  }

}