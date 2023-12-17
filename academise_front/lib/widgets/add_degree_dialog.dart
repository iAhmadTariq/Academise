import 'package:academise_front/utils/color.dart';
import 'package:academise_front/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class addDegreeDialog extends StatefulWidget {
  const addDegreeDialog({super.key});

  @override
  State<addDegreeDialog> createState() => _addDegreeDialogState();
}

class _addDegreeDialogState extends State<addDegreeDialog> {
  final TextEditingController _degreeNameController = TextEditingController();
  final TextEditingController _programNameController = TextEditingController();

  final String baseUrl =
      'http://10.7.93.23:5000/'; // Replace with your actual API URL
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  Future<void> fetchData(String name, {int offset = 0, int limit = 3}) async {
    final String endpoint = '/search';
    final Uri uri =
        Uri.parse('$baseUrl$endpoint?name=$name&offset=$offset&limit=$limit');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          searchResults = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder inputBorder = OutlineInputBorder(
                      borderSide: Divider.createBorderSide(context),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    );
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 1,
      backgroundColor: Colors.transparent,
      
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        height: 300,
        decoration: BoxDecoration(
          color: mobileBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Add Degree',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldInput(
              hintText: 'Degree Name (Bachelor, Master, etc.)',
              textEditingController: _degreeNameController,
              textInputType: TextInputType.text,
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldInput(
              hintText: 'Program Name (Computer Science, etc.)',
              textEditingController: _programNameController,
              textInputType: TextInputType.text,
            ),
            SizedBox(
              height: 20,
            ),
            Autocomplete<Map<String, dynamic>>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<Map<String, dynamic>>.empty();
                }
                return searchResults.where((result) => result['name']
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase()));
              },
              onSelected: (value) {
                // Handle the selected value
                print('Selected University: ${value?['name']}');
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController controller,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  cursorColor: purpleColor,
                  onChanged: (value) {
                    // Trigger API call when the user types
                    fetchData(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search University',
                    border: inputBorder,
                    focusedBorder: inputBorder,
                    enabledBorder: inputBorder,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                );
              },
              displayStringForOption: (option) => option['name'],
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<Map<String, dynamic>> onSelected,
                  Iterable<Map<String, dynamic>> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: SizedBox(
                      height: 200.0,
                      width: 400,
                      child: ListView.builder(
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Map<String, dynamic> option =
                              options.elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                            },
                            child: ListTile(
                              title: Text(option['name']),
                              subtitle: Text(option['country']),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
