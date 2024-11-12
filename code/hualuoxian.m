% 参数设置
p = 55; % 螺距 (单位: cm)
numTurns = 16; % 总圈数
thetaMax = 2 * pi * numTurns; % 最大角度 (单位: 弧度)

% 计算螺线的常数
b = p / (2 * pi); % b 的值
a = 0; % 起始半径设为 0

% 生成角度数据
theta = linspace(0, thetaMax, 1000); % 生成角度数据

% 计算极坐标
r = a + b * theta; % 极坐标半径

% 将极坐标转换为直角坐标
[x, y] = pol2cart(theta, r);

% 创建一个新的图形窗口
figure;

% 绘制阿基米德螺线
plot(x, y, 'b-', 'LineWidth', 1.5); % 绘制螺线
title('阿基米德螺线 (螺距 55 cm, 16 圈)');
xlabel('X 轴 (cm)');
ylabel('Y 轴 (cm)');
axis equal; % 设置坐标轴比例相同
grid on;