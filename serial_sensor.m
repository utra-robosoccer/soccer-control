%% Setup the Serial Port
s = serial('/dev/ttyACM0', 'baudrate', 115200);
s.InputBufferSize = 1000;
s.Timeout = 1000;
fopen(s);
bit_width = 16;
frac_width  = 14;


%% Acquire and display live data

figure
h = animatedline;
ax = gca;
ax.YGrid = 'on';
ax.YLim = [-2 2];
% ax.YLim = [-40000 40000];
% fwrite(s, 31, 'uint8');
% startTime = datetime('now');
% for	i=1:100
%     data = fread(s, 1, 'uint8');
%     if data ~= 0
%        break 
%     end
% end
i = 0;
startTime = datetime('now');
while 1
    % Read current voltage value
    data = fread(s, 1, 'int16');
    v = sfi(data);
    hex(v);
    % Get current time
    t =  datetime('now') - startTime;
    % Add points to animation
    % addpoints(h,datenum(t),1)
    % num = double(sfi(0,'WordLength',bit_width,'FractionLength',frac_width, 'hex', hex(v)));
    % addpoints(h,i, data / 20000)
    addpoints(h,datenum(t), data / 10000)
    % addpoints(h,i,num)
    i = i+1;
    % Update axes
    ax.XLim = datenum([t-seconds(10) t]); % [i-400 i+100]; 
    % ax.XLim = [i-400 i+100]; 
    datetick('x','keeplimits')
    drawnow
    % Check stop condition
    % stop = readDigitalPin(a,'D12');
    % pause(0.1);
    % fwrite(s, [10], 'uint8');
end
% fwrite(s, [20], 'uint8');
%%
fclose(s);