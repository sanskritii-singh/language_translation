import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslationPage extends StatefulWidget {
  const LanguageTranslationPage({super.key});

  @override
  State<LanguageTranslationPage> createState() => _LanguageTranslationPageState();
}

class _LanguageTranslationPageState extends State<LanguageTranslationPage> {

var language=['Hindi','English','French'];
var originLanguage="From";
var destinationLanguage="To";
var output="";
TextEditingController languageController=TextEditingController();

// void translate(String src,String dest,String input) async{
//   GoogleTranslator translator= new GoogleTranslator();
//   var translation=await translator.translate(input,from: src,to: dest);
//   setState(() {
//     output=translation.text.toString();
//   });
//   if(src=='--'||dest=='--'){
//     setState(() {
//       output="Fail to translate";
//     });
//   }
// }
void translate(String src, String dest, String input) async {
  try {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });
  } catch (error) {
    setState(() {
      output = "Translation failed: $error";
    });
  }
}

String getLanguageCode(String language){
  if(language=="English"){
    return "en";
  }else if(language=="Hindi"){
    return "hi";
  }else if(language=="French"){
    return "fr";
  }
  return "--";
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xff10223d) ,
      appBar: AppBar(title:const Text('Language Transaltor'),
      centerTitle: true,
      backgroundColor: Colors.white30,
      elevation: 0,

      ),
      body: Center(
        child:SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(focusColor:Colors.white,
                iconDisabledColor: Colors.white,
                iconEnabledColor: Colors.white,
                hint: Text(
                  originLanguage,style: const TextStyle(color: Colors.white),
                ),
                dropdownColor: Colors.lightGreen[100],
                icon: const Icon(Icons.keyboard_arrow_down_sharp),
                items: language.map((String DropdownStringItem){
                  return DropdownMenuItem(child: Text(DropdownStringItem),
                  value: DropdownStringItem,);
                }).toList(),
                onChanged:(String? value) {
                  setState(() {
                    originLanguage=value!;
                  });
                },
                ),
                const SizedBox(width: 40,),
                const Icon(Icons.arrow_right_alt_rounded,color: Colors.black12,size:40),
                const SizedBox(width: 40,),

                DropdownButton(focusColor:Colors.white,dropdownColor:Colors.lightGreen[100],
                iconDisabledColor: Colors.white,
                iconEnabledColor: Colors.white,
                hint: Text(
                  destinationLanguage,style: const TextStyle(color: Colors.white),
                ),
                // dropdownColor: Colors.lightGreenAccent,
                icon: const Icon(Icons.keyboard_arrow_down_sharp),
                items: language.map((String DropdownStringItem){
                  return DropdownMenuItem(child: Text(DropdownStringItem),value: DropdownStringItem,);
                }).toList(),
                onChanged:(String? value) {
                  setState(() {
                    destinationLanguage=value!;
                  });
                },
              )
            ],
            ),
            const SizedBox(height: 40,),
            Padding(padding: const EdgeInsets.all(8),
            child:TextFormField(
              cursorColor:Colors.white,
              autofocus: false,
              style:const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Please enter your text",
                labelStyle:TextStyle(fontSize: 15,color: Colors.white),
                border:OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white,width:1)
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white,width:1),
              ),
              errorStyle: TextStyle(color: Colors.red,fontSize: 15),
              ),
              controller: languageController,
              validator: (value){
                if(value==null||value.isEmpty){
                  return 'Please enter text to translate';
                }  
                return null;           
              },

              ),
            ),
            Padding(padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              style:ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen
              ),
              onPressed: () {
  if (getLanguageCode(originLanguage) == '--' || getLanguageCode(destinationLanguage) == '--') {
    setState(() {
      output = "Please select valid languages.";
    });
  } else if (languageController.text.isEmpty) {
    setState(() {
      output = "Please enter text to translate.";
    });
  } else {
    translate(getLanguageCode(originLanguage), getLanguageCode(destinationLanguage), languageController.text.toString());
  }
}

              // onPressed:(){
              //   translate(getLanguageCode(originLanguage), getLanguageCode(destinationLanguage), languageController.text.toString());

              // } 
            , child:const Text("Translate")),
            ),
            const SizedBox(height: 30,
            ),
            Text(
              "\n$output",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40
              ),
            )
          ],
        ),
      ) ,
      )
    );
  }
}