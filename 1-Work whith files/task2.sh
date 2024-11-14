#!/bin/bash

mkdir task_2
cd task_2
pwd

# 4) Создать файл с содержимым не используя текстовые редактор
echo "Soderjimoe." > file1

# 3) Вывести содержание файла не используя текстовые редакторы.
file1 > 1

cd ..
rm -rf task_2
