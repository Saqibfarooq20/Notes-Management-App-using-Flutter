import 'package:first/screens/new_notes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // 📌 List to store all notes
  List<Map<String, String>> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        backgroundColor: Colors.blue,
      ),

      body: Column(
        children: [

          // 🟢 Title
          const Text(
            "Welcome",
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.w500),
          ),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Saqib farooq This is our first assignment",
              style: TextStyle(fontSize: 20),
            ),
          ),

          const SizedBox(height: 20),

          // 🟡 If no data → show message
          notes.isEmpty
              ? const Expanded(
            child: Center(child: Text("No Notes Yet")),
          )

          // 🟢 If data → show list
              : Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {

                return Card(
                  margin: const EdgeInsets.all(10),

                  child: ListTile(
                    title: Text(
                      notes[index]["heading"] ?? "",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),

                    subtitle: Text(
                      notes[index]["paragraph"] ?? "",
                    ),

                    // 🔥 Edit + Delete buttons
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        // ✏️ EDIT
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {

                            // Open same screen with old data
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewNotes(
                                  heading: notes[index]["heading"],
                                  paragraph: notes[index]["paragraph"],
                                ),
                              ),
                            );

                            // If updated data comes
                            if (result != null) {
                              setState(() {
                                notes[index] = {
                                  "heading": result["heading"],
                                  "paragraph": result["paragraph"],
                                };
                              });
                            }
                          },
                        ),

                        // 🗑 DELETE
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              notes.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // ➕ Add new note
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewNotes(),
            ),
          );

          if (result != null) {
            setState(() {
              notes.add({
                "heading": result["heading"],
                "paragraph": result["paragraph"],
              });
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}