function dataProcessorGUI
    % 创建主窗口
    fig = figure('Name', '数据筛选与排版', 'Position', [500, 300, 600, 400]);

    % 创建输入框标签
    uicontrol('Style', 'text', 'Position', [20, 350, 100, 20], 'String', '输入数据:');
    
    % 创建输入框
    inputTextBox = uicontrol('Style', 'edit', 'Max', 10, 'Min', 1, ...
        'Position', [20, 180, 560, 160], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', 'white');

    % 创建处理按钮
    uicontrol('Style', 'pushbutton', 'String', '处理数据', ...
        'Position', [250, 150, 100, 30], 'Callback', @processData);

    % 创建输出框标签
    uicontrol('Style', 'text', 'Position', [20, 120, 100, 20], 'String', '输出数据:');

    % 创建输出框
    outputTextBox = uicontrol('Style', 'edit', 'Max', 10, 'Min', 1, ...
        'Position', [20, 20, 560, 100], 'HorizontalAlignment', 'left', ...
        'BackgroundColor', 'white');

    % 数据处理函数
    function processData(~, ~)
        % 获取输入框中的数据
        inputData = get(inputTextBox, 'String');
        
        % 如果输入数据是字符串（单行输入）
        if ischar(inputData)
            inputData = cellstr(inputData);  % 转换为单元数组
        end
        
        % 处理数据
        processedData = processDataFunction(inputData);
        
        % 将处理结果显示在输出框中
        set(outputTextBox, 'String', processedData);
    end

    % 数据处理功能
    function formatted_output = processDataFunction(data)
        % 初始化存储结果的单元数组
        processed_data = cell(size(data));
        
        % 删除序号和数值部分，只保留数据名称
        for i = 1:length(data)
            % 按空格分割字符串
            parts = strsplit(data{i}, ' ');
            % 删除序号和最后的数值部分
            name = strjoin(parts(2:end-1), ' ');
            % 去掉多余的空格
            name = strtrim(name);
            processed_data{i} = name;
        end
        
        % 格式化每五个数据为一行，使用三个空格连接
        formatted_output = '';
        for i = 1:length(processed_data)
            if mod(i, 5) == 1 && i ~= 1
                formatted_output = sprintf('%s\n', formatted_output); % 换行
            end
            formatted_output = sprintf('%s%s   ', formatted_output, processed_data{i});
        end
        
        % 去掉最后多余的空格
        formatted_output = strtrim(formatted_output);
    end
end
