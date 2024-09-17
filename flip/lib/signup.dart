import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flip/genres.dart'; // Import otp.dart file
import 'package:flip/signin.dart'; // Import signin.dart file

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordValid = false;
  bool _isLoading = false;

  // Firebase and Google Sign-In setup
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Function to validate password criteria
  void _validatePassword() {
    setState(() {
      _isPasswordValid = _passwordController.text.length >= 8 &&
          _passwordController.text
              .contains(RegExp(r'[(){}[\]|`¬¦!"£$%^&*<>:;#~\-+=,]'));
    });
  }

  // Function to check if all fields are filled
  bool _areFieldsFilled() {
    return _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _isPasswordValid;
  }

  // Function to authenticate user with email and password
  // Function to authenticate user with email and password
  Future<bool> _authenticateUser() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Call addUserDetails to store user info in Firestore
      await addUserDetails(
        userCredential.user!.uid,
        _nameController.text.trim(),
        _emailController.text.trim(),
      );

      return true; // Authentication successful
    } catch (e) {
      print('Error during authentication: $e');
      return false; // Authentication failed
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

// Function to add user details to Firestore
  Future<void> addUserDetails(String uid, String name, String email) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': name,
      'email': email,
    });
  }

  // Function to handle Google Sign-In
  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        // Handle user creation in Firestore or other database here
        // For example:
        // FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        //   'name': googleUser.displayName,
        //   'email': googleUser.email,
        // });

        print('Signed in with Google: ${userCredential.user!.displayName}');

        // Navigate to OTP page after successful sign-in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GenreSelectionPage(),
          ),
        );
      }
    } catch (e) {
      print('Google Sign-In error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/startpage/Arrow.png', // Update with correct path
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Sign up now',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please fill the details and create account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 157, 154, 154),
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _nameController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Enter your Name',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 157, 154, 154),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: TextFormField(
                controller: _emailController,
                onChanged: (_) => setState(() {}),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter your Email-ID',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 157, 154, 154),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              onChanged: (_) {
                _validatePassword();
                setState(() {});
              },
              obscureText: true,
              maxLength: 8,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.visibility_off),
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Enter your password',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 157, 154, 154),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                counterText: "",
              ),
            ),
            const SizedBox(height: 32),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _areFieldsFilled()
                        ? () async {
                            print('Sign Up button pressed');
                            bool isAuthenticated = await _authenticateUser();
                            print('Authentication status: $isAuthenticated');
                            if (isAuthenticated) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GenreSelectionPage(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Sign up failed. Please try again.'),
                                ),
                              );
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _areFieldsFilled()
                          ? const Color(0xFF0D6EFD)
                          : Color.fromARGB(255, 8, 36, 214),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
            const SizedBox(height: 16),
            // Google Sign-In Button
            OutlinedButton(
              onPressed: _isLoading ? null : _signInWithGoogle,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(color: Colors.grey),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Image(
                    image: AssetImage(
                        'assets/startpage/google_logo.png'), // Replace with your Google logo asset
                    height: 24.0,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
