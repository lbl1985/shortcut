function z = selected(z, Index_tt)
if ~isempty(z)
    for i = 1 : length(z.signals)
        z.signals(i).values = z.signals(i).values([Index_tt], :);
    end
else
    z = z;
end
end