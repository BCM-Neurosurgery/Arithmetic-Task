function stage_idx = stage_present(visual_opt, game_opt, curr_opt, path_opt, onlineNSP, ExpEnv)

    %% Present the option
    n_str = length(curr_opt.strs);
    present_on_t1 = GetSecs();
    
    for iN = 1: n_str
        % Organize the position information
        curr_pos = [game_opt.x_locs(curr_opt.pos_x_idx(iN)), ...
            game_opt.y_locs(curr_opt.pos_y_idx(iN))];

        % set photodiode duration
        stage_idx = 1; % current stage
        phd_duration =visual_opt.photoD_duration{stage_idx+1}(iN);

        % Present option
        present_on_t =  GetSecs();
        photoD_on = true; % photodiode on
        present_opt(visual_opt, game_opt, curr_opt.strs(iN), curr_pos, ...
            curr_opt.symbol(iN), photoD_on);
        % send number displayed comment here
        logMsg = sprintf('Trial %d Stimulus %d Appearance', path_opt.curr_trial, iN);
        switch ExpEnv
            case 'emu'     % If we set the EMU as the exprimental environment, get the EMU number
                try         for i=1:numel(onlineNSP); cbmex('comment', 16777060, 0, logMsg,'instance',onlineNSP(i)-1); end
                catch ME;   disp(ME);
                end
        end
        visual_opt=save_timing(visual_opt,present_on_t1,[num2str(iN) 'on']); % to check photodiode timing
        
        % photodiode off
        while GetSecs()-present_on_t < phd_duration
        end
        photoD_on = false; % photodiode off
        present_opt(visual_opt, game_opt, curr_opt.strs(iN), curr_pos, ...
            curr_opt.symbol(iN), photoD_on);
        visual_opt=save_timing(visual_opt,present_on_t1,[num2str(iN) 'phd_off']); % to check photodiode timing

        % Align time
        align_time(present_on_t, game_opt.stim_present, ...
            game_opt.t_resolution);
        visual_opt=save_timing(visual_opt,present_on_t1,[num2str(iN) 'off']); % to check photodiode timing
        
    end % for iN = 1: n_str

    % Stage update
    stage_idx = 2;
end

function visual_opt=save_timing(visual_opt,present_on_t1,name)
% to check photodiode timing
if visual_opt.verbose
    visual_opt.timing.present=[visual_opt.timing.present;...
        GetSecs()-present_on_t1];
    visual_opt.timing.present_name=[visual_opt.timing.present_name;...
        {name}];
    
    disp([name ': ' num2str(visual_opt.timing.present(end))]);
end

end