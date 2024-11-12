function rt = get_C(r_i1, theta_i1, beta_i)
    l_c = sqrt(0.275^2 + 0.15^2);
    theta_b = atan(6/11);
    rt(1) = r_i1*cos(theta_i1) + l_c*cos(theta_i1 + beta_i + theta_b);
    rt(2) = r_i1*sin(theta_i1) + l_c*sin(theta_i1 + beta_i + theta_b);
end