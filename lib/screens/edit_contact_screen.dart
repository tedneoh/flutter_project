import 'package:flutter/material.dart';
import 'package:flutter_project/providers/contact.dart';
import 'package:flutter_project/providers/contacts.dart';
import 'package:provider/provider.dart';

class EditContactScreen extends StatefulWidget {
  const EditContactScreen({super.key});
    static const routeName = '/edit-contacts';

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  final _form = GlobalKey<FormState>();
  // ignore: prefer_final_fields
  var _editedContact = Contact(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
  );
  // ignore: prefer_final_fields
  var _initValues = {
    'firstName': '',
    'lastName': '',
    'email': '',
    'phone': '',
  };
  var _isInit = true;
  var _isLoading = false;

  bool isValidEmail(value) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final contactId = ModalRoute.of(context)!.settings.arguments as String;
      if (contactId != null) {
        _editedContact =
            Provider.of<Contacts>(context, listen: false).findById(contactId);
        _initValues = {
          'firstName': _editedContact.firstName,
          'lastName': _editedContact.lastName,
          'email': _editedContact.email == null
              ? ''
              : _editedContact.email == ''
                  ? ''
                  : _editedContact.email!,
          // 'imageUrl': _editedProduct.imageUrl,
          'phone': _editedContact.phone == null
              ? ''
              : _editedContact.phone == ''
                  ? ''
                  : _editedContact.phone!,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (_editedContact.id != null) {
      Provider.of<Contacts>(context, listen: false)
          .updateContact(_editedContact.id, _editedContact);
    } else {
      //error
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['firstName'],
                decoration: const InputDecoration(labelText: 'First Name'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedContact = Contact(
                    firstName: value!,
                    lastName: _editedContact.lastName,
                    email: _editedContact.email,
                    phone: _editedContact.phone,
                    id: _editedContact.id,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['lastName'],
                decoration: const InputDecoration(labelText: 'Last Name'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedContact = Contact(
                    firstName: _editedContact.firstName,
                    lastName: value!,
                    email: _editedContact.email,
                    phone: _editedContact.phone,
                    id: _editedContact.id,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['email'],
                decoration: const InputDecoration(labelText: 'Email'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email.';
                  }
                  if (!isValidEmail(value)) {
                    return 'Please enter an valid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedContact = Contact(
                    firstName: _editedContact.firstName,
                    lastName: _editedContact.lastName,
                    email: value,
                    phone: _editedContact.phone,
                    id: _editedContact.id,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['phone'],
                decoration: const InputDecoration(labelText: 'Phone'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedContact = Contact(
                    firstName: _editedContact.firstName,
                    lastName: _editedContact.lastName,
                    email: _editedContact.email,
                    phone: value,
                    id: _editedContact.id,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
