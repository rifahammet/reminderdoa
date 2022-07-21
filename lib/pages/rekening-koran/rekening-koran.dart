
import 'package:flutter/material.dart';
import 'package:doa/pages/rekening-koran/rekening-koran-bank.dart';
import 'package:doa/pages/rekening-koran/rekening-koran-barang.dart';
import 'package:doa/pages/rekening-koran/rekening-koran-nasabah.dart';



class RekeningKoranPage extends StatefulWidget {
  const RekeningKoranPage({Key? key}): super(key: key);
  _RekeningKoranPageState createState()=> _RekeningKoranPageState();
}
class _RekeningKoranPageState extends State<RekeningKoranPage>with SingleTickerProviderStateMixin{
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
         elevation: 0,
         title: Text("Rekening Koran",textAlign: TextAlign.center,style: TextStyle(fontSize: 18),),
          
          bottom: TabBar(
            indicatorColor: Colors.transparent,
            controller: controller,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.yellow,
            tabs: <Widget>[
               const Tab(icon:  Icon(Icons.person, )),
              const   Tab(icon:  Icon(Icons.house)),
              const   Tab(icon:  Icon(Icons.ballot_outlined)),
            ],

          )
         ),
         body:  TabBarView(
           controller: controller,
           children: <Widget>[
             const RekeningKoranNasabahPage(),
            const RekeningKoranBankPage(),
            const RekeningKoranBarangPage()
           ],
         ),
         bottomNavigationBar:  Material(
            color: Colors.yellow,
         
         ),
         

    );
  }

}