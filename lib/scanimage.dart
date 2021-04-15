import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:internship/InsuranceModel.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


class ScanImage extends StatefulWidget {
   ScanImage({this.image});
  File image;
  

  InsuranceModel model;
  @override
  _ScanImageState createState() => _ScanImageState();
}

class _ScanImageState extends State<ScanImage> {

  InsuranceModel model;

  var dio = Dio();

  double percent = 0;

  //for card control
  bool status = true;

  //for processing control
   bool processing = false;

  @override
  void initState() { 
    super.initState();
     
  }

  send() async{

   var url = 'https://intern-zoho.herokuapp.com/testupload';

    try{  
      
      

      String filename = widget.image.path.split('/').last;
      FormData formData = new FormData.fromMap({
        "image": 
        await MultipartFile.fromFile(widget.image.path, filename: filename,
        contentType: new MediaType('image', 'jpg')),
        "type": "image/jpg"
      });


      Response response = await dio.post(url,data: formData,onSendProgress:(int sent, int total) {
        print('${((sent/total)*100).floor()}');
        setState(() {
          percent = sent/total;
       });
       if(percent==1){
         processing= true;
           setState((){});
       }
       
      }, );

      print(response.data);

      setState(() {
        model = InsuranceModel.fromJson(response.data);
            });
        

      


        if(model!=null){
           
          await Future.delayed(Duration(seconds: 2));
          status = true;
          setState(() { });
          print('here');
          print(status);
          processing = false;
         
        }
      percent = 0;

    }catch(e){print(e);}

 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form data'),),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            Center(
            child:  Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(image: DecorationImage(image: FileImage(widget.image))),
          ),
            ),
            status?Center(
              child: ElevatedButton(onPressed: (){
                status = false;
                setState(() {});
                send();
              }, child: Text("Extract text and auto fill")),
            ):Container(), 

            // This is container which shows status

            Container(
              child: status? 
              Form(
                child: Column(children: [
                  Text("Name")
                ],),
              )
              
              
              :Column(
                children: [
                   SizedBox(height: 20,),

            Text('    Upload to Server to identify', style: GoogleFonts.poppins(fontSize: 18,),textAlign: TextAlign.left,),
            Row(
              
              children:[ 
                SizedBox(width: 10,),
                
                Center(

                child: LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width*.75,
                    lineHeight: 18.0,
                    percent: percent,
                    
                    backgroundColor: Colors.grey,
                    progressColor: Colors.green,
                    alignment: MainAxisAlignment.center,
                    animationDuration: 4000,
                    animation: true,
                    curve: Curves.easeInOutQuart,
                    center: Text((percent*100).toInt().toString()+'%' , style: GoogleFonts.poppins(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300)) ,
                    //animateFromLastPercent: true,
                  ),
              ),

              SizedBox(width: 20,),

                Icon(percent<1?(Icons.hourglass_bottom):(Icons.check_circle) ,color: percent<1?Colors.amber:Colors.green, size: 30,)

              ]
            ),

           SizedBox(height: 20,),

           processing?Row(
              
              children:[ 
                SizedBox(width: 10,),
               Text('   Processing...', style: GoogleFonts.poppins(fontSize: 18,),textAlign: TextAlign.left,),

              SizedBox(width: 20,),

                Icon(model!=null?Icons.check_circle:Icons.cached, color: model!=null?Colors.green:Colors.yellow, size: 30,)

              ]
            ): Container(),
                ],
              ),
            )

          ],
        ),
      )
    );
  }
}