import "package:expense_tracker_app/Expenses.dart";
import "package:flutter/material.dart";

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Expenses(),
    )
  );
}