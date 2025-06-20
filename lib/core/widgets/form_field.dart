import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustemTextFIeld extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool password;
  final bool readOnly;
  String? Function(String?)? validator;
  CustemTextFIeld({
    required this.label,
    required this.hintText,
    required this.controller,
    this.password = false,
    this.readOnly = false,
    this.validator,
  });

  @override
  State<CustemTextFIeld> createState() => _CustemTextFIeldState();
}

class _CustemTextFIeldState extends State<CustemTextFIeld> {
  late bool _obscureText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscureText = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        Text(widget.label, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        TextFormField(
          validator: widget.validator,
          readOnly: widget.readOnly,
          controller: widget.controller,
          obscureText: _obscureText,

          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            fillColor: const Color.fromARGB(255, 255, 253, 253),
            suffixIcon:
                widget.password
                    ? IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    )
                    : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: const Color.fromARGB(255, 229, 229, 229),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}

//

class CustemDateField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final DateTime startDate;
  final DateTime endDate;
  CustemDateField({
    required this.controller,
    required this.label,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        TextField(
          controller: controller,
          onTap: () async {
            DateTime? selectedtime = await showDatePicker(
              context: context,
              firstDate: startDate,
              lastDate: endDate,
            );
            if (selectedtime != null) {
              controller.text = selectedtime.timeZoneName.split("")[0];
            }
          },
        ),
      ],
    );
  }
}

class DatePickerFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final DateTime firstDate;
  final DateTime lastDate;
  String? Function(String?)? validator;

  DatePickerFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.firstDate,
    required this.lastDate,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        TextFormField(
          validator: validator,
          controller: controller,
          readOnly: true,
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 229, 229, 229),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 229, 229, 229),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
            suffixIcon: const Icon(
              Icons.calendar_today,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode()); // hide keyboard
            final pickedDate = await showDatePicker(
              context: context,

              firstDate: firstDate,
              lastDate: lastDate,
              builder: (context, child) {
                return Theme(
                  data: ThemeData(
                    primaryColor: Colors.black, // header background
                    colorScheme: const ColorScheme.dark(
                      primary: Colors.black, // selected date circle color
                      onPrimary: Colors.white, // selected date text color
                      surface: Colors.white, // calendar background
                      onSurface: Colors.black, // text color for days/month
                    ),
                    dialogTheme: DialogThemeData(backgroundColor: Colors.black),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedDate != null) {
              controller.text =
                  "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
            }
          },
        ),
      ],
    );
  }
}

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String? selectedCountryCode;
  final String hintText;
  final List<String> countryCodes = [
    '+1', // United States/Canada
    '+7', // Russia
    '+20', // Egypt
    '+27', // South Africa
    '+30', // Greece
    '+31', // Netherlands
    '+32', // Belgium
    '+33', // France
    '+34', // Spain
    '+36', // Hungary
    '+39', // Italy
    '+40', // Romania
    '+41', // Switzerland
    '+43', // Austria
    '+44', // United Kingdom
    '+45', // Denmark
    '+46', // Sweden
    '+47', // Norway
    '+48', // Poland
    '+49', // Germany
    '+51', // Peru
    '+52', // Mexico
    '+53', // Cuba
    '+54', // Argentina
    '+55', // Brazil
    '+56', // Chile
    '+57', // Colombia
    '+58', // Venezuela
    '+60', // Malaysia
    '+61', // Australia
    '+62', // Indonesia
    '+63', // Philippines
    '+64', // New Zealand
    '+65', // Singapore
    '+66', // Thailand
    '+81', // Japan
    '+82', // South Korea
    '+84', // Vietnam
    '+86', // China
    '+90', // Turkey
    '+91', // India
    '+92', // Pakistan
    '+93', // Afghanistan
    '+94', // Sri Lanka
    '+95', // Myanmar
    '+98', // Iran
    '+211', // South Sudan
    '+212', // Morocco
    '+213', // Algeria
    '+216', // Tunisia
    '+218', // Libya
    '+234', // Nigeria
    '+255', // Tanzania
    '+260', // Zambia
    '+263', // Zimbabwe
    '+971', // UAE
    '+972', // Israel
    '+973', // Bahrain
    '+974', // Qatar
    '+975', // Bhutan
    '+976', // Mongolia
    '+977', // Nepal
  ];

  final ValueChanged<String?> onCountryCodeChanged;
  final String label;

  String? Function(String?)? validator;
  PhoneNumberField({
    super.key,
    required this.controller,
    required this.selectedCountryCode,
    required this.label,
    required this.onCountryCodeChanged,
    required this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        Row(
          children: [
            DropdownButton<String>(
              value: selectedCountryCode,
              items:
                  countryCodes.map((code) {
                    return DropdownMenuItem(value: code, child: Text(code));
                  }).toList(),
              onChanged: onCountryCodeChanged,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 253, 253),
                  hintText: hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 229, 229, 229),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                validator: validator,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
