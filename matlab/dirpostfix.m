function dir = dirpostfix(dir)
if ispc
    dir = [dir '\'];
else
    dir = [dir '/'];
end