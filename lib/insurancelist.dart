import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship/Homepage.dart';
import 'package:internship/InsuranceModel.dart';
import 'package:internship/ModelInsurances.dart';
import 'package:internship/patientmodel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';



class InsuranceList extends StatefulWidget{

  InsuranceList({this.image,this.patient,this.side});
  Patients patient;
  String side;
  File image;

  @override
  _InsuranceListState createState() => _InsuranceListState();
}

class _InsuranceListState extends State<InsuranceList> {

  bool empty = false;


  
  List<Insurances> list =[];

  Dio dio = Dio();

  @override
  void initState() { 
    super.initState();
    send();
  }

  uploadimage(int index)async{

      String url;

      if(widget.side=='front'){
         url = 'https://sandbox2.charmtracker.com/api/ehr/v1/patients/${widget.patient.patientId}/insurance/${list[index].insuranceId}/front_page';
      }
      else if(widget.side=='back'){
         url = 'https://sandbox2.charmtracker.com/api/ehr/v1/patients/${widget.patient.patientId}/insurance/${list[index].insuranceId}/back_page';
      }


     _showMyDialog('Uploading.... ');
     SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    var headers = {
     'api_key': 'adaa4259bc1a68ab950d3ba7233eadb0',
     'Authorization': 'Bearer $token',
    };
    

      print(url);

      String filename = widget.image.path.split('/').last;
      print(filename);
      FormData formData = new FormData.fromMap({
        "file": 
        await MultipartFile.fromFile(widget.image.path, filename: filename,
        contentType: new MediaType('image', 'jpg')),
      });


      Response response = await dio.post(url,data: formData,options: Options(headers: headers),onSendProgress:(int sent, int total) {
       
        print('${((sent/total)*100).floor()}');

        
      }, );

      Navigator.of(context).pop();
      
      _showMyDialog(response.data['message']);

      Future.delayed(Duration(seconds: 3)).then((value) => {
          Navigator.of(context).pop()
      
    

      });

       
   
  }



  send()async{

   
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

   var headers = {
     'api_key': 'adaa4259bc1a68ab950d3ba7233eadb0',
     'Authorization': 'Bearer $token',
    };
    String url = 'https://sandbox2.charmtracker.com/api/ehr/v1/patients/${widget.patient.patientId}/insurances';

    var s = await http.get(Uri.parse(url),
    headers:headers
    ).then((http.Response response) {

      var data = jsonDecode(response.body);
      print(data);

     ModelInsurances model;

     model = ModelInsurances.fromJson(data)..insurances;
     list = model.insurances;
     if(list.length==0){
       empty = true;
     }
     setState(() {
            
          });

          print(list.length);
      
    });

  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Insurance List'),),

      body: SingleChildScrollView(
        
        child: list.length==0?empty==false?Container(
          child: Center(child: CircularProgressIndicator(),),
        ):Container(height: MediaQuery.of(context).size.height*.5, child: Center(child: Text("No Insurance added!",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w300),),),)
        :Container(
          
       child: Column(

         children:[ 
           
           Container(
             height: 200,
             width: 200,
             decoration: BoxDecoration(image: DecorationImage(image: FileImage(widget.image))),
           ),
           
           
           ListView.builder(
             primary: false,
            shrinkWrap: true,
             itemCount: list.length,
             itemBuilder: (BuildContext context, int index) {
             return card(list[index].payerName,list[index].insuranceId, list[index].planType, list[index].type, list[index].insuranceAddedDate,context ,index);
            },
           ),
         ]),
       )
      ),
    );
  }


 Widget card(String payerName,String InsuranceId, String plantype, String type, String insuranceadded_date, context,int index){

    return Card(
        margin: EdgeInsets.all(5),
        
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {


                uploadimage(index);

            },
            child:  SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Center(child: AutoSizeText(
                            payerName,
                            style: GoogleFonts.poppins(fontSize: 20),
                            minFontSize: 10,
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                          )),
                    
                    
                       SizedBox(height: 20,),
                    Row(
                      
                      children: [
                           Text("patient insurance id : ",style: GoogleFonts.poppins()),
                           SizedBox(width: 30),
                           Text(InsuranceId,style: GoogleFonts.poppins())
                      ],
                    ),
                   
                    SizedBox(height: 20,),
                    Row(
                      
                      children: [
                           Text("Plan Type : ",style: GoogleFonts.poppins()),
                           SizedBox(width: 30),
                           Text(plantype,style: GoogleFonts.poppins())
                      ],
                    ),

                 
                   Row(
                      
                      children: [
                           Text("Type : ",style: GoogleFonts.poppins()),
                           SizedBox(width: 30,),
                           Text(type,style: GoogleFonts.poppins())
                      ],
                    ),

                    Row(
                      
                      children: [
                           Text("Insurance added date : ",style: GoogleFonts.poppins()),
                           SizedBox(width: 60,),
                           Text(insuranceadded_date,style: GoogleFonts.poppins())
                      ],
                    ),
                ],),
              ),
            ),
          ),
        );

  }




  Future<void> _showMyDialog(String data) async {

  
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(data),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
            
            ],
          ),
        ),
        actions: <Widget>[
         
         
          
        ],
      );
    },
    
  );
  
}




}