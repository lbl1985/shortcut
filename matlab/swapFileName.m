function swapFileName(str1, str2)
str = '!mv str1 temp_nots.m';
evil(str);
str = '!mv str2 str1';
evil(str);
str = '!mv temp_nots.m str2';
evil(str);
str = '!cp temp_nots.m';
evil(str);