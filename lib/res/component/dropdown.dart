import 'package:flutter/material.dart';

class AppDropDown extends StatelessWidget {
  AppDropDown(
      {@required this.dropdownList,
      @required this.onValueChanged,
      @required this.selectedValue,
      this.validator,
      this.marginTop =12});

  final int marginTop;

  final List<String> dropdownList;
  final Function onValueChanged;
  final String selectedValue;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop.toDouble()),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonFormField<String>(
        validator: validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26, width: 1.0),
          ),
          prefixIcon: Icon(Icons.input),
          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        ),
        items: dropdownList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: new Text(
              value,
              style:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.black54),
            ),
          );
        }).toList(),
        onChanged: (String value) {
          onValueChanged(value);
        },
        value: (selectedValue == null) ? dropdownList[0] : selectedValue,
      ),
    );
  }
}
