import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship/insurancelist.dart';
import 'package:internship/patientmodel.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:internship/scanimage.dart';
import 'package:http_parser/http_parser.dart';


class InformationPage extends StatefulWidget {
  InformationPage({this.patient});

  final Patients patient;

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  File _image;



  camera(String n) async{

    File actualimg;

    var img = await ImagePicker().getImage(source: ImageSource.camera,imageQuality:n=='card'?50: 100,);
   actualimg = File(img.path);
   if(n=='card'){

      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ScanImage(image: actualimg,patient: widget.patient,)));
  }


   else{
     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InsuranceList(image: actualimg,patient: widget.patient,side: n,)));

   }
   
    
  }


  galary(String n) async{

     File actualimg;

    var img = await ImagePicker().getImage(source: ImageSource.gallery,imageQuality:n=='card'?50: 100,);
   actualimg = File(img.path);
   if(n=='card')
    {

        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ScanImage(image: actualimg,patient: widget.patient,)));


    }
    else{
     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InsuranceList(image: actualimg,patient: widget.patient,side: n,))); 
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Info'),),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(child: Icon(Icons.account_circle,size: 150,color: Colors.blue,)),
             AutoSizeText(
                            widget.patient.fullName,
                            style: GoogleFonts.poppins(fontSize: 28,fontWeight: FontWeight.w400),
                            minFontSize: 5,
                            maxLines: 4,
                          ),

             SizedBox(
              height: 20,
            ),

            Row(
              children: [
                Text("Patient Id :",style: GoogleFonts.poppins(fontSize: 18),),
                SizedBox(width: 50,),
                 Container(
                   width: MediaQuery.of(context).size.width*.40,
                   child: AutoSizeText(
                              widget.patient.patientId,
                              style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w400),
                              minFontSize: 5,
                              maxLines: 4,
                            ),
                 ),
              ],
            ),
            SizedBox(height: 10,),
               Row(
              children: [
                Text("Gender  :",style: GoogleFonts.poppins(fontSize: 18),),
                SizedBox(width: 60,),
                 Container(
                   width: MediaQuery.of(context).size.width*.40,
                   child: AutoSizeText(
                              widget.patient.gender,
                              style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w400),
                              minFontSize: 5,
                              maxLines: 4,
                            ),
                 ),
              ],
            ),
            SizedBox(height: 10,),
               Row(
              children: [
                Text("DOB  :",style: GoogleFonts.poppins(fontSize: 18),),
                SizedBox(width: 85,),
                 Container(
                   width: MediaQuery.of(context).size.width*.40,
                   child: AutoSizeText(
                              widget.patient.dob,
                              style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w400),
                              minFontSize: 5,
                              maxLines: 4,
                            ),
                 ),
              ],
            ),
            
            SizedBox(height: 40,),
            ElevatedButton(onPressed: () async{
               _showMyDialog('card',true);

            }, child: Text("Add Insurance card",style: GoogleFonts.poppins(fontSize: 18,color: Colors.white))),

            SizedBox(height: 20,),
            ElevatedButton(onPressed: () async{
                _showMyDialog("front",false);
                 

            }, child: Text("Upload front of insurance",style: GoogleFonts.poppins(fontSize: 18,color: Colors.white))),

             SizedBox(height: 20,),
            ElevatedButton(onPressed: () async{
                 
               _showMyDialog("back",false);
                 

            }, child: Text("Upload back of insurance",style: GoogleFonts.poppins(fontSize: 18,color: Colors.white))),
          ],
        ),
      )
    );
  }




  Future<int> _showMyDialog(String side,bool card) async {

    int res;
  return showDialog<int>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(card?'Upload the details of Insurance':'Upload the ${side} of insurance'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
            
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('From gallery'),
            onPressed: () async {
             Navigator.of(context).pop();
             galary(side); 
            },
          ),
          TextButton(
            child: Text('Take picture'),
            onPressed: () async{
                
             Navigator.of(context).pop();
             camera(side);
            },
          ),
          
        ],
      );
    },
    
  );
  
}




 

  
}