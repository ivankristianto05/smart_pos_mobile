import 'package:flutter/material.dart';

class PosNumpadPanel extends StatelessWidget {

  final Function(String) onDigit;
  final VoidCallback onBackspace;
  final VoidCallback onExact;

  const PosNumpadPanel({
    super.key,
    required this.onDigit,
    required this.onBackspace,
    required this.onExact,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(20),

      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: Color(0xFFE5E5E5)),
        ),
      ),

      child: Column(
        children: [

          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,

              children: [

                numpadButton("7"),
                numpadButton("8"),
                numpadButton("9"),

                numpadButton("4"),
                numpadButton("5"),
                numpadButton("6"),

                numpadButton("1"),
                numpadButton("2"),
                numpadButton("3"),

                numpadButton("000"),
                numpadButton("0"),

                ElevatedButton(
                  onPressed: onBackspace,
                  child: const Icon(Icons.backspace),
                )

              ],
            ),
          ),

          SizedBox(
            width: double.infinity,
            height: 50,

            child: ElevatedButton(
              onPressed: onExact,
              child: const Text("Exact"),
            ),
          )

        ],
      ),
    );
  }

  Widget numpadButton(String number){

    return ElevatedButton(

      onPressed: () => onDigit(number),

      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade200,
      ),

      child: Text(
        number,
        style: const TextStyle(
          fontSize: 22,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}