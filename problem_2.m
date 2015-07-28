%% At normal operating conditition
mpc = case5;
genBus = [1,1,3,4,5];
lineLimit = [1000,1000,1000,1000,240,1000];
HCase5 = makePTDF(100,mpc.bus,mpc.branch);
f = mpc.gencost(:,5)';
A = HCase5(:,genBus);
A = [A;-A];
b = HCase5*mpc.bus(:,3);
b = [b;-b];
b = b+[lineLimit';lineLimit'];
Aeq = [1,1,1,1,1];
beq = sum(mpc.bus(:,3));
lb = mpc.gen(:,10);
ub = mpc.gen(:,9);
x0 = mpc.gen(:,2);

% Start with the default options
options = optimoptions('linprog');
% Modify options setting
options = optimoptions(options,'Display', 'off');
options = optimoptions(options,'Algorithm', 'interior-point');
[x,fval,exitflag,output,lambda] = ...
linprog(f,A,b,Aeq,beq,lb,ub,x0,options);

%% At contingency operating conditition
mpc = case5;
mpc.branch(3,11) = 0;
genBus = [1,1,3,4,5];
lineLimit = [1000,1000,1000,1000,240,1000];
HCase5 = makePTDF(100,mpc.bus,mpc.branch);
f = mpc.gencost(:,5)';
A = HCase5(:,genBus);
A = [A;-A];
b = HCase5*mpc.bus(:,3);
b = [b;-b];
b = b+[lineLimit';lineLimit'];
Aeq = [1,1,1,1,1];
beq = sum(mpc.bus(:,3));
lb = mpc.gen(:,10);
ub = mpc.gen(:,9);
x0 = mpc.gen(:,2);

% Start with the default options
options = optimoptions('linprog');
% Modify options setting
options = optimoptions(options,'Display', 'off');
options = optimoptions(options,'Algorithm', 'interior-point');
[x,fval,exitflag,output,lambda] = ...
linprog(f,A,b,Aeq,beq,lb,ub,x0,options);