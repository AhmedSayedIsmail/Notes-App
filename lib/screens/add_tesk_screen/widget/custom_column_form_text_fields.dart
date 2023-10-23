import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_application/core/widgets/custom_text_form_field.dart';
import 'package:todo_application/routes/routes.dart';
import 'package:todo_application/core/components.dart';
import 'package:todo_application/core/constants.dart';
import 'package:todo_application/core/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';
import 'package:todo_application/core/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:todo_application/core/controllers/write_data_cubit/write_data_states.dart';
import 'package:todo_application/core/dummy_data.dart';
import 'package:todo_application/core/widgets/custom_round_button.dart';
import 'package:todo_application/core/styles/colors/colors_theme.dart';

class CustomColumnFormTextField extends StatelessWidget {
  final GlobalKey<FormState> formkey;
  const CustomColumnFormTextField({super.key, required this.formkey});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WriteDataCubit(),
      child: BlocConsumer<WriteDataCubit, WriteDataStates>(
        listener: (context, state) {
          if (state is AddTaskFauild) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is AddTaskSuccessfully) {
            ReadDataCubit.getCubit(context).readUserCategoies();
            ReadDataCubit.getCubit(context).readUserTasks();
            context.goBack();
          }
        },
        builder: (context, state) {
          return Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    customSizeBox(height: 25),
                    ///TaskTextFormField
                    CustomTextFormField(
                      textType: TextInputType.text,
                      labelText: "Title",
                      hintText: 'Enter title tesk',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Title is Empty";
                        }
                        return null;
                      },
                      maxTextLength: 20,
                      onChanged: (value) {
                        WriteDataCubit.getCubit(context)
                            .updateTitleTask(titleTask: value!);
                      },
                      defaultColor:
                          TodoCubit.getCubit(context).currentUser!.userGender ==
                                  Constants.kMale
                              ? ColorsTheme.blackColor
                              : ColorsTheme.womanHomeBackgroundColor,
                    ),
                    customSizeBox(height: 25),
                    ///NoteTextFormField
                    CustomTextFormField(
                      textType: TextInputType.text,
                      labelText: "Note",
                      hintText: 'Enter note tesk',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Note is Empty";
                        }
                        return null;
                      },
                      defaultColor:
                          TodoCubit.getCubit(context).currentUser!.userGender ==
                                  Constants.kMale
                              ? ColorsTheme.blackColor
                              : ColorsTheme.womanHomeBackgroundColor,
                      maxTextLength: 25,
                      onChanged: (value) {
                        WriteDataCubit.getCubit(context)
                            .updateNoteTask(noteTask: value!);
                      },
                    ),
                    customSizeBox(height: 25),
                    ///DateTextFormField
                    CustomTextFormField(
                      readOnly: true,
                      textType: TextInputType.datetime,
                      suffixIcon: _getTaskDate(context),
                      hintText:
                          WriteDataCubit.getCubit(context).dateTask.isEmpty
                              ? "Enter Date"
                              : WriteDataCubit.getCubit(context).dateTask,
                      defaultColor:
                          TodoCubit.getCubit(context).currentUser!.userGender ==
                                  Constants.kMale
                              ? ColorsTheme.blackColor
                              : ColorsTheme.womanHomeBackgroundColor,
                    ),
                    customSizeBox(height: 25),
                    //Categories DropDown Button
                    CustomTextFormField(
                      textType: TextInputType.text,
                      hintText:
                          WriteDataCubit.getCubit(context).categoryType.isEmpty
                              ? "Category Type"
                              : WriteDataCubit.getCubit(context).categoryType,
                      defaultColor:
                          TodoCubit.getCubit(context).currentUser!.userGender ==
                                  Constants.kMale
                              ? ColorsTheme.blackColor
                              : ColorsTheme.womanHomeBackgroundColor,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _categorydropDownButton(context),
                      ),
                    ),
                    customSizeBox(height: 25),
                    _rowClocks(context),
                    customSizeBox(height: 25),
                    _rowRepeatAndRemind(context),
                    customSizeBox(height: 25),
                    state is WriteLoadingState
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : CustomRoundButton(
                            text: 'Add Task',
                            onPress: () {
                              if (formkey.currentState!.validate()) {
                                WriteDataCubit.getCubit(context).addTask();
                              }
                            },
                            buttonColor: TodoCubit.getCubit(context)
                                        .currentUser!
                                        .userGender ==
                                    Constants.kMale
                                ? ColorsTheme.manFloatingblueColor
                                : ColorsTheme.womanFloatingpinkColor,
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding _rowRepeatAndRemind(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              readOnly: true,
              textType: TextInputType.number,
              hintText: WriteDataCubit.getCubit(context).remindTask == 0
                  ? "Remind"
                  : WriteDataCubit.getCubit(context).remindTask.toString(),
              defaultColor:
                  TodoCubit.getCubit(context).currentUser!.userGender ==
                          Constants.kMale
                      ? ColorsTheme.blackColor
                      : ColorsTheme.womanHomeBackgroundColor,
              suffixIcon: _getRemindList(context),
            ),
          ),
          customSizeBox(
            width: 10,
          ),
          Expanded(
              child: CustomTextFormField(
                  readOnly: true,
                  textType: TextInputType.text,
                  hintText: WriteDataCubit.getCubit(context).repeatTask.isEmpty
                      ? "Repeat"
                      : WriteDataCubit.getCubit(context).repeatTask,
                  defaultColor:
                      TodoCubit.getCubit(context).currentUser!.userGender ==
                              Constants.kMale
                          ? ColorsTheme.blackColor
                          : ColorsTheme.womanHomeBackgroundColor,
                  suffixIcon: _getReapetList(context))),
        ],
      ),
    );
  }

  Padding _rowClocks(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ///Start Time TextField
          Expanded(
              child: CustomTextFormField(
            textType: TextInputType.datetime,
            hintText: WriteDataCubit.getCubit(context).startTime.isEmpty
                ? "Start Time"
                : WriteDataCubit.getCubit(context).startTime,
            defaultColor: TodoCubit.getCubit(context).currentUser!.userGender ==
                    Constants.kMale
                ? ColorsTheme.blackColor
                : ColorsTheme.womanHomeBackgroundColor,
            suffixIcon: IconButton(
                onPressed: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((timeValue) {
                    if (timeValue != null) {
                      WriteDataCubit.getCubit(context).updateStartTimeTask(
                          startTime: timeValue.format(context).toString());
                    } else {
                      WriteDataCubit.getCubit(context).updateStartTimeTask(
                          startTime:
                              TimeOfDay.now().format(context).toString());
                    }
                  });
                },
                icon: Icon(
                  Icons.access_time_rounded,
                  color: TodoCubit.getCubit(context).currentUser!.userGender ==
                          Constants.kMale
                      ? ColorsTheme.blackColor
                      : ColorsTheme.womanHomeBackgroundColor,
                )),
          )),
          customSizeBox(width: 10),

          ///End Time TextField
          Expanded(
              child: CustomTextFormField(
                  textType: TextInputType.datetime,
                  hintText: WriteDataCubit.getCubit(context).endTime.isEmpty
                      ? "EndTime"
                      : WriteDataCubit.getCubit(context).endTime,
                  defaultColor:
                      TodoCubit.getCubit(context).currentUser!.userGender ==
                              Constants.kMale
                          ? ColorsTheme.blackColor
                          : ColorsTheme.womanHomeBackgroundColor,
                  suffixIcon: IconButton(
                      onPressed: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                              hour: int.parse("9:30".split(":")[0]),
                              minute: int.parse(
                                  "9:30".split(":")[1].split(" ")[0])),
                        ).then((timeValue) {
                          if (timeValue != null) {
                            WriteDataCubit.getCubit(context)
                                .updatUpdateEndTimeTask(
                                    endTime:
                                        timeValue.format(context).toString());
                          } else {
                            WriteDataCubit.getCubit(context)
                                .updatUpdateEndTimeTask(
                                    endTime: TimeOfDay.now()
                                        .format(context)
                                        .toString());
                          }
                        });
                      },
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: TodoCubit.getCubit(context)
                                    .currentUser!
                                    .userGender ==
                                Constants.kMale
                            ? ColorsTheme.blackColor
                            : ColorsTheme.womanHomeBackgroundColor,
                      )))),
        ],
      ),
    );
  }

  DropdownButton<String> _getRemindList(BuildContext context) {
    return DropdownButton(
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: TodoCubit.getCubit(context).currentUser!.userGender ==
                Constants.kMale
            ? ColorsTheme.blackColor
            : ColorsTheme.womanHomeBackgroundColor,
      ),
      style: TodoCubit.getCubit(context).currentUser!.userGender ==
              Constants.kMale
          ? const TextStyle(color: ColorsTheme.blackColor, fontSize: 16)
          : const TextStyle(color: ColorsTheme.blueWhiteColor, fontSize: 16),
      dropdownColor:
          TodoCubit.getCubit(context).currentUser!.userGender == Constants.kMale
              ? ColorsTheme.manHomeBackgroundColor
              : ColorsTheme.womanHomeBackgroundColor,
      items: DummyData.remindList.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem(
            value: value.toString(), child: Text(value.toString()));
      }).toList(),
      underline: const SizedBox(),
      onChanged: (value) {
        WriteDataCubit.getCubit(context)
            .updatUpdateRemindTask(remindTask: int.parse(value!));
      },
    );
  }

  Padding _getReapetList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: DropdownButton(
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: TodoCubit.getCubit(context).currentUser!.userGender ==
                  Constants.kMale
              ? ColorsTheme.blackColor
              : ColorsTheme.womanHomeBackgroundColor,
        ),
        style: TodoCubit.getCubit(context).currentUser!.userGender ==
                Constants.kMale
            ? const TextStyle(color: ColorsTheme.blackColor, fontSize: 16)
            : const TextStyle(color: ColorsTheme.blueWhiteColor, fontSize: 16),
        dropdownColor: TodoCubit.getCubit(context).currentUser!.userGender ==
                Constants.kMale
            ? ColorsTheme.manHomeBackgroundColor
            : ColorsTheme.womanHomeBackgroundColor,
        items: DummyData.repeatList.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem(
              value: value.toString(), child: Text(value.toString()));
        }).toList(),
        underline: const SizedBox(),
        onChanged: (value) {
          WriteDataCubit.getCubit(context)
              .updatUpdateRepeatTask(repeatTask: value!);
        },
      ),
    );
  }

  IconButton _getTaskDate(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2050),
            helpText: 'Choose your Date',
            confirmText: "Choose Now",
            cancelText: 'Later',
          ).then((value) {
            if (value != null) {
              WriteDataCubit.getCubit(context).updateDateTask(dateTask: value);
            } else {
              if (WriteDataCubit.getCubit(context).dateTask.isEmpty) {
                WriteDataCubit.getCubit(context)
                    .updateDateTask(dateTask: DateTime.now());
              }
            }
          });
        },
        icon: Icon(
          Icons.calendar_today_outlined,
          color: TodoCubit.getCubit(context).currentUser!.userGender ==
                  Constants.kMale
              ? ColorsTheme.blackColor
              : ColorsTheme.womanHomeBackgroundColor,
        ));
  }

  DropdownButton<String> _categorydropDownButton(BuildContext context) {
    return DropdownButton(
        icon: Icon(
          Icons.keyboard_arrow_down_sharp,
          size: 30,
          color: TodoCubit.getCubit(context).currentUser!.userGender ==
                  Constants.kMale
              ? ColorsTheme.blackColor
              : ColorsTheme.womanHomeBackgroundColor,
        ),
        style: TodoCubit.getCubit(context).currentUser!.userGender ==
                Constants.kMale
            ? const TextStyle(color: ColorsTheme.blackColor, fontSize: 16)
            : const TextStyle(color: ColorsTheme.blueWhiteColor, fontSize: 16),
        dropdownColor: TodoCubit.getCubit(context).currentUser!.userGender ==
                Constants.kMale
            ? ColorsTheme.manHomeBackgroundColor
            : ColorsTheme.womanHomeBackgroundColor,
        underline: const SizedBox(),
        items: ReadDataCubit.getCubit(context)
            .categoriesList
            .map<DropdownMenuItem<String>>((categoryItem) {
          return DropdownMenuItem(
              value: categoryItem.categoryid
                  .toString(), //This to approve that user choose category
              child: Row(
                children: [
                  SvgPicture.asset(
                    categoryItem.categoryimage,
                    width: 30,
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      categoryItem.categorytype,
                    ),
                  )
                ],
              ));
        }).toList(),
        onChanged: (newValue) {
          WriteDataCubit.getCubit(context).updatUpdateCategoryTask(
              categoryId: int.parse(newValue!),
              allCategories: ReadDataCubit.getCubit(context).categoriesList,
              allUserCategories:
                  ReadDataCubit.getCubit(context).userCategoriesList);
        });
  }
}
