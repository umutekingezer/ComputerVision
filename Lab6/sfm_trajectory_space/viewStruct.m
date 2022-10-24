%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              LABORATORY #6 
%%%              COMPUTER VISION 2021-2022
%%%              NON-RIGID STRUCTURE FROM MOTION - OPTIMIZATION 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function viewStruct(S, Shat, a, b)

F = size(S,1)/3;
sm = mean(S,2);
S = S - sm*ones(1,size(S,2));

% Procrust Alignment
Y = findRotation(S, Shat);         
for i=1: F
    Shat(3*i-2:3*i,:) = Y*Shat(3*i-2:3*i,:);
end;

x1 = min(min(S(1:3:end, :)));
y1 = min(min(S(2:3:end, :)));
z1 = min(min(S(3:3:end, :)));
x2 = max(max(S(1:3:end, :)));
y2 = max(max(S(2:3:end, :)));
z2 = max(max(S(3:3:end, :)));

for i=1: F
    plot3(S(3*i-2, :), S(3*i-1, :), S(3*i, :), '.b');
    if exist('Shat')
        hold on
        plot3(Shat(3*i-2, :), Shat(3*i-1, :), Shat(3*i, :), 'og');
        hold off
    end
    axis vis3d equal
    axis([x1 x2 y1 y2 z1 z2])
    if exist('b')
        view(a, b);
    else
     view(39,29)
    end;
    title(['Frame number #' num2str(i)]);
    legend('3D Reconstruction','3D Ground truth','location','NorthEastOutside');
    xlabel('x');
    ylabel('y');
    zlabel('z');
    grid on
    pause(0.05)
end;