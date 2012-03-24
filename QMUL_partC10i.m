function [ details centre averageColour] = QMUL_partC10i( thisFrame, backgroundFrame )
    %
    %QMUL_part10    mini Feature Extraction
    %Extracts the features of video
    %This is a subfunction of QMUL_partC10
    %
    % [details centre averageColour] = QMUL_partC10i(vidFrames, frame)
    %
    % INPUT
    % vidFrames - Frames of the video
    %
    % OUTPUT
    % details - An m by 2 matrix of Height and Width of m objects
    % centre - An m by 2 matrix of the centres of m objects
    % averageColour - An m by 3 matrix of the average of each colour
    %                 channel of m objects
    %
    % SOURCES NEEDED
    % QMUL_partA5.m , QMUL_thresholding.m and QMUL_FloodFill.m
  
  tic;
    %This is excatly same as QMUL_partB9, please check there for comments

      BWFrame = QMUL_thresholding(backgroundFrame, thisFrame);
      boundedFrame = thisFrame;
      originalFrame = thisFrame;

      %%
      %FloodFill the frame and get bounds

      [cars bounds highes lowes] = QMUL_FloodFill(BWFrame);
      
      [num amount xy] = size(bounds);

      %%
      %Variables to temporarily keep details we will write
      highs = ones(num,2);
      lows = ones(num,2);
      details = ones(num,4);
      centre = ones(num,2);
      averageColour = ones(num,3);

      %%
      %Get the highest and lowest numbers

      for i = 1: num
          highs(i,1) = bounds(i,1,1);
          highs(i,2) = bounds(i,1,2);
          lows(i,1) = bounds(i,1,1);
          lows(i,2) = bounds(i,1,2);
          for j=1:amount
              if bounds(i,j,1) == 0 || bounds(i,j,2) == 0
                  continue;
              end
              
              
              if lows(i,1) > bounds(i,j,1)
                  lows(i,1) = bounds(i,j,1);
              elseif highs(i,1) < bounds(i,j,1)
                  highs(i,1) = bounds(i,j,1);
              end
              
              if lows(i,2) > bounds(i,j,2)
                  lows(i,2) = bounds(i,j,2);
              elseif highs(i,2) < bounds(i,j,2)
                  highs(i,2) = bounds(i,j,2);
              end

              for k=1:3
                boundedFrame(bounds(i,j,1), bounds(i,j,2), k) = 0;
              end
          end
          
          %%
          %Find height, width and centre then write to excel buffer
          height = highs(i,1) - lows(i,1);
          width = highs(i,2) - lows(i,2);
          details(i,:) = [lows(i,1) lows(i,2) height width];
          centre(i,:) = [ceil(height/2) ceil(width/2)];

          %%
          %Find average of each colour channel within bounding box
          %then write to excel buffer
          xCoords = lows(i,1):highs(i,1);
          yCoords = lows(i,2):highs(i,2);
          for c=1:3
            averageColour(i,c) = mean2(originalFrame(xCoords,yCoords,c));
          end
        
      end

      

  %end
  toc
end


