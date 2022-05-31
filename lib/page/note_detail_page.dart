import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/notes_database.dart';
import '../model/mycolors.dart';
import '../model/note.dart';
import '../page/edit_note_page.dart';
import 'notes_page.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;

  const NoteDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);
    note = await NotesDatabase.instance.readNote(widget.noteId);
    setState(() => isLoading = false);
  }

  Future updateColor(int i) async {
    setState(() => {isLoading = true});

    final newnote = note.copy(color: MyColors.myColors[i]);
    await NotesDatabase.instance.update(newnote);
    setState(() {
      note.color = MyColors.myColors[i];
      Navigator.pop(context);
      isLoading = false;
    });
  }

  menu(context, Note note) {
    Future dublicate() async {
      final newnote = Note(
        title: note.title,
        description: note.description,
        createdTime: DateTime.now(),
        color: note.color,
      );

      await NotesDatabase.instance.create(newnote);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NotesPage()));
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
            color: Color(note.color),
            child: Wrap(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.share, color: Color(MyColors.myColors[0])),
                  ),
                  title: const Text(
                    'Share',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: null,
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.delete, color: Color(MyColors.myColors[0])),
                  ),
                  title: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    await NotesDatabase.instance.delete(note.id!);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NotesPage()));
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.copy, color: Color(MyColors.myColors[0])),
                  ),
                  title: const Text(
                    'Dublicate',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: dublicate,
                ),
                Container(
                    margin: const EdgeInsets.only(left: 10, bottom: 10),
                    // padding: EdgeInsets.symmetric(horizontal: 0),
                    height: 30,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (int i = 0; i < MyColors.myColors.length; i++)
                          GestureDetector(
                            onTap: () async => await updateColor(i),
                            child: (CircleAvatar(
                              backgroundColor: Color(MyColors.myColors[i]),
                              child: note.color == MyColors.myColors[i]
                                  ? const Icon(Icons.check)
                                  : null,
                            )),
                          )
                      ],
                    ))
              ],
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NotesPage())),
          ),
          backgroundColor: Color(note.color),
          title: const Text('Note Details'),
          actions: [
            editButton(),
            IconButton(
              onPressed: () => menu(context, note),
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      note.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(note.createdTime),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      note.description,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    )
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note),
        ));

        refreshNote();
      });
}
