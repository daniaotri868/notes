import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_dairy/layout/start-page/writing.dart';

import '../../cubit/app_cubit.dart';
import '../../shared/widget.dart';

class StartPage extends StatelessWidget {
   StartPage({Key? key}) : super(key: key);


   TextEditingController search=TextEditingController();
  @override

  List color=[ Colors.green[100],Colors.yellow[200],Colors.purple[100], Colors.red[100],Colors.green[200],Colors.yellow[100],Colors.blue[100],Colors.pink[50],Colors.purple[50],Colors.blue[50],Colors.pink[100]];
  final _random = new Random();


  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 3,
        child: Icon(Icons.add,color: Colors.black87),
        onPressed: () async {
             await AppCubit.get(context).insertDataBase(text: "",date: (DateFormat.yMMMEd().format(DateTime.now())).toString(),);
               Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  print( " oneee= ${AppCubit.get(context).listNote[AppCubit.get(context).listNote.length-1]}");
                  print("twoooo=${ AppCubit.get(context).listNote[AppCubit.get(context).listNote.length-1]['id']}");

                  return Writing(
                      AppCubit.get(context).listNote[AppCubit.get(context).listNote.length-1],
                      AppCubit.get(context).listNote[AppCubit.get(context).listNote.length-1]['id']);

                },)).then((value) {
              });


        },
      ),
      appBar: AppBar(
        title: Text("NoteBad",style: TextStyle(color: Colors.black87, shadows: [Shadow(color: Colors.black12,blurRadius: 10,offset: Offset(0, 3))])),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed:() {
            AppCubit.get(context).SquareShow=false;
          AppCubit.get(context).SqureCheck.forEach((key, value) {
            if(value==true)
            {
              AppCubit.get(context).DeleteDataBase(id: key);
            }
          });
            //AppCubit.get(context).DeleteAll();
           AppCubit.get(context).listNote.forEach((element) {

              AppCubit.get(context).SqureCheck.addAll(
                  {
                    element['id']:false
                  }
              );
            });
          }, icon: Icon(Icons.delete_sweep),color: Colors.black54,)
          ,IconButton(onPressed:  () =>showDialog(context: context, builder: (context) =>CupertinoAlertDialog(
            title: Text("Accept ?"),
            content: Text("Do you Delete all notebook ?!"),
            actions: [
              CupertinoDialogAction(child: TextButton(child: Text("Yes"),onPressed: () {
                  AppCubit.get(context).DeleteAll();
                  Navigator.pop(context);
              },)),
              CupertinoDialogAction(child: TextButton(child: Text("No"),onPressed: () {
                Navigator.pop(context);
              },)),

            ],
          ),), icon: Icon(Icons.delete),color: Colors.black54,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller:search ,
              keyboardType: TextInputType.name,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                prefixIcon: Icon(Icons.search,color: Colors.black45),
                hintText: "Search in NoteBad",
                hintStyle: TextStyle(color: Colors.black45),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.black12)
                ),
               focusedBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(25),
                   borderSide: BorderSide(color: Colors.black12)
               ),
              ),
              onChanged: (value) {
                print(value);
                AppCubit.get(context).functionSearch(value: value,context: context);

                print("Search value ${ AppCubit.get(context).SearchOrNo}");

              },
              onTap: () {

              },
              onFieldSubmitted: (value) {

              },
            ),
            SizedBox(height: 20,),
             Expanded(
               child: ListView.separated(
                 itemBuilder: (context, index) =>  Dismissible(
                   key:UniqueKey(),
                    onDismissed: (direction) {
                      AppCubit.get(context).DeleteDataBase(id: AppCubit.get(context).listNote[index]['id']);
                    },
                   child: cardNote(
                       index:index,
                       context: context,
                       color:color[_random.nextInt(color.length)],
                       text:AppCubit.get(context).SearchOrNo? AppCubit.get(context).Search[index]:AppCubit.get(context).listNote[index] ,
                       id: AppCubit.get(context).SearchOrNo? AppCubit.get(context).Search[index]['id']:AppCubit.get(context).listNote[index]['id'],
                       SqureChange: AppCubit.get(context).ChangeCheckSqure,
                        function:AppCubit.get(context),
                   ),
                 ),
                  itemCount: AppCubit.get(context).SearchOrNo?AppCubit.get(context).Search.length:AppCubit.get(context).listNote.length,
                 separatorBuilder: (BuildContext context, int index) =>SizedBox(height: 10),

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
