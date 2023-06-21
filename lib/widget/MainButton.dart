import 'package:flutter/material.dart';


class MainButton extends StatelessWidget{
  final Function()? onTap;
  final Text? text;
  final String? image;
  final Color? txtcolor;
  final Color? btncolor;
  const MainButton({Key? key,
  this.onTap,
  this.text,
  this.image,
  this.txtcolor,
  required this.btncolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.0,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color:Color.fromARGB(255, 163, 149, 190),
          borderRadius: BorderRadius.circular(20.0),
         ),
         child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(image!= null)
            Image.asset('assets/images/$image',
            height: 25.0,
            width: 60.0,),
            Text(text!.data!,style: text!.style
            ),
          ],
          
         ),


      ),
    );
  }

}