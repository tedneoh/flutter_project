import 'package:flutter/material.dart';
import 'package:flutter_project/providers/contacts.dart';
import 'package:provider/provider.dart';

import 'contact_item.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);
  static const routeName = '/contacts';

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

Future<void> _refreshProducts(BuildContext context) async {
  await Provider.of<Contacts>(context, listen: false).fetchContacts();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  Widget build(BuildContext context) {
    final contractsData = Provider.of<Contacts>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: contractsData.contacts.length,
            itemBuilder: (_, i) => Column(
              children: [
                ContactItem(
                  contractsData.contacts[i].id,
                  contractsData.contacts[i].firstName,
                  contractsData.contacts[i].lastName,
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
