import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubit/app_cubit.dart';


class Writing extends StatelessWidget {
   Map TextControl;
   int id;
   Writing(this.TextControl,this.id);



  @override

  Widget build(BuildContext context) {
    TextEditingController text=TextEditingController(text: "${TextControl['text']}");
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                print(TextControl);
                AppCubit.get(context).IconAppChange(x: false);
                Navigator.pop(context);

              },
              icon: Icon(Icons.arrow_back),
            ),
            iconTheme: IconThemeData.fallback(),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("Note", style: TextStyle(color: Colors.black87)),
            actions:[
              AppCubit.get(context).x1?IconButton(
                  onPressed: () {
                   if(text.text!=null)
                     {
                       print(text.text);
                       print("id = $id");

                       AppCubit.get(context).updateDataBase(text: text.text,date: (DateFormat.yMMMEd().format(DateTime.now())).toString(),id:id );
                       AppCubit.get(context).getDataBase(AppCubit.get(context).database);

                     //  AppCubit.get(context).insertDataBase(text: text.text,date: (DateFormat.yMMMEd().format(DateTime.now())).toString());
                     }
                   Navigator.pop(context);
              }, icon: Icon(Icons.check_sharp),):Container(),
              AppCubit.get(context).x2?IconButton(onPressed: () {

              }, icon: Icon(Icons.share)):Container(),
              AppCubit.get(context).x3?IconButton(onPressed: () {

              }, icon: Icon(Icons.settings)):Container(),


            ],
          ),
          body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               Text("${TextControl['date']}"),
                Text("Title", style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
                Expanded(
                  child: TextFormField(
                    autofocus: false,
                    onTap: () {
                       AppCubit.get(context).IconAppChange(x: true);
                    },
                    controller:text ,
                    maxLines: 200,
                    decoration: InputDecoration(
                        hintText: "write here",
                        border: InputBorder.none
                    ),

                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
