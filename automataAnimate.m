% Animates the cellular automata results from colonizationAutomata and
% similar routines.

% open a new figure windows
figure

% plot the first generation of the automata, doing a few tricks to give
% squares with a "1" a value of "255" so they will show up as black
h=image(G(:,:,1)*255);

% change colors to black and white
colormap(flipud(gray))

% hold plots for further animations
hold on

% set labels and image width
xlabel('j')
ylabel('i')
xlim([0.5 gridSize+0.5])
ylim([0.5 gridSize+0.5])
title(['Time step 1'])

% wait so the user can see what happened
pause(0.1)

% Do some of the above operations in a loop, deleting the previous
% generation figure before drawing the new one
for i=2:numberOfGenerations
  delete(h)
  h=image(G(:,:,i)*255);
  pause(0.1)
  title(['Time step ',num2str(i)])
end