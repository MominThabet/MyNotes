import 'package:flutter/material.dart';
import '../db/notes_database.dart';
import '../model/mycolors.dart';
import '../model/note.dart';
import '../widget/note_form_widget.dart';
import 'notes_page.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;

  const AddEditNotePage({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        // var color = widget.note!.color ?? Mycolors.myColors[0];
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   icon: Icon(Icons.home),
          //   onPressed: () => Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => const NotesPage())),
          // ),
          backgroundColor: Color(widget.note?.color ?? MyColors.myColors[0]),
          actions: [buildButton()],
          title: widget.note == null
              ? const Text('New Note')
              : const Text('Edit Note'),
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            title: title,
            description: description,
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
          ),
        ),
      );

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: IconButton(
        onPressed: addOrUpdateNote,
        icon: const Icon(Icons.check),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      title: title,
      description: description,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      title: title,
      description: description,
      createdTime: DateTime.now(),
      color: MyColors.myColors[0],
    );

    await NotesDatabase.instance.create(note);
  }
}
