import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../layout/start-page/writing.dart';

Widget cardNote({required index,required context,required color,required text ,required id,required function,required SqureChange})=>
    InkWell(
      onLongPress: (){
        print("on lonnnng");
        function.ChangeSqure();
      },
    child: Container(
        height: 100,
        width: 200,
         margin: EdgeInsets.all(0),
        decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(text['text'],maxLines: 1,softWrap: false,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    Text(text['date'],style: TextStyle(color: Colors.black54),)
                  ],
                ),
              ),
              function.SquareShow?
              Column(

                children: [
                  IconButton(onPressed: () {
                    function.ChangeCheckSqure(id:id);
                  }, icon:
                  function.SqureCheck[id]?Icon(Icons.check_box):Icon(Icons.check_box_outline_blank)),
                ],
              ):Container()
            ],
          ),
        )

    ),

    onTap: () =>Navigator.push(context,MaterialPageRoute(builder: (context) => Writing(text,id),) )
);