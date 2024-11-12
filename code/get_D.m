function rt = get_D(r_i, theta_i, alpha_i)
    l_c = sqrt(0.275^2 + 0.15^2);
    theta_b = atan(6/11);
    rt(1) = r_i*cos(theta_i) + l_c*cos(theta_i - alpha_i - theta_b);
    rt(2) = r_i*sin(theta_i) + l_c*sin(theta_i - alpha_i - theta_b);
end