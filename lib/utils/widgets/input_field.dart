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
  final TextInputType? keyboardType;
  final double width;
  final double height;

  const InputField({ 
    Key? key,
    required this.title, 
    required this.placeHolder, 
    required this.errorText, 
    this.obescureText = false, 
    this.isError = false, 
    required this.controller, 
    this.keyboardType,
    required this.width,
    this.height = 50,
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
          if(focusNode.hasFocus){ stateIsError = false;}
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
    return Column
    (
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        createTitle(),
        createTextFieldStack(),
        if(stateIsError) ...[createError()]
      ]
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
        fontWeight: FontWeight.w500
      ),
    );
  }

  Color getTitleColor()
  {
    if(focusNode.hasFocus)
      return accentColor;
    else if (stateIsError)
      return errorColor;
    else
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
            right: 15,
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
      child: Icon(CupertinoIcons.eye_fill, color: stateObsecureText ? notActiveColor : primaryColor.withOpacity(0.9)),
    );
  }

  Widget createTextField() 
  {
    return SizedBox
    (
      width: widget.width,
      height: widget.height,
      child:
        TextFormField
        (
          controller: widget.controller,
          focusNode: focusNode,
          obscureText: stateObsecureText,
          keyboardType: widget.keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration
          (
            hintText: widget.placeHolder,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
            isDense: true,
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
        ),
    );
  }

  Widget createError()
  {
    return Container
    (
      padding: const EdgeInsets.only(top: 2),
      child: Text(widget.errorText, style: const TextStyle(color: errorColor, fontSize: 12)),
    );
  }
}