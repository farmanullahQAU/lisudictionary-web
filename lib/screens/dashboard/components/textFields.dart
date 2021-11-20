
import 'package:flutter/material.dart';

import '../../../constants.dart';

class TxtField extends StatelessWidget {
  Icon? suffixIcon;
  Icon? prefixIcon;
  String? hintText;
  String? labelText;
  Function? validator;
  Function? onSaved;

  TextEditingController? controller;

   TxtField({Key? key,this.suffixIcon,this.prefixIcon,this.labelText,this.controller,this.hintText,this.validator,this.onSaved}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      return  TextFormField(


            validator:(val)=>this.validator!=null?this.validator!(val):null,
    //    onSaved:(val)=>this.onSaved!=null?this.onSaved!(val):null,

        controller: this.controller,
          //  cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
          //  initialValue: 'Input text',
            maxLength: 20,
            decoration: InputDecoration(
              filled: true,
            fillColor: bgColor,
             hoverColor: bgColor,
             //  border: OutlineInputBorder(),
           //   icon: Icon(Icons.favorite),
              labelText: this.labelText,
            hintText: this.hintText,
            //  helperText: 'Helper text',
              suffixIcon: this.suffixIcon
            ),
          );
    }
  }

