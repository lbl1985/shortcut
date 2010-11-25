function tkf
% bdclose all
model = gcs;
s = ['open /' model '.mdl'];
eval(s)
disp(['StopTime is  : ' get_param(gcs, 'stopTime')])
disp(['SolverType is: ' get_param(gcs, 'SolverType')])
disp(['solver is    : ' get_param(gcs, 'solver')])
disp(['fixedStep is : ' get_param(gcs, 'fixedStep')])