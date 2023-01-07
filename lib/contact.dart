import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adaptive.h(50),
      width: Adaptive.w(80),
      color: Colors.red,
      constraints: const BoxConstraints(minWidth: 260, maxWidth: 400, maxHeight: 400),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            // TODO: TextFormField researchm & submit & database-integration & automatic email generation
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Vorname Nachname',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Telefonnummer',
              ),
            ),
            TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-Mail Addresse',
                ),
                validator: ((String? email) {
                  if (email != null) {
                    return email.isNotEmpty && EmailValidator.validate(email) ? null : 'This E-Mail isn\'t valid';
                  } else {
                    return 'Please enter your E-Mail';
                  }
                })),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () => formKey.currentState!.validate(), child: Text('submit')),
            )
          ]),
        ),
      ),
    );
  }
}
