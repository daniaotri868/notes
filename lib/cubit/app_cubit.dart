import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context)=>BlocProvider.of(context);
  late Database database;

bool x1=false;
bool x2=true;
bool x3=true;
  List<Map> listNote=[];
  List <Map>Search=[];
 late int id;
 bool SearchOrNo=false;
  bool SquareShow=false;
  bool IconCheck= false;
  Map <int,bool> SqureCheck={};

  void ChangeCheckSqure({required id})
  {

    if( IconCheck==false ) {
      print("in if   $IconCheck");
      IconCheck= true;
    } else {
      print("in else   $IconCheck");
      IconCheck = false;
    }
    SqureCheck[id]=IconCheck;
    print("SqureCheck ${SqureCheck}");
    print("SqureCheck ${SqureCheck[id]}");
    emit(AppCheckSqure());

  }
  void ChangeSqure()
  {
    SquareShow=true;

    listNote.forEach((element) {

      SqureCheck.addAll(
        {
          element['id']:false
        }
      );
    });
    emit(AppSqure());
    print(SqureCheck);
  }
  void functionSearch({ required value,required context})
  {

   Search=[];
    if(value.isNotEmpty)
    {
      SearchOrNo=true;
      listNote.forEach((element) {
        var x=element;
        print("element = \n $element");
        print(element['text']);
        if(element['text'].contains(value))
        {
          Search.add(element);
        }
      });
      print( "Search \n = $Search");

    }
    else
      {
        SearchOrNo=false;
      }
   emit(AppSearch());

  }
  void IconAppChange({required bool x})
  {
    emit(AppStateIconButton());
    if(x==true)
      {
        x1=true;
        x2=false;
        x3=false;
      }
    else
      {
        x1=false;
        x2=true;
        x3=true;
      }
  }

  void CreateDataBase()
  {
    openDatabase(
      'data.db',
      version: 1,
      onCreate: (database, version) {
        database.execute('CREATE TABLE note(id INTEGER PRIMARY KEY, text TEXT, date TEXT)').then((value) {
          print("create Table Successful");
        }).catchError((error){print(" Error : Not Create Table");});
      },
      onOpen: (database) {
             getDataBase(database).then((value) {
               listNote=value;
               print(listNote);
               emit(AppGetDataBase());
             });
              print("DataBase Successful ");
        }


    ,

    ).then((value) {
      database=value;
      emit(AppCreateDataBase());
    });
  }

  Future<List<Map>> getDataBase(Database database)async
  {
    emit(AppLoadingGetDataBase());
    print("in get Data");
    return  await database.rawQuery('select * from note');
  }
 Future insertDataBase({text , date})
 {
   print("in insert Data");
   return  database.transaction((txn)async {
     txn.rawInsert('insert into note (text,date) values ("$text","$date")')
         .then((value){
           emit(AppInsertDataBase());
           print("value =$value");
           id=value;
           getDataBase(database).then((value) {
             listNote=value;
             print(listNote);
             emit(AppGetDataBase());
           });
     }
     ).catchError((error){print("error in insert");});
   });
 }

  Future updateDataBase({text , date, id})async
  {
    emit(AppGetDataBase());
    print("id = $id");
    print("in update");
    return await database.rawUpdate('UPDATE note SET text = "$text", date="$date" WHERE id = ${id}',)
        .then((value) {

          print("update successful");
          getDataBase(database).then((value) {
            emit(AppUpdateDataBase());
            listNote=value;
            print(listNote[id]);
            emit(AppGetDataBase());
          });

    }).catchError((error){
          print("error in update");

    }

    );

  }

  DeleteDataBase({id})async
  {
    print("in delete");
    return await database.rawDelete('DELETE FROM note WHERE id = $id').then((value) {
      emit(AppDeleteDataBase());
     print("delete successful");
     getDataBase(database).then((value) {
       listNote=value;
       print(listNote);
       emit(AppGetDataBase());
     });
    }).catchError((error){print("error in delete");});
  }

  DeleteAll()async
  {
    print("in delete All ");
    return await database.rawDelete('DELETE FROM note ').then((value) {
      emit(AppDeleteDataBase());
      print("delete successful All ");
      getDataBase(database).then((value) {
        listNote=value;
        print(listNote);
        emit(AppGetDataBase());
      });
    }).catchError((error){print("error in delete All ");});

  }

}

