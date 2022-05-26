import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqlite_notes/model/mycolors.dart';
import '../model/note.dart';

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;
  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    final time = DateFormat.yMMMd().format(note.createdTime);

    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
        elevation: 5,
        color: Colors.white,
        child: ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          child: Row(
            children: [
              Container(
                color: Color(note.color),
                height: 100,
                width: 10,
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          note.title,
                          style: TextStyle(
                            color: Color(MyColors.myColors[0]),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                              time,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 10),
                            )),
                      ]),
                  Flexible(
                      child: Text(
                    note.description.length > 50
                        ? note.description.substring(0, 50) + '...'
                        : note.description,
                    maxLines: 2,
                    style: const TextStyle(color: Colors.grey),
                  )),
                ],
              ),
            ],
          ),
        ));
  }
}
