function specificParams = parseResultFile(configFilePath)
    % Open the configuration file for reading
    configFile = fopen(configFilePath, 'r');
    
    % Initialize a structure to store specific parameters
    specificParams = struct();
    
    % Read the file line by line
    while ~feof(configFile)
        % Read the current line
        line = fgetl(configFile);
        
        % Skip empty lines
        if isempty(line)
            continue;
        end
        
        % Skip the line containing [ROI Statistics]
        if contains(line, '[ROI Statistics]')
            continue;
        end

        % Split the line into key and value
        [key, value] = strtok(line);
        
        % Remove leading/trailing whitespaces from key and value
        key = strtrim(key);
        value = strtrim(value);
        
        % Skip lines without key or value
        if isempty(key) || isempty(value)
            continue;
        end
        
        % Check if the key matches the specific parameters you want
        if strcmp(key, 'Core_0_L1D_prefetch_useful') || strcmp(key, 'Core_0_L1D_prefetch_useless') || strcmp(key, 'Core_0_L1I_prefetch_useful') || strcmp(key, 'Core_0_L1I_prefetch_useless') || strcmp(key, 'Core_0_L1D_load_miss') || strcmp(key, 'Core_0_IPC')  
            % Convert numerical values to numbers
            if ~isnan(str2double(value))
                value = str2double(value);
            end
            
            % Store the key-value pair in the structure
            specificParams.(key) = value;
        end
    end
    
    % Close the file
    fclose(configFile);
end
