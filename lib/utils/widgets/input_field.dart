import 'package:enloquenutrition/utils/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String title;
  final String placeHolder;
  final String errorText;
  final bool obescureText;
  final bool isError;
  final TextEditingController controller;
  final VoidCallback onTextChanged;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  
  const InputField({ 
    Key? key,
    required this.title, 
    required this.placeHolder, 
    required this.errorText, 
    this.obescureText = false, 
    this.isError = false, 
    required this.controller, 
    required this.onTextChanged, 
    this.textInputAction = TextInputAction.done, 
    this.keyboardType 
  }) : super(key: key);

  @override
  _InputStateField createState() => _InputStateField();
}

class _InputStateField extends State<InputField> {
  final focusNode = FocusNode();
  bool stateObsecureText = false;
  bool stateIsError = false;

  @override
  void initState()
  {
    super.initState();

    focusNode.addListener
    (
      ()
      { setState(()
        {
          if(focusNode.hasFocus){ stateIsError = false; }
        });
      }
    );

    stateObsecureText = widget.obescureText;
    stateIsError = widget.isError;
  }

  @override
  void didUpdateWidget(covariant InputField oldWidget)
  {
    super.didUpdateWidget(oldWidget);

    stateObsecureText = widget.obescureText;
    stateIsError = focusNode.hasFocus ? false : widget.isError;
  }

  @override
  Widget build(BuildContext context) {
    return Container
    (
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column
      (
        children:
        [
          //CreateHeader
          Space(5),
          createTextField(),
          if(stateIsError) ...[/*create error*/]
        ]
      )
    );
  }

  Widget createTitle()
  {
    return Text
    (
      widget.title,
      style: TextStyle
      (
        color: getTitleColor(),
        fontWeight: FontWeight.w400
      ),
    );
  }

  Color getTitleColor()
  {
    if(focusNode.hasFocus)
      return primaryColor;
    else if (stateIsError)
      return errorColor;

    return notActiveColor;
  }

  Widget createTextFieldStack()
  {
    return Stack
    (
      children: 
      [
        createTextField(),
        if(widget.obescureText) ...[
          Positioned
          (
            top: 0,
            bottom: 0,
            right: 0,
            child: createShowEye()
          )
        ]
      ],
    );
  }

  Widget createShowEye()
  {
    return GestureDetector
    (
      onTap: ()
      {
        setState(() 
        {
          stateObsecureText = !stateObsecureText;  
        });
      },
      child: Icon(CupertinoIcons.eye_fill, color: widget.controller.text.isNotEmpty ? primaryColor : notActiveColor,),
    );
  }

  Widget createTextField() 
  {
    return TextFormField
    (
      controller: widget.controller,
      obscureText: stateObsecureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration
      (
        hintText: widget.placeHolder,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7),),
        focusedBorder: OutlineInputBorder
        (
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF7289DA))
        ),
        enabledBorder: OutlineInputBorder
        (
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: stateIsError ? errorColor : Colors.white.withOpacity(0.7))
        ),
      ),
    );
  }

  Widget createError()
  {
    return Container
    (
      padding: const EdgeInsets.only(top: 2),
      child: Text(widget.errorText, style: const TextStyle(color: errorColor)),
    );
  }
}