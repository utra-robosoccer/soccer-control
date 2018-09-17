%function dh = getDhTable(robot)

if ~exist('robot', 'var')
    robot = importrobot('/Users/Daniel/soccer-matlab/soccer_description/models/soccerbot/model.xacro')
end

clear transformations
transformations = get_tf(robot, robot.Base.Children{1});
dh_table        = rmfield(transformations, {'tf', 'children', 'parent'})

% Display all transformations
for i = 1:length(transformations)
    disp(transformations(i).tf);
end


% Recursive function to get all transformation matrices
function  transformations = get_tf(robot, body)

% Get homogeneous transformation matrix
homeCfg                 = homeConfiguration(robot);
parentBodyName          = body.Parent.Name;
childrenBodyName        = body.Name;

transformations.tf      = robot.getTransform(homeCfg, parentBodyName, childrenBodyName);
transformations.children = childrenBodyName;
transformations.parent  = parentBodyName;

% Extract DH parameters
syms alpha_ theta_ a_
eqn1  = cosd(theta_) == transformations.tf(1,1);
eqn2  = -sind(theta_)*cosd(alpha_) == transformations.tf(1,2);
eqn3  = sind(theta_)*sind(alpha_) == transformations.tf(1,3);
%eqn4  = a_*cosd(theta_) == transformations.tf(1,4);
eqn5  = sind(theta_) == transformations.tf(2,1);
eqn6  = cosd(theta_)*cosd(alpha_) == transformations.tf(2,2);
eqn7  = -cosd(theta_)*sind(alpha_) == transformations.tf(2,3);
%eqn8  = a_*sind(theta_) == transformations.tf(2,4);
eqn9  = sind(alpha_) == transformations.tf(3,2);
eqn10  = cosd(alpha_) == transformations.tf(3,3);

 [sol_alpha, sol_theta] = ...
     solve([eqn1, eqn2,eqn3,eqn5,eqn6,eqn7,eqn9,eqn10])

% eul_angles = tform2eul(transformations.tf)
trans = tform2trvec(transformations.tf);



transformations.alpha   = double(sol_alpha);
transformations.theta   = double(sol_theta);
transformations.a       = norm(trans(1:2));
transformations.d       = transformations.tf(15); %trans(3)

% Recursion base case
if isempty(body.Children)
    return
end

for i = 1:length(body.Children)
    if isempty(transformations)
        transformations = get_tf(robot, body.Children{1,i});
    else
        transformations = [transformations; get_tf(robot, body.Children{1,i})];
    end
end

end


