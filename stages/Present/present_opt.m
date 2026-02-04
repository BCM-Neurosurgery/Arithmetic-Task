function present_opt(visual_opt, game_opt, curr_str, curr_pos, symbol, phd_on)
    
    %% 0. Set time and text
    num2disp = curr_str{1};
    
    %% 1. Draw and present
    if symbol
        Screen('TextSize', visual_opt.window, visual_opt.textSize);
        Screen('TextColor', visual_opt.window, visual_opt.white);
        Screen('TextStyle', visual_opt.window, visual_opt.textStyle);
        
        DrawFormattedText(visual_opt.window, num2disp, ...
            curr_pos(1), curr_pos(2), visual_opt.white);
    else % dot
        % get center of field
        field_center_x = curr_pos(1);
        field_center_y = curr_pos(2);

        % compute rect_matrix: note upper left is [0 0]
        rect_matrix=[field_center_x + curr_str{1}.x(:)'-curr_str{1}.r(:)';... % left 
            field_center_y + curr_str{1}.y(:)'-curr_str{1}.r(:)';... % top
            field_center_x + curr_str{1}.x(:)'+curr_str{1}.r(:)';... % right
            field_center_y + curr_str{1}.y(:)'+curr_str{1}.r(:)']; % bottom
        
        rect_matrix=round(rect_matrix); % rounding for pixels
        
        try,Screen('FillOval',visual_opt.window,visual_opt.white,rect_matrix);
        catch,keyboard; % for debug
        end
    end
    
    % photodiode
    if phd_on
        draw_photoD(visual_opt);
    end
    
    Screen('Flip', visual_opt.window);
% send comment here
end