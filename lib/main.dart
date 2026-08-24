import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign-Up Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();


  bool _obscureText = true;


  String? _selectedRegion;
  String? _selectedGender;


  bool _agreedToTerms = false;


  double _age = 15.0;


  DateTime? _selectedDate;


  // Gesture state
  Color _buttonColor = Colors.blue;
  String _buttonText = 'Sign Up';


  final List<String> _regions = [
    'NCR (National Capital Region)',
    'CAR (Cordillera Administrative Region)',
    'Region I (Ilocos Region)',
    'Region II (Cagayan Valley)',
    'Region III (Central Luzon)',
    'Region IV-A (CALABARZON)',
    'MIMAROPA Region',
    'Region V (Bicol Region)',
    'Region VI (Western Visayas)',
    'Region VII (Central Visayas)',
    'Region VIII (Eastern Visayas)',
    'Region IX (Zamboanga Peninsula)',
    'Region X (Northern Mindanao)',
    'Region XI (Davao Region)',
    'Region XII (SOCCSKSARGEN)',
    'Region XIII (Caraga)',
    'BARMM (Bangsamoro Autonomous Region in Muslim Mindanao)',
  ];


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );


    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }


  // Single Tap
  void _singleTap() {
    setState(() {
      _buttonColor = Colors.green;
      _buttonText = '👆 Single Tap Detected!';
    });
  }


  // Double Tap
  void _doubleTap() {
    setState(() {
      _buttonColor = Colors.orange;
      _buttonText = '👏 Double Tap Detected!';
    });
  }


  // Long Press
  void _longPress() {
    setState(() {
      _buttonColor = Colors.red;
      _buttonText = '✋ Long Press Detected!';
    });
  }


  void _submitForm() {
    // Validate all TextFormFields and Dropdown
    if (!_formKey.currentState!.validate()) {
      return;
    }


    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your Date of Birth.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }


    // Validate Gender
    if (_selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your gender.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }


    // Validate Terms and Conditions
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please agree to the Terms & Conditions before signing up.',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }


    // Everything is valid
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sign-Up successful!'),
        backgroundColor: Colors.green,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.lightBlue.shade200,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Sign-Up Form',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                    const SizedBox(height: 24),


                    // FULL NAME
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your full name.';
                        }


                        if (value.trim().length < 2) {
                          return 'Full name must be at least 2 characters.';
                        }


                        return null;
                      },
                    ),


                    const SizedBox(height: 16),


                    // EMAIL
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email address.';
                        }


                        final emailRegex = RegExp(
                          r'^[\w\.-]+@[\w\.-]+\.\w+$',
                        );


                        if (!emailRegex.hasMatch(value.trim())) {
                          return 'Please enter a valid email address.';
                        }


                        return null;
                      },
                    ),


                    const SizedBox(height: 16),


                    // PASSWORD
                    TextFormField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password.';
                        }


                        if (value.length < 6) {
                          return 'Password must be at least 6 characters.';
                        }


                        return null;
                      },
                    ),


                    const SizedBox(height: 20),


                    // AGE SLIDER
                    Text(
                      'Age: ${_age.toInt()}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),


                    Slider(
                      value: _age,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: _age.toInt().toString(),
                      onChanged: (double newValue) {
                        setState(() {
                          _age = newValue;
                        });
                      },
                    ),


                    const SizedBox(height: 12),


                    // DATE OF BIRTH
                    InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Date of Birth',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: InkWell(
                        onTap: () => _selectDate(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            _selectedDate == null
                                ? 'Select date'
                                : '${_selectedDate!.month.toString().padLeft(2, '0')}/'
                                    '${_selectedDate!.day.toString().padLeft(2, '0')}/'
                                    '${_selectedDate!.year}',
                            style: TextStyle(
                              color: _selectedDate == null
                                  ? Colors.grey.shade600
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),


                    // Show DOB error message
                    if (_selectedDate == null)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                          top: 6,
                        ),
                        child: Text(
                          'Date of Birth is required.',
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 12,
                          ),
                        ),
                      ),


                    const SizedBox(height: 16),


                    // REGION
                    DropdownButtonFormField<String>(
                      value: _selectedRegion,
                      decoration: const InputDecoration(
                        labelText: 'Region',
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text('Select Region'),
                      items: _regions.map((String region) {
                        return DropdownMenuItem<String>(
                          value: region,
                          child: Text(
                            region,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRegion = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a region.';
                        }
                        return null;
                      },
                    ),


                    const SizedBox(height: 20),


                    // GENDER
                    const Text(
                      'Gender',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                    RadioListTile<String>(
                      title: const Text('Male'),
                      value: 'Male',
                      groupValue: _selectedGender,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),


                    RadioListTile<String>(
                      title: const Text('Female'),
                      value: 'Female',
                      groupValue: _selectedGender,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),


                    if (_selectedGender == null)
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          'Please select your gender.',
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 12,
                          ),
                        ),
                      ),


                    const SizedBox(height: 12),


                    // TERMS AND CONDITIONS
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _agreedToTerms,
                          onChanged: (bool? newValue) {
                            setState(() {
                              _agreedToTerms = newValue ?? false;
                            });
                          },
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Text(
                              'I agree to the Terms & Conditions',
                            ),
                          ),
                        ),
                      ],
                    ),


                    if (!_agreedToTerms)
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          'You must agree to the Terms & Conditions.',
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 12,
                          ),
                        ),
                      ),


                    const SizedBox(height: 20),


                    // SIGN-UP BUTTON WITH GESTURES
                    GestureDetector(
                      onTap: _singleTap,
                      onDoubleTap: _doubleTap,
                      onLongPress: _longPress,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: _buttonColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _buttonText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),


                    const SizedBox(height: 12),


                    // ACTUAL FORM SUBMIT BUTTON
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                      child: const Text(
                        'SUBMIT FORM',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



