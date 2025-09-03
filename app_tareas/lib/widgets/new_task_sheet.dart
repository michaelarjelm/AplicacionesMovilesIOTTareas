import 'package:flutter/material.dart';

class NewTaskSheet extends StatefulWidget{
  const NewTaskSheet({super.key, required this.onSubmit});

  final void Function(String title, String? note) onSubmit;
  
  @override
  State<NewTaskSheet> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewTaskSheet>{
  final _formkey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  
  @override
  void dispose(){
    _titleCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
  return Form(
    key: _formkey,
    child:
      Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          const Text("Nueva Tarea", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)
          ),

        ],
      )
    );
  }
}