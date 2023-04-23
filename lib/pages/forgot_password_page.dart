 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
   const ForgotPasswordPage({Key? key}) : super(key: key);

   @override
   State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
 }

 class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
   final _emailController = TextEditingController();
   @override
   void dispose() {
     _emailController.dispose();
     super.dispose();
   }
   Future passwordReset() async{
     try{
       await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
     } on FirebaseAuthException catch (e){
       showDialog(context: context, builder: (context){
         return AlertDialog(
           backgroundColor: Colors.redAccent,
           title: const Text('Error'),
           content: Text(e.message.toString()),
           actions: [
             TextButton(
               child: const Text('OK',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
               onPressed: () {
                 Navigator.of(context).pop();
               },
             ),
           ],);
       });
     }
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.purple,
         elevation: 0,
       ),
       backgroundColor: Colors.deepPurple[100],
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           const Text('We will send you message with instruction',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
           const SizedBox(height: 20,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 25.0),
             child: Container(
               padding: const EdgeInsets.all(8),
               decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(30)),
               child: Padding(
                 padding: const EdgeInsets.only(left: 20.0),
                 child: TextField(
                   controller: _emailController,
                   decoration: const InputDecoration(
                       border: InputBorder.none, hintText: 'Email'),
                 ),
               ),
             ),
           ),
           GestureDetector(
             onTap: passwordReset,
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
               child: Container(
                 padding: const EdgeInsets.all(25),
                 decoration: BoxDecoration(
                   color: Colors.deepPurple,
                   borderRadius: BorderRadius.circular(20)
                 ),
                 child: const Text("Reset Password",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

               ),
             ),
           )
         ],
       ),
     );
   }
 }
