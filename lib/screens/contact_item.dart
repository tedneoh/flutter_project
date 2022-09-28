import 'package:flutter/material.dart';
import 'package:flutter_project/screens/edit_contact_screen.dart';

class ContactItem extends StatelessWidget {
  final String id;
  final String firstName;
  final String lastName;

  const ContactItem(this.id, this.firstName, this.lastName, {super.key});

  @override
  Widget build(BuildContext context) {
    final fullname = '$firstName $lastName';
    return ListTile(
      title: Text(fullname),
      leading: const CircleAvatar(),
      trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditContactScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
    );
  }
}