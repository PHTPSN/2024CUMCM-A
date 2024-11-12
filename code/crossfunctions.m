function rt = crossfunctions(theta_0, theta, r_0, r, N, l_h, l)
    % 计算一系列判断碰撞的叉乘函数，结果为四个可能碰撞的点每个各一列检验值

    % 计算alpha_i, beta_i
    k_0 = l_h/sin(theta(1) - theta_0);
    k = l./sin(diff(theta));
    alpha_0 = asin(r(1)/k_0);
    beta_0 = asin(r_0/k_0);
    alpha = asin(r(2:end)./k);
    beta = asin(r(1:end-1)./k);

    % 计算各板凳四角坐标
    A_0 = get_A(r_0, theta_0, alpha_0);
    B_0 = get_B(r(1), theta(1), beta_0);
    A_1 = get_A(r(1), theta(1), alpha(1));
    B_1 = get_B(r(2), theta(2), beta(1));

    %A = zeros(N, 2);
    %B = zeros(N, 2);
    C_toA0 = zeros(N, 2);
    D_toA0 = zeros(N, 2);
    C_toB0 = zeros(N, 2);
    D_toB0 = zeros(N, 2);
    C_toA1 = zeros(N, 2);
    D_toA1 = zeros(N, 2);
    C_toB1 = zeros(N, 2);
    D_toB1 = zeros(N, 2);

       r_t = r;
       theta_t = theta;
    parfor i = 1:N
        C_ = get_C(r(i+1), theta(i+1), beta(i));
        D_ = get_D(r_t(i), theta_t(i), alpha(i));
        if theta(i) - theta_0 < pi || theta(i) - theta_0 > 3*pi
            C_toA0(i,:) = [NaN,NaN];
            D_toA0(i,:) = NaN;
        else
            C_toA0(i,:) = C_;
            D_toA0(i,:) = D_;
        end
        if theta(i) - theta(1) < pi || theta(i) - theta(1) > 3*pi
            C_toB0(i,:) = NaN;
            D_toB0(i,:) = NaN;
            C_toA1(i,:) = NaN;
            D_toA1(i,:) = NaN;
        else
            C_toB0(i,:) = C_;
            D_toB0(i,:) = D_;
            C_toA1(i,:) = C_;
            D_toA1(i,:) = D_;
        end
        if theta(i) - theta(2)< pi || theta(i) - theta(2) > 3*pi
   
            C_toB1(i,:) = NaN;
            D_toB1(i,:) = NaN;
        else
            C_toB1(i,:) = C_;
            D_toB1(i,:) = D_;
        end
    end
    %parfor i = 1:N
    %    A(i, :) = get_A(r(i), theta(i), alpha(i));
    %    B(i, :) = get_B(r(i+1), theta(i+1), beta(i));
    %    C(i, :) = get_C(r(i+1), theta(i+1), beta(i));
    %    D(i, :) = get_D(r(i), theta(i), alpha(i));
    %end
    
    % 叉乘函数族
    crossfun = @(A, B) A(:, 1).*B(:, 2) - A(:, 2).*B(:, 1);  % 叉乘函数
    % fX = @(X)(X-D, C-D); % \overrightarrow{D_iX}\times\overrightarrow{D_iC_i}，下同
    fX = @(X, C_, D_) crossfun(X-D_, C_-D_); % \overrightarrow{D_iX}\times\overrightarrow{D_iC_i}，下同
    fA0 = fX(A_0, C_toA0,D_toA0);
    fB0 = fX(B_0, C_toB0,D_toB0);
    fA1 = fX(A_1, C_toA1,D_toA1);
    fB1 = fX(B_1, C_toB1,D_toB1);
    rt = [fA0, fB0, fA1, fB1];
    % rt_ = ones(N,4);
    % for i =1:N
    %     if theta(i) - theta_0 < pi || theta(i) - theta_0 > 3*pi
    %         rt_(i,1) = NaN;
    %     else
    %         rt_(i,1) = fX(A_0(i,:));
    %     end
    %     if theta(i) - theta(1) < pi || theta(i) - theta(1) > 3*pi
    %         rt_(i,2) = NaN;
    %         rt_(i,3) = NaN;
    %     else 
    %         rt_(i,2) = fX(B_0(i,:));
    %         rt_(i,3) = fX(A_1(i,:));
    %     end
    %     if theta(i) - theta(2)< pi || theta(i) - theta(2) > 3*pi
    % 
    %         rt_(i,4) = NaN;
    %     else
    %         rt_(i,4) = fX(B_1(i,:));
    %     end
    % end
    % rt=rt_;
end
