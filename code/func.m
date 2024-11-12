syms r theta_0 d theta_temp v t_q1 theta

% 计算弧长距离对极角的函数和极角对时间的导数
r = d/(2*pi)*theta_temp
f = sqrt(r^2 + diff(r,1,theta_temp))
% L = int(f,theta_temp,0,theta)
L = d/(2*pi)*(0.5*theta*sqrt(1+theta^2)+0.5*log(theta+sqrt(1+theta^2)))
dLdtheta = diff(L,1,theta)
dthetadt = - v/ dLdtheta

L=simplify(L)
latex(L)
% 获得到中心弧线长度对极角的函数的函数对象从到中心弧线长度对极角的导数对极角的函数的函数对象

L_fun = matlabFunction(L,'Vars',[theta,d])
dLdtheta_func = matlabFunction(dLdtheta,'Vars', [theta,d])
% 不同点上间的距离
function dis = getdis(theta_i,theta_j,d)
    r_i = d/(2*pi)*theta_i;
    r_j = d/(2*pi)*theta_j;
    dis = sqrt(r_i^2+r_j^2-2*r_i*r_j*cos(theta_i-theta_j));
end

% 螺线上点从前一个点的极角推后一个点的极角
function theta_iplus1 = solveTheta(theta_i, l, d)
    % 定义符号变量
    syms theta_next
    
    % 定义方程
    eqn = theta_i^2 + theta_next^2 - 2*theta_i*theta_next*cos(theta_i - theta_next) == (4*pi^2*l^2)/d^2;
    
    % 设置求解范围
    range = [theta_i,theta_i+pi]; % 解的范围
    
    % 使用 vpasolve 在指定范围内求解方程
    theta_ip1_sol = vpasolve(eqn, theta_next, range);
    
    theta_iplus1 = double(theta_ip1_sol);
end

% 增加一个抽象层，
% 接受一个矩阵（纵向为不同时间下的前一个点的极角，
% 横向为不同的点，下标依次增大），返回值为矩阵后增加一列，也就是不同时间下下一个点
function theta_new=getNextPoint(theta,l,d,indexOflastPoint)
    theta_last = theta(:,indexOflastPoint);
    theta_new_last = zeros(size(theta_last));
    %parfor i = 1:length(theta_last)
    %    theta_new_last(i) = solveTheta(theta_last(i), l, d);
    %end
    %theta_new =[theta, theta_new_last];
        %theta_new_last = zeros(size(theta_last));
    %parfor i = 1:length(theta_last)
    %    theta_new_last(i) = solveTheta(theta_last(i), l, d);
    %end
    theta_new_ = theta;
    parfor i = 1:length(theta_last)
        theta_new_last(i) = solveTheta(theta_last(i), l, d);
    end
    theta_new_(:,indexOflastPoint+1) = theta_new_last;
    theta_new =theta_new_;
end
%theta_11 = arrayfun(@(theta) solveTheta(theta, 2.86, 0.55), theta_0_val_q1);
%dis =arrayfun(@(theta1,theta2) getdis(theta1,theta2,0.55),theta_0_val_q1,theta_11);

%theta_11 = addNextPoint(theta_11,2.86,0.55)

% 相邻点的极角，后者对前者的导数
syms theta_i theta_ip1 l d
F = theta_i^2 + theta_ip1^2 - 2*theta_i*theta_ip1*cos(theta_i - theta_ip1) - (4*pi^2*l^2)/d^2
dFdtheta_i = diff(F,theta_i)
dFdtheta_ip1 = diff(F,theta_ip1)
dtheta_ip1dtheta_i = - dFdtheta_i/dFdtheta_ip1
dtheta_ip1dtheta_i_func=matlabFunction(dtheta_ip1dtheta_i, 'Vars', [theta_i,theta_ip1])