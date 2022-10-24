%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              LABORATORY #6 
%%%              COMPUTER VISION 2021-2022
%%%              NON-RIGID STRUCTURE FROM MOTION - OPTIMIZATION 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function [J]=JacobianPattern(K,n_frames,n_points,vij,priors)
% Input
% K: shape basis rank
% n_frames: number of frames 
% n_points: number of points 
% vij: visibility map
% - priors: structure with fields:
%         priors.camera_prior: boolean, 1 for rotation smoothness on, 0 off
%         priors.coeff_prior: boolean, 1 for deformation smoothness on, 0 off 
% Output
% J: the Jacobian matrix pattern
 

 
% J data term is shorter than 2xFxP if the FxP visibility contains zeros
prior_terms = priors.coeff_prior + priors.camera_prior;


% Prior_terms must be a number from 0 to 2
if prior_terms < 0 || prior_terms > 2
    error('wrong values in prior options');
end

% Jacobian matrix pattern definition
% I give you the size, but you need to define the "ones
J = sparse(2*nnz(vij)+ prior_terms*(n_frames-1),(K+6)*n_frames + K*3*n_points);

     for i=1:n_frames
         for j = (2 *n_points*(i-1))+1 : i* 2 *n_points
             for l = ((K + 6)*(i-1)) +1 : (K + 6)*i
                J(j,l) = 1;
             end
         end
     end
     offset = 0;
     shape_basis=sparse(n_points, 3 *n_points*K); 
     for i=1:n_points 
         for j=0:K-1
             for l = 1:3
             shape_basis(i,offset + j* 3*n_points +l) = 1;
             end
         end
         offset = offset + 3; 
     end

     for i=0:2*(n_frames-1) + 1
         J(i*n_points+1:i*n_points+n_points, (K + 6)*n_frames+1:(K + 6)*n_frames+3* K *n_points)=shape_basis;
     end
    
 if (priors.coeff_prior == 1)
     % prior terms on L
     l_priors = sparse((n_frames-1)*2,(K + 6) * n_frames + 3 * K * n_points);
     for i=1:n_frames-1
        l_priors((i-1)*K + 1, (i - 1)* (6+K) + 1: (i - 1)* (6+K) + 2) = 1;
        l_priors((i-1)*K + 1, i* (6+K) + 1: i* (6+K) + 2) = 1;
     end
 end
 
 if (priors.camera_prior == 1)
     % prior terms on rotations
     c_priors = sparse((n_frames-1)*2,(K + 6) * n_frames + 3 * K * n_points);
     for i=1:n_frames-1
        c_priors((i-1)*K + 1,(i - 1)* (6+K) + 1 + K:(i - 1)* (6+K) + 1 + K + 6) = 1;
        c_priors((i-1)*K + 1, i* (6+K) + 1 + K:i* (6+K) + 1 + K + 6) = 1;
     end
     J = cat(1,J,l_priors, c_priors);
 end
 
 

% % You can see easily the Jacobian pattern using the command spy(J)
 %disp('Observe the Jacobian pattern...')
 %spy(J)

disp('Observe the Jacobian pattern...')
spy(J)
