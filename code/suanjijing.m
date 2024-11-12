% 设置螺距
pitch = 0.55; % 螺距，单位为 cm

% Excel 文件名
input_filename = 'Q4_T.xlsx'; % 输入的 Excel 文件名
output_filename = 'Q4_R.xlsx'; % 输出的 Excel 文件名


% 读取极角数据
angles_table = readtable(input_filename); % 读取 Excel 文件中的表格数据

column_names = angles_table.Properties.VariableNames;
% 提取极角数据（假设列名为 'Angles'）
%angles_q = angles_table.Var1; % 替换为实际列名

%angles=rad2deg(angles_q);
% 计算对应的极径
%radii = pitch * (angles / 360);

radii_table = table(); % 创建一个空表格用于保存结果
for i = 1:length(column_names)
    % 提取当前列的极角数据
    angles = angles_table.(column_names{i});
    %angles=rad2deg(angles_q);
    % 计算对应的极径
    radii = pitch * (angles / (2*pi));
    
    % 将结果添加到结果表格中
    radii_table.(column_names{i}) = radii;
end


writetable(radii_table, output_filename);