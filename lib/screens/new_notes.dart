import 'package:flutter/material.dart';

class NewNotes extends StatefulWidget {

  // 📌 Receive old data (for edit)
  final String? heading;
  final String? paragraph;

  const NewNotes({super.key, this.heading, this.paragraph});

  @override
  State<NewNotes> createState() => _NewNotesState();
}

class _NewNotesState extends State<NewNotes> {

  // 📌 Controllers for text input
  TextEditingController headingController = TextEditingController();
  TextEditingController paragraphController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // 🟡 If edit mode → fill old data
    if (widget.heading != null) {
      headingController.text = widget.heading!;
    }

    if (widget.paragraph != null) {
      paragraphController.text = widget.paragraph!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.heading == null ? "Add Note" : "Edit Note",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          children: [

            // 🟢 Heading input
            TextField(
              controller: headingController,
              decoration: const InputDecoration(
                labelText: "Heading",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // 🟢 Paragraph input
            TextField(
              controller: paragraphController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Paragraph",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // 💾 Save button
            ElevatedButton(
              onPressed: () {

                // Send data back
                Navigator.pop(context, {
                  "heading": headingController.text,
                  "paragraph": paragraphController.text,
                });
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}