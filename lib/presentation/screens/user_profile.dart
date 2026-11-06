import 'package:flutter/material.dart';
import 'package:habix/presentation/screens/widgets/custom_button.dart';
import 'package:habix/presentation/screens/widgets/name_text_box.dart';
import 'package:habix/presentation/screens/widgets/selectable_box.dart';
import 'package:habix/utilities/icon_paths.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class UserProfile extends StatelessWidget {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Wrap(
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            child: CustomButton(onButtonTapped: (){}, buttonText: 'Set Profile', isLoading: false)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                child: Image.asset(profileIcon,
                ),
              ),
              SizedBox(height: 10,),
              Text('Tell us about yourself',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 10,),
              NameTextField(
                controller: _firstNameController,
                labelText: 'First Name',
              ),
              SizedBox(height: 10),
              NameTextField(
                controller: _lastNameController,
                labelText: 'Last Name',
              ),
              
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 
                    130,
                    child: Text('Date of Birth: ')),
                  Expanded(
                    child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: ScrollDatePicker(
                              selectedDate: DateTime.now(),
                              locale: Locale('en'),
                              onDateTimeChanged: (DateTime value) {},
                            ),
                          ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 
                    130,child: Text('Gender: ')),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 5),
                      child: SelectableBox(
                        onOptionSelected: () {},
                        option: Text('Male'),
                        selectedColor: Colors.blue,
                        isSelected: true,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SelectableBox(
                      onOptionSelected: () {},
                      option: Text('Female'),
                      selectedColor: Colors.pinkAccent,
                      isSelected: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                      width: 130,
                      child: Text('Weight: '),
                      ),
                    Expanded(
                      child: TextField(
                      
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      
                      suffixText: 'kg',
                      ),
                      keyboardType: TextInputType.number,
                      
                    )),
                    RadioMenuButton(value: 'kgs', groupValue: 'kgs', onChanged: (q){}, child: Text('kgs')),
                    RadioMenuButton(value: 'lbs', groupValue: 'kgs', onChanged: (q){}, child: Text('lbs')),
          ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                      width: 130,
                      child: Text('Height: '),
                      ),
                    Expanded(
                      child: TextField(
                      
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      
                      suffixText: 'inch',
                      ),
                      keyboardType: TextInputType.number,
                      
                    )),
                    RadioMenuButton(
                      
                      value: 'inch', groupValue: 'cm', onChanged: (q){}, child: Text('inch')),
                    RadioMenuButton(value: 'cm', groupValue: 'cm', onChanged: (q){}, child: Text('cm')),
          ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
