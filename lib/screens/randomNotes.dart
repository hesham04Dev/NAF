import 'package:flutter/material.dart';
import 'package:note_files/models/NoteButton.dart';
import 'package:note_files/requiredData.dart';

import '../collection/Note.dart';
import '../translations/translations.dart';

const String githubSource = "https://github.com/hesham04Dev/note_files";

class RandomNotes extends StatefulWidget {
  RandomNotes({
    super.key,
  });

  @override
  State<RandomNotes> createState() => _RandomNotesState();
}

class _RandomNotesState extends State<RandomNotes> {
  final Map<String, String> locale = requiredData.locale;
  final db = requiredData.db;
  final bool isRtl = requiredData.isRtl;
  Note? note;
  getRandomNote() async {
    note = await db.randomNote();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),
          title: Text(locale[TranslationsKeys.randomNotes]!)),
      body: FutureBuilder(
        future: getRandomNote(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (note != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      height: 10,
                    ),
                    // NoteButton(priority: note.priority, noteTitle: note.title?? "", noteTime: note.date??"", noteContent: note.content??"", noteId: note.id, titleDirection: note.isTitleRtl, contentDirection: note.isContentRtl),
                    NoteButton(
                        // priority: note!.priority,
                        // contentDirection:
                        //     isRtlTextDirection(note!.isContentRtl ?? isRtl),
                        // titleDirection:
                        //     isRtlTextDirection(note!.isTitleRtl ?? isRtl),
                        // parentFolderId: note!.parentFolderId,
                        // noteContent: note!.content ?? "",
                        // noteId: note!.id,
                        // noteTitle: note!.title ?? "",
                        // noteTime: formatDate(note!.date!,
                        //     [yy, "/", mm, "/", dd, "   ", hh, ":", nn])
                          note: note! ,
                            ),
                    // Expanded(child: SizedBox()),
                    /*TextButton(onPressed: () async{
                  note = await db.randomNote();
                  setState(() {

                  });
                },child: Icon(Icons.arrow_forward),),*/
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(
                  locale[TranslationsKeys.noRandomNotes]!,
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          setState(() {});
        },
        child: const Icon(Icons.arrow_forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        height: 50,
      ),
    );
  }
}
