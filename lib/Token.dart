import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import './patientmodel.dart';



class Token {

  

  int i = 0;

  Future<String> fetch(int i) async{

      if(i>=2){
        return 'cycle';
      }
    
    String res="none";

   String refresh_token ='1000.b0e9b22984d21dc13018df53318edad2.4d92702eb1bf21497bce9a855669199d';
   String url = 'https://pen-accounts.charmtracker.com/oauth/v2/token?refresh_token=$refresh_token&client_id=1000.YLB3YYSMOMT8JN4U3BX9W8VBTTBSDH&client_secret=9f63f8e606b69189741c45ac8124824b72419d686b&redirect_uri=https://sandbox2.charmtracker.com/ehr/physician/mySpace.do?ACTION=SHOW_OAUTH_JSON&grant_type=refresh_token';
  
  try{

    print("here to doing http");

      final post = await http.post(
        Uri.parse(url)).then((http.Response response)async {

          var data = json.decode(response.body);
          print(data);
          res = data['access_token'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', data['access_token']);
        });


    }catch(e){print(e);}

 


    return res;
  }




  fetch_patients(String token) async {

   List<Patients> list =[];

   String result = "none";
   var headers = {
     'api_key': 'adaa4259bc1a68ab950d3ba7233eadb0',
     'Authorization': 'Bearer $token',
   };

   String facility_id = '100018000000000161';
   String url = 'https://sandbox2.charmtracker.com/api/ehr/v1/patients?facility_id=$facility_id';

  try{

    var res = await http.get(
     Uri.parse(url),
     headers: headers,
   ).then((http.Response response) async{

     if(response.statusCode== 401){
      print('expired!'); 
      //result = 'expired';

      String new_token = await fetch(++i);

      if(new_token=='cycle'){
        print('cycle detected');
        result = 'expired';
        return list;
      }

      else{
        print("here");
        list = await fetch_patients(new_token);
        
      }

     }

     else if(response.statusCode==200){

        var data = jsonDecode(response.body);
        print(data);
        result = data['message'];

        var temp= PatientModel.fromJson(data);
        list = temp.patients;

        return list;
     }
     

   });

  }catch(e){print(e);}
   
  return list;


}

    
}
