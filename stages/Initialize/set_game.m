function game_opt = set_game(visual_opt)
	
    %% Current functions sets up task-variable values
    
    %% 1. Temporal information [sec]
    ITI_duration = 0.5;  % time of ITI
    stim_present = 0.75; % time for stim present for each opt
    feedback_duration = 0.5;
    %timeout = 20;	% time threshold without movement.
    %stairopt = 3;	% how many time-outs causes stair changes
    t_start_text = 2; % for start_session.m
    
    t_resolution = 1/1000;

    sess_trs = 300; % assuming 30min / (5sec/trial) = 360 trials
    
    %% 2. Task specific
    % operation
    oper_type = {'+', '-'}; % , 'x'
    num_oper = length(oper_type);
    
    % number
    min_num = 0;
    max_num = 10;
    max_min_ratio = max_num/(max([1 min_num]));
    num_samples = 2;
    len_samples = 2;
    
    stim_present_total = stim_present * (num_samples+1); % two number + operation
    
    % presentation (notation)
    pres_type = { 'prefix', 'postfix'}; % rev_pol=postfix     , 'infix'
    % pres_type = {'infix'}; % rev_pol=postfix     , 'infix'

    num_pres = length(pres_type);
    
    % format
    format = {'arabic'}; % ,'dot'
    num_format = length(format);
    
    % positions
    n_grid_x = 4; % horizontal
    n_grid_y = 3; % vertical
    % How many grid points for presentation. 
    n_grid = n_grid_x*n_grid_y; 

    %% 3. Presentation position
    pre_x_units = visual_opt.screenXpixels/(n_grid_x+2);
    pre_y_units = visual_opt.screenYpixels/(n_grid_y+2);
    
    field_size_pix = min([pre_x_units pre_y_units]);
        
    x_locs = pre_x_units/2  + pre_x_units*[1:n_grid_x]; % added buffer + centering
    y_locs = pre_y_units/2  + pre_y_units*[1:n_grid_y];
    
    feedback_offset = pre_x_units/2; % from center
    
    %% dot-related parameters [NOT USED 2024/8/5]
    % adapt to screen's pixel size (originally absolute values)
    screen_dot_ratio = 50; % 1000 pixels / 20 (pixel/dot)
    screen_field_ratio = 4; % 1000 pixels / 250 (pixel/field)
    
    radius_max = round(visual_opt.screenYpixels / screen_dot_ratio); % 20
    field_max = round(visual_opt.screenYpixels / screen_field_ratio); % 250
    
    radius_min = round(radius_max/sqrt(max_min_ratio));
    field_min = round(field_max/sqrt(max_min_ratio));
    
    radius_range = [radius_min radius_max]; %  [3 12]; % pixels
    field_range = [field_min field_max]; % [60 240]
    % from generate_dot.m
    % For a balanced design, the minimum and the maximum values of nlim, rdlim,
    %   and rflim should all the equivalent. To achieve this, because area as
    %   in individual area (IA) and field area (FA) is proportionate to the
    %   square of radius, if the range of n differs in 4 folds, the range of
    %   rd (radius of each dot) and rf (radius of the circular field in which
    %   the dots are drawn) should differ in 2 folds.
 
    %% feedback staircase [NOT USED 2024/8/5]
    correct_range_arabic = 0.5; % 1; % with 0.5, only exactly correct considered as correct
    up_error_arabic = 0; % 0.5;
    down_correct_arabic = 0; % 0.25;
    
    correct_range_dot = 5;
    up_error_dot = 2;
    down_correct_dot = 1;
    
    previous_id_correct = false;
    
   % to track performance
   n_correct_arabic = 0;
   n_correct_dot = 0;

   n_arabic = 0;
   n_dot = 0;
    
    %% make structure
    game_opt = v2struct;
end