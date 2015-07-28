% The shift factor is calculated using the Matpower built-in function for
% simplicity

%% (a) Calculate shift factor
mpc = case14;
H = makePTDF(100,mpc.bus,mpc.branch);

%% £¨b) Use the shift factor to calculate the DC line flow and determine the violated lines.
genBus = [1,2,3,6,8];
genOutput = [150,40,32,17,20];
lineLimit= [50,60,60,60,60,60,40,65,40,65,50,50,50,50,30,50,50,50,50,50];
lineFlow = zeros(1,20);
for i=1:20
    for j=1:5
        lineFlow(i) = lineFlow(i)+H(i,genBus(j))*genOutput(j);
    end
    for j=1:14
        lineFlow(i) = lineFlow(i)+H(i,j)*(-mpc.bus(j,3)); 
    end
end
violateArr = abs(lineFlow)-lineLimit;
violatePos = find(violateArr>0);