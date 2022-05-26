import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_notes/model/mycolors.dart';

import 'edit_note_page.dart';

class EmptyHome extends StatelessWidget {
  const EmptyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const Image(image: AssetImage('assets/EmptyHome.png')),
          Text(
            'No Notes :(',
            style: TextStyle(
              color: Color(MyColors.myColors[0]),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                    style: TextStyle(color: Colors.grey),
                    text: 'You have no Notes yet '),
                TextSpan(
                  text: 'Add Your First Note',
                  style: const TextStyle(color: Color(0xFF1321E0)),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddEditNotePage())),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
