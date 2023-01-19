% colonizationAutomata lab exercise

% Check for the 'YOUR WORK HERE' comments to find where to add the
% necessary changes
%
% Cells with a 0 are unoccupied, cells with a 1 are occupied

clear
clc

% set pseudo-random generator seed
rand('seed',95); % set to 95 for initial exercise

% Setup parameters
gridSize = 10; % length of a grid edge
numberOfGenerations = 100;
d = 1; % timescale dilator
m = 0.05*d; % recolonization probability per each neighbour
e = 0.16*d; % extinction probability

% Setup position grid for quickly finding neighbours
[X,Y]=meshgrid(1:gridSize,1:gridSize);

% Setup and initially populate grid with zeros (unoccupied)
G=zeros(gridSize,gridSize,numberOfGenerations);

% Add an initial population - 5% chance each cell is occupied
for i=1:gridSize
  for j=1:gridSize
    p=rand(1);
    if p<=0.05 % 5% chance of occupation
      G(i,j,1)=1;
    end
  end
end

% run the simulation
for t=2:numberOfGenerations
  G(:,:,t)=G(:,:,t-1); % copy G to a new 3D position in the array
  
  % get a random number from the uniform distribution for each grid cell
  p=rand(gridSize,gridSize);
  
  % Process each grid point - check for extinction if occupied,
  % colonization if unoccupied
  for i=1:gridSize
    for j=1:gridSize
      % find neighbours
      Xp=X-j;
      Yp=Y-i;
      
	  % get a list of neighbours by finding all cells with a center
	  % point <2.1 units from the center of the focal cell
      n=find((Xp.^2+Yp.^2)<2.1);
      
      if G(i,j,t-1)==0 % unoccupied
        
        % number of occupied neighbours
        occ=sum(G(n+(t-2)*gridSize*gridSize));
        
        % check for colonization
        if p(i,j) < m*occ
          G(i,j,t)= 1;
        end
      else % G(i,j,t-1) occupied, check for extinction & apply it if appropriate
        if p(i,j) < e
          G(i,j,t)= 0;
        end
      end
    end
  end
end
% count the number of occupied cells in each timestep
for i=1:numberOfGenerations,
    NO(i,1)=sum(sum(G(:,:,i)));
end
% plot the result
figure;
plot(NO./gridSize^2,'b-')
ylim([0 1])
ylabel('proportion occupied')
xlabel('timestep')



