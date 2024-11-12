% 从 Excel 文件中导入数据
filename = 'Q1_300.xlsx'; % 文件名
data = readmatrix(filename); % 读取数据
theta = data(:, 1); % 第一列数据：角度 (单位: 弧度)
rho = data(:, 2); % 第二列数据：极径 (单位: 米)

% 将极坐标转换为直角坐标
[x, y] = pol2cart(theta, rho);

% 阿基米德螺线参数
p = 55 / 100; % 螺距 (单位: 米)
numTurns = 16; % 总圈数
thetaMax = 2 * pi * numTurns; % 最大角度 (单位: 弧度)
b = p / (2 * pi); % 螺线常数

% 生成阿基米德螺线的角度数据
theta_spiral = linspace(0, thetaMax, 1000); % 生成角度数据

% 计算阿基米德螺线的极坐标
r_spiral = b * theta_spiral; % 极坐标半径

% 将阿基米德螺线的极坐标转换为直角坐标
[x_spiral, y_spiral] = pol2cart(theta_spiral, r_spiral);

% 创建一个新的图形窗口
figure;

% 绘制阿基米德螺线
plot(x_spiral, y_spiral, "Color",[0.30,0.75,0.93],'LineWidth', 1.5); % 绘制螺线
hold on; % 保持图形

% 绘制直角坐标系中的散点图
scatter(x, y, 'filled'); % 绘制散点图

% 绘制相邻点之间的黄线条
for i = 1:length(x)-1
    plot([x(i) x(i+1)], [y(i) y(i+1)], "Color","#ffc75f", 'LineWidth', 1.5); % 绘制连线
end



% 如果需要连接最后一个点和第一个点，取消下行注释
% plot([x(end) x(1)], [y(end) y(1)], 'y-', 'LineWidth', 1.5); % 绘制闭合线

% 设置图形属性
%title('直角坐标系中的散点图与阿基米德螺线');
%xlabel('X 轴 (米)');
%ylabel('Y 轴 (米)');
%grid on;
a=13;
xlim([-a,a]);
ylim([-a,a]);
axis equal; % 确保坐标轴比例相同
%hold off; % 关闭图形保持
