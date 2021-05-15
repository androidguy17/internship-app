import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:internship/InsuranceModel.dart';
import 'package:internship/patientmodel.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class ScanImage extends StatefulWidget {
   ScanImage({this.image, this.patient});
  File image;
  Patients patient;

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

   //for button
   bool button = true;


  GlobalKey<FormState> formkey = GlobalKey();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final insuranceno = TextEditingController();
  final validfrom = TextEditingController();
  final payername = TextEditingController();
  final insured_person_dob = TextEditingController();
 


  
  int _selectInsurance = 0;

  int _insurance_category = 0;

  int _insured_relationship = 0;

List<DropdownMenuItem<int>> _insured_relationship_list = [];
  
 List<DropdownMenuItem<int>> _insurance_categorylist_ = [];
  
  List<DropdownMenuItem<int>> insuranceList = [];

List<String> type = ["MEDICARE", 
"MEDICAID", 
"TRICARE" 
"CHAMPUS", 
"CHAMPVA", 
"GROUP" 
"HEALTH PLAN", 
"FECA BLK LUNG",
"OTHER"
];

List<String> category = ["PRIMARY", 
"SECONDARY", 
"TERTIARY", "AUTO", "WORKERCOMP", "OTHER"
];

List<String> relation = [ "Self", 'Spouse', 
'Child', 'Other'];

void loadrelationship() {

  _insured_relationship_list =[];
  _insured_relationship_list.add(
    new DropdownMenuItem(
      child: Text('Self'),
      value: 0,
    )
  );
   _insured_relationship_list.add(
    new DropdownMenuItem(
      child: Text('Spouse'),
      value: 1,
    )
  );
   _insured_relationship_list.add(
    new DropdownMenuItem(
      child: Text('Child'),
      value: 2,
    )
  );
   _insured_relationship_list.add(
    new DropdownMenuItem(
      child: Text('Other'),
      value: 3,
    )
  );
}

void loadCategory() {
  _insurance_categorylist_ =[];
  _insurance_categorylist_.add(new DropdownMenuItem(
    child: Text('PRIMARY'),
    value: 0,
  ));
  _insurance_categorylist_.add(new DropdownMenuItem(
    child: Text('SECONDARY'),
    value: 1,
  ));
    _insurance_categorylist_.add(new DropdownMenuItem(
    child: Text('TERTIARY'),
    value: 2,
  ));
    _insurance_categorylist_.add(new DropdownMenuItem(
    child: Text('AUTO'),
    value: 3,
  ));
    _insurance_categorylist_.add(new DropdownMenuItem(
    child: Text('WORKERCOMP'),
    value: 4,
  ));
    _insurance_categorylist_.add(new DropdownMenuItem(
    child: Text('OTHER'),
    value: 5,
  ));

}

  void loadinsuranceList() {
  insuranceList = [];
  insuranceList.add(new DropdownMenuItem(
    child: new Text('MEDICARE'),
    value: 0,
  ));
  insuranceList.add(new DropdownMenuItem(
    child: new Text('MEDICAID'),
    value: 1,
  ));
  insuranceList.add(new DropdownMenuItem(
    child: new Text('TRICARE'),
    value: 2,
  ));
    insuranceList.add(new DropdownMenuItem(
    child: new Text('CHAMPUS'),
    value: 3,
  ));
    insuranceList.add(new DropdownMenuItem(
    child: new Text('CHAMPVA'),
    value: 4,
  ));
    insuranceList.add(new DropdownMenuItem(
    child: new Text('GROUP'),
    value: 5,
  ));
    insuranceList.add(new DropdownMenuItem(
    child: new Text('HEALTH PLAN'),
    value: 6,
  ));
    insuranceList.add(new DropdownMenuItem(
    child: new Text('TRICARE'),
    value: 7,
  ));
    insuranceList.add(new DropdownMenuItem(
    child: new Text('FECA BLK LUNG'),
    value: 8,
  ));
    insuranceList.add(new DropdownMenuItem(
    child: new Text('OTHER'),
    value: 9,
  ));
}


  @override
  void initState() { 
    super.initState();
       loadinsuranceList();
    loadCategory();
    loadrelationship();
    print(insuranceList[_selectInsurance].toString());
     
  }

  sendpost() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

   var headers = {
     'api_key': 'adaa4259bc1a68ab950d3ba7233eadb0',
     'Authorization': 'Bearer $token',
    };

    var b = {
        
          
          'insurance_type': type[_selectInsurance],
          'insurance_plan_id': insuranceno.value.text,
          'insurance_category': category[_insurance_category],
          'payer_name': payername.value.text,
          'insured_person_relationship': relation[_insured_relationship],
          'insured_person_first_name': firstname.value.text,
          'insured_person_last_name': lastname.value.text,
          'insured_person_dob' : insured_person_dob.value.text,

      
    };

    print(b);

    String url = 'https://sandbox2.charmtracker.com/api/ehr/v1/patients/${widget.patient.patientId}/insurance';

    var t = await http.post(Uri.parse(url),headers: headers,body:jsonEncode(b)).then((http.Response res) async {

      var data = jsonDecode(res.body);
      print(data);

      await _showMyDialog(data['message']);

    } );
  }

  send() async{

   var url = 'https://intern-zoho.herokuapp.com/single';

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
        firstname.text = model.template.firstname;
        validfrom.text = model.template.validFrom;
        insuranceno.text = model.template.policy;
        lastname.text = model.template.lastname;
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
              child: button?ElevatedButton(onPressed: (){
                button = false;
                status = false;
                setState(() {});
                send();
              }, child: Text("Extract text and auto fill")):Container(),
            ):Container(), 

            // This is container which shows status

            Container(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
              child: status?Form(
                key: formkey,
                child: Column(children: [

                  
                  TextFormField(
                    controller: firstname,
                     decoration: InputDecoration(
                      border: OutlineInputBorder(

                      ),
                      labelText: "Insured Person First Name "
                      
                    ),
                  ),  


                   SizedBox(height: 20,),

                  TextFormField(
                    controller: lastname,
                     decoration: InputDecoration(
                      border: OutlineInputBorder(

                      ),
                      labelText: "Insured Person Last Name "
                      
                    ),
                  ),    

                  SizedBox(height: 20,),

                  TextFormField(
                    controller: insured_person_dob,
                     decoration: InputDecoration(
                      border: OutlineInputBorder(

                      ),
                      labelText: "Insured Person DOB",
                      hintText: 'YYYY-MM-DD'
                    ),
                  ), 


                  SizedBox(height: 20,),

                  TextFormField(
                    controller: validfrom,
                     decoration: InputDecoration(
                      border: OutlineInputBorder(

                      ),
                      labelText: "Valid from",
                      hintText: 'YYYY-MM-DD'
                      
                    ),
                  ),

                  // new fields being added

                 SizedBox(height: 20,),

                 Text('Insurance Type',style: GoogleFonts.poppins(fontSize: 15,),textAlign: TextAlign.left,),

                 SizedBox(
                   height: 50,
                   child: ListView(
                     //shrinkWrap: true,
                   children: getFormWidget(),
                   ),
                 ),

                 SizedBox(height: 20,),

                  TextFormField(
                    
                     decoration: InputDecoration(
                      border: OutlineInputBorder(

                      ),
                      labelText: "Insurance Plan Name"
                      
                    ),
                  ), 

                 SizedBox(height: 20,),

                  TextFormField(
                    controller: insuranceno,
                     decoration: InputDecoration(
                      border: OutlineInputBorder(

                      ),
                      labelText: "Insurance Plan ID"
                      
                    ),
                  ), 

                  SizedBox(height: 20,),

                //   TextFormField(
                //     controller: policy_group_no,
                //      decoration: InputDecoration(
                //       border: OutlineInputBorder(

                //       ),
                //       labelText: "Policy group Number"
                      
                //     ),
                //   ),   

                //  SizedBox(height: 20,),

                 Text('Insurance Category ',style: GoogleFonts.poppins(fontSize: 15,),textAlign: TextAlign.left,),

                 SizedBox(
                   height: 50,
                   child: ListView(
                     //shrinkWrap: true,
                   children: getinsurancecategory(),
                   ),
                 ),  

                  SizedBox(height: 20,),

                  TextFormField(
                    controller: payername,
                     decoration: InputDecoration(
                      border: OutlineInputBorder(

                      ),
                      labelText: "Payer name"
                      
                    ),
                  ),  

                SizedBox(height: 20,),

                 Text('Insured Person Relationship ',style: GoogleFonts.poppins(fontSize: 15,),textAlign: TextAlign.left,),

                 SizedBox(
                   height: 50,
                   child: ListView(
                     //shrinkWrap: true,
                   children: getrelationship(),
                   ),
                 ),

                   SizedBox(height: 20,),

                   ElevatedButton(onPressed: ()async{

                     await sendpost();

                   }, child: Text('Upload'))
 

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
                    width: MediaQuery.of(context).size.width*.65,
                    lineHeight: 18.0,
                    percent: percent,
                    
                    backgroundColor: Colors.grey,
                    progressColor: Colors.green,
                    alignment: MainAxisAlignment.center,
                    animationDuration: 2000,
                    animation: true,
                    animateFromLastPercent: true,
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

  List<Widget> getFormWidget() {
  List<Widget> formWidget = new List();

  formWidget.add(new DropdownButton(
      hint: new Text('Select Insurance type'),
      items: insuranceList,
      value: _selectInsurance,
      onChanged: (value) {
        setState(() {
          _selectInsurance = value;
        });
      },
      isExpanded: true,
    ));
    
    return formWidget;
  }


    List<Widget> getinsurancecategory() {
    List<Widget> formWidget = new List();

  formWidget.add(new DropdownButton(
      hint: new Text('Select Insurance type'),
      items: _insurance_categorylist_,
      value: _insurance_category,
      onChanged: (value) {
        setState(() {
          _insurance_category = value;
        });
      },
      isExpanded: true,
    ));
    
    return formWidget;
  }

  List<Widget> getrelationship(){
    List<Widget> formWidget = new List();

    formWidget.add(DropdownButton(
      hint:  Text('insured_person_relationship'),
      items: _insured_relationship_list,
      value: _insured_relationship,
      onChanged: (value){
        setState(() {
                  _insured_relationship = value;
                });
      },
    ));

    return formWidget;
  }


  Future<void> _showMyDialog(String title) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
            //  Text(title),
              //Text(content),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}