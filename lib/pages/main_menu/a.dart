import 'package:flutter/material.dart';

class DynamicTextFieldPage extends StatefulWidget {
  @override
  _DynamicTextFieldPageState createState() => _DynamicTextFieldPageState();
}

class _DynamicTextFieldPageState extends State<DynamicTextFieldPage> {
  List<TextEditingController> _controllers = [];
  List<Widget> _textFields = [];

  void _addTextField() {
    final controller = TextEditingController();
    _controllers.add(controller);
    setState(() {
      _textFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter text',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _removeTextField(controller);
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  void _removeTextField(TextEditingController controller) {
    setState(() {
      int index = _controllers.indexOf(controller);
      if (index != -1) {
        _controllers.removeAt(index);
        _textFields.removeAt(index);
      }
    });
    controller.dispose();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic TextFields'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _textFields.length,
              itemBuilder: (context, index) {
                return _textFields[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _addTextField,
              child: Text('Add TextField'),
            ),
          ),
        ],
      ),
    );
  }
}