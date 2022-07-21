
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:doa/pages/saldo-awal/saldo-awal-bank.dart';
import 'package:doa/pages/saldo-awal/saldo-awal-barang.dart';
import 'package:doa/pages/saldo-awal/saldo-awal-nasabah.dart';


class SaldoAwalHomePage extends StatefulWidget {
  const SaldoAwalHomePage({Key? key}): super(key: key);
  _SaldoAwalHomePageState createState()=> _SaldoAwalHomePageState();
}
class _SaldoAwalHomePageState extends State<SaldoAwalHomePage>with SingleTickerProviderStateMixin{
  TabController? controller;
 
  @override 
  void initState(){
    controller= TabController(vsync: this,length: 3 );
    super.initState();
   

  }

   @override 
    void dispose(){
      controller!.dispose();
      super.dispose();
  }

@override 
  Widget build (BuildContext context){
    
    return  Scaffold(
     
      appBar:  AppBar(
         backgroundColor: Colors.green[700],
         centerTitle: true,
         title: Text("Saldo Awal",textAlign: TextAlign.center,style: TextStyle(fontSize: 18),),
          bottom: TabBar(
            indicatorColor: Colors.orange,

            controller: controller,
            tabs: <Widget>[
                Tab(icon:  Icon(Icons.person),text: "Nasabah",),
                 Tab(icon:  Icon(Icons.house),text: "Bank",),
                 Tab(icon:  Icon(Icons.ballot_outlined),text: "Barang",),
            ],

          )
         ),
         body:  TabBarView(
           controller: controller,
           children: <Widget>[
             SaldoAwalNasabahPage(),
             SaldoAwalBankPage(),
             SaldoAwalBarangPage()
           ],
         ),
         bottomNavigationBar:  Material(
            color: Colors.yellow,
         
         ),
         

    );
  }

}