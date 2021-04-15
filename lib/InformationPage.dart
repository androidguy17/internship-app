import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship/patientmodel.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:internship/scanimage.dart';


class InformationPage extends StatefulWidget {
  InformationPage({this.patient});

  final Patients patient;

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  File _image;

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
            Center(child: _image==null?Icon(Icons.account_circle,size: 150,color: Colors.blue,):Container(height: 100, width: 100, decoration: BoxDecoration( image: DecorationImage(image: FileImage(_image)) ),),),
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
                  var img = await ImagePicker().getImage(source: ImageSource.gallery,imageQuality: 50,);

                  if(img!=null){
                   _image = File(img.path);
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ScanImage(image: _image,)));
                  }

            }, child: Text("Add Insurance card",style: GoogleFonts.poppins(fontSize: 18,color: Colors.white))),
          ],
        ),
      )
    );
  }

  
}