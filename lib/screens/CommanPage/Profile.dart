import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/auth/auth_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDetailsProvider);
    final name =  "${user.value?.firstName ?? 'N/A'} ${user.value?.lastName ?? 'N/A'}";

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Create controllers prefilled with current values when dialog opens
              final _firstNameController = TextEditingController(text: user.value?.firstName ?? '');
              final _lastNameController = TextEditingController(text: user.value?.lastName ?? '');
              final _emailController = TextEditingController(text: user.value?.email ?? '');
              final _phoneController = TextEditingController(text: user.value?.phone ?? '');

              final _formKey = GlobalKey<FormState>();

              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Update Profile'),
                    content: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _firstNameController,
                              decoration: const InputDecoration(
                                labelText: 'First Name',
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter first name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _lastNameController,
                              decoration: const InputDecoration(
                                labelText: 'Last Name',
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter last name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter email';
                                }
                                final emailRegEx = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$");
                                if (!emailRegEx.hasMatch(value.trim())) return 'Enter a valid email';
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: 'Phone',
                                prefixIcon: Icon(Icons.phone),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter phone number';
                                }
                                // simple phone validation
                                if (value.trim().length < 7) return 'Enter a valid phone number';
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) return;

                          // Prepare updated values
                          final updatedFirstName = _firstNameController.text.trim();
                          final updatedLastName = _lastNameController.text.trim();
                          final updatedEmail = _emailController.text.trim();
                          final updatedPhone = _phoneController.text.trim();

                          // TODO: replace the method below with whatever update method exists in your auth provider.
                          // Example assumes an `updateProfile` method on the auth controller that accepts a map or named params.
                          // try {
                          //   await ref.read(authControllerProvider.notifier).updateProfile(
                          //     firstName: updatedFirstName,
                          //     lastName: updatedLastName,
                          //     email: updatedEmail,
                          //     phone: updatedPhone,
                          //   );
                          //
                          //   // Close dialog after successful update
                          //   Navigator.of(context).pop();
                          //
                          //   // Optionally show feedback
                          //   if (mounted) {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(content: Text('Profile updated successfully')),
                          //     );
                          //   }
                          // } catch (e) {
                          //   // Handle/update error handling to match your controller's behavior
                          //   if (mounted) {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(content: Text('Failed to update profile: \$e')),
                          //     );
                          //   }
                          // }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                user.value?.firstName.isNotEmpty == true &&
                    user.value?.lastName.isNotEmpty == true
                    ? "${user.value!.firstName[0].toUpperCase()}${user.value!.lastName[0].toUpperCase()}"
                    : "U",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              name,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            // info

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [

                  _buildProfileInfoCard(
                    context,
                    'First Name',
                    user.value?.firstName ?? 'N/A',
                    Icons.person ,

                  ),
                  const SizedBox(height: 20),
                  _buildProfileInfoCard(
                    context,
                    'Last Name',
                    user.value?.lastName ?? 'N/A',
                    Icons.person,

                  ),
                  const SizedBox(height: 20),
                  _buildProfileInfoCard(
                    context,
                    'Email',
                    user.value?.email ?? 'N/A',
                    Icons.email,

                  ),

                  const SizedBox(height: 16),
                  _buildProfileInfoCard(
                    context,
                    'Phone',
                    user.value!.phone ?? 'N/A',
                    Icons.phone,

                  ),


                ],
              ),
            ),



            const SizedBox(height: 30),

            Divider(),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Sign Out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: () {
                ref.read(authControllerProvider.notifier).signOut();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfoCard(
      BuildContext context,
      String title,
      String value,
      IconData icon,

      ) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(color: Colors.grey[700]),
      ),
      subtitle: Text(
        value,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
      ),


    );
  }
}
