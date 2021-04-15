import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:internship/InformationPage.dart';
import 'package:internship/Token.dart';
import 'package:internship/patientmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() { 
    super.initState();
    getpatients();
  }

 List<Patients> data = [];

   getpatients() async {

    //String data;
    Token t = Token();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    data  = await t.fetch_patients(token);

      if(data.length==0){
        print("problem with the token, (expired and unable to retrive new token)");
        return data;
      }


     setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    
   return Scaffold(

     appBar: AppBar(title: Text('Internship'), centerTitle: true,),

     body:data.length==0?Container(
         child: Center(
           child: CircularProgressIndicator(),

         ),
       ):

       Container(
       child: ListView.builder(

           itemCount: data.length,
           itemBuilder: (BuildContext context, int index) {
           return card(data[index].fullName, data[index].patientId, data[index].recordId, data[index].dob,context,data[index]);
          },
         ),
       )


   );
  }


  Widget card(String fullname, String patientid, String recordid, String dob, context,Patients patients){

    return Card(
        margin: EdgeInsets.all(5),
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InformationPage(patient: patients,)),
            );
            },
            child:  SizedBox(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Center(child: AutoSizeText(
                            fullname,
                            style: GoogleFonts.poppins(fontSize: 20),
                            minFontSize: 5,
                            maxLines: 4,
                          )),
                    
                    
                   
                    SizedBox(height: 20,),
                    Row(
                      
                      children: [
                           Text("PatientID : ",style: GoogleFonts.poppins()),
                           SizedBox(width: 30),
                           Text(patientid,style: GoogleFonts.poppins())
                      ],
                    ),
                 
                   Row(
                      
                      children: [
                           Text("RecordId : ",style: GoogleFonts.poppins()),
                           SizedBox(width: 30,),
                           Text(recordid,style: GoogleFonts.poppins())
                      ],
                    ),

                    Row(
                      
                      children: [
                           Text("DOB : ",style: GoogleFonts.poppins()),
                           SizedBox(width: 60,),
                           Text(dob,style: GoogleFonts.poppins())
                      ],
                    ),
                ],),
              ),
            ),
          ),
        );

  }
}