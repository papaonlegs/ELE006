function [objects bounds highs lows] = QMUL_FloodFill( frame )
    %
    %QMUL_FloodFill    White object detection and filling
    % This is an efficient FloodFill algorithm implementation that
    % uses a Stack to keep track.
    %
    % [objects bounds highs lows] = QMUL_FloodFill(frame)
    %
    % INPUT
    % frame - BW frame to use
    %
    % OUTPUT
    % objects - The number of objects
    % bounds - The objects by m by xy matrix of the bounds of objects
    % highs - An objects by 2 matrix of highest xy coordinates
    % lows - An objects by 2 matrix of lowest xy coordinates
    %
    % SOURCES NEEDED
    % Happily none :D



    [rows cols] = size(frame);
    
    %%
    %Declare objects, stack and pointers variables
    objects = 0;
    qu1 = zeros(1,2);
    boundptr = 1;
    bounds = zeros(1,boundptr,2);
    highs = ones(2,2);
    lows = ones(1,2);
    
    tic;
    for x=1:rows
        for y=1:cols
            
            if frame(x,y) ~= 255
                continue;
            end
            
            %%
            % Initialize variables with first white pixel encountered
            objects = objects + 1;
            nextNumber = objects+1;
            ptr = 1;
            boundptr = 1;
            highs(objects,:) = [x y];
            lows(objects,:) = [x y];
            qu1(ptr,:) = [x y];



            while(ptr>0)
                xtemp = qu1(ptr,1);
                ytemp = qu1(ptr,2);
        
                %%
                %Do some cheking to make sure we can flood pixel

                if (xtemp<1) || (xtemp>cols) ||(ytemp<1) ||(ytemp>rows) || frame(xtemp, ytemp) == 0
                   ptr = ptr - 1;
                   continue;
                end


                ptr = ptr - 1;
  
                %%
                % FloodFill floodable pixel
                for y3=-1:1
                    for x3=-1:1
                        %%
                        % more checking so we don't go beyond our frame
                        if (xtemp+x3 > rows) || (ytemp+y3 > cols)||(xtemp+x3<1)||(ytemp+y3<1)
                          continue;
                        end
                        
                        %%
                        % Do 8-way flooding and rename current pixel with object number
                        if  frame(xtemp+x3, ytemp+y3) == 255 %(y3 == 0 || x3 == 0) &&
                            ptr = ptr + 1;
                            qu1(ptr,:) = [xtemp+x3 ytemp+y3];
                            frame(xtemp+x3, ytemp+y3) = nextNumber;

                        %%
                        % Check if we are at the boundaries then add to our bounds matrix
                        elseif frame(xtemp+x3, ytemp+y3) == 0
                            bounds(objects,boundptr,:) = [xtemp+x3 ytemp+y3];
                            boundptr = boundptr + 1;

                            %%
                            % Find highest and lowest xy then add to highs and lows matrices
                            if xtemp+x3 > highs(objects,1)
                              highs(objects,1) = xtemp+x3;
                            elseif xtemp+x3 < lows(objects,1)
                              lows(objects,1) = xtemp+x3;
                            end
                            if ytemp+y3 > highs(objects,2)
                              highs(objects,2) = ytemp+y3;
                            elseif ytemp+y3 < lows(objects,2)
                              lows(objects,2) = ytemp+y3;
                            end

                        end
                    end
                end 
            end
        end
    end
    
    %%
    %Get highest and lowest xy coordinates per object
    [ob bo] = size(bounds);
    truHigh = zeros(ob, 2);
    truLow = ones(ob, 2);
    
    for g=1:ob
        truHigh(g, 1) = bounds(g,1,1);
        truLow(g, 1) = bounds(g,1,2);
        truHigh(g, 2) = bounds(g,1,1);
        truLow(g, 2) = bounds(g,1,2);
        for h=1:bo
            
            if truHigh(g,1) > bounds(g,h,1) && (bounds(g,h,1) > 1)
                truHigh(g,1) = bounds(g,h,1);
            elseif truLow(g,1) < bounds(g,h,1)
                truLow(g,1) = bounds(g,h,1);
            end
            
            if truHigh(g,2) > bounds(g,h,2) && (bounds(g,h,2) > 2)
                truHigh(g,2) = bounds(g,h,2);
            elseif truLow(g,2) < bounds(g,h,2)
                truLow(g,2) = bounds(g,h,2);
            end
        end
    end
    
    
    toc


end

