#!/usr/bin/env python3

import os
import sys
import json
import yaml

new_file = {}  # переменная для передачи данных

# ищем аргументы
if len(sys.argv) > 1:
    arg1 = sys.argv[1]
else:
    exit('need one argument \'folder/file. *yaml *yml *json\'')

# разделяем аргумент на путь-файл и формат
filename, file_extension = os.path.splitext(arg1)

# начинаем работу с файлом
with open(arg1, 'r') as f:
    # проверяем что файл json
    if file_extension == '.json':

        # проверяем что он действительно json и выводим ошибки + синтаксические
        try:
            new_file = json.load(f)
        except ValueError as error:
            print(f'\n{error}\n')
            error_text = str(error)
            error_list = error_text.split()
            it = iter(error_list)
            for index in it:
                if index == 'line':
                    error_index_line = next(it)
                    break
            error_line = open(arg1).read().split('\n')[int(error_index_line) - 1]
            exit(error_line)

        # если все успешно записываем в новый файл
        with open(filename + '.yaml', 'w') as f:
            f.write(yaml.dump(new_file, explicit_start=True, explicit_end=True))
        print(f'\n{filename}.yaml successfully created')

    # проверяем что файл yaml
    elif file_extension == '.yaml' or file_extension == '.yml':

        # проверяем в начале и конце файл синтаксис
        start_line_yaml = open(arg1).read().split('\n')[0]
        index_end_of_line_yaml = sum(1 for line in open(arg1))
        end_line_yaml = open(arg1).read().split('\n')[index_end_of_line_yaml - 1]

        if start_line_yaml == '---' and end_line_yaml == '...':

            # проверяем что он действительно json и выводим ошибки + синтаксические
            try:
                new_file = yaml.safe_load(f)
            except yaml.YAMLError as error:
                if hasattr(error, 'problem_mark'):
                    mark = error.problem_mark
                    print('\nError parsing Yaml file at line %s, column %s.\n' %
                          (mark.line, mark.column + 1))
                    error_line = open(arg1).read().split('\n')[mark.line - 1]
                    exit(error_line)
                else:
                    exit('Something went wrong while parsing yaml file')

            # если все успешно записываем в новый файл
            with open(filename + '.json', 'w') as f:
                f.write(json.dumps(new_file, indent=2))
            print(f'\n{filename}.json successfully created')

        else:
            print('yaml file need start to \'---\' and end \'...\'')

    else:
        exit('argument not json or yaml file')
