w = date;
str2 = sprintf('evil_simsnapshot_settings.m.BAK.%s', w);
str3 = sprintf('!cp /mathworks/devel/sandbox/bli/Acgir/matlab/test/tools/sfeml/evil_simsnapshot_settings.m /mathworks/devel/sandbox/bli/backup/backup_snapshot/sfeml/%s', str2);
eval(str3)