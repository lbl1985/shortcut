function TAR = transfer_type(TAR, REF)

% Transfer TAR into type of REF
% version: 1.0.    Binlong Li
% TIME STAMP: 12:00 25 Dec 2009

type = class(REF);
eval(['TAR = ' type '(TAR);']);