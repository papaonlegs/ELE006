function [ newFrame ] = QMUL_thresholding( frameZero, frameRef )
    %
    %QMUL_thresholding    Efficient differencing and thresholding
    % This is an efficient differencing algorithm implementation that
    % uses a backgroundFrame to give more precise results.
    %
    % newFrame = QMUL_thresholding( backgroundFrame, frame )
    %
    % INPUT
    % newFrame - Differenced BW frame
    %
    % OUTPUT
    % backgroundFrame - The background Frame of video (can be gotten using QMUL_partA5)
    % frame - The frame you wish to difference
    %
    % SOURCES NEEDED
    % Happily none :D


  tic;
  %%
  % Convert to int16 for precision the absolute so we have no negatives
  diffFrame = abs(int16(rgb2gray(frameZero)) - int16(rgb2gray(frameRef)));
  
  %%
  %uint8 so we can threshold
  diffFrame = uint8(diffFrame);
  
  %%
  %optimal first threshold
  threshold = 0.1;

  %%
  %Threshold our frame
  diffFrame(diffFrame < threshold*255) = 0;
  diffFrame(diffFrame >= threshold*255) = 255;
 
  [rows cols] = size(diffFrame);
  newFrame = zeros(rows,cols);
  %%
  %optimal initial blockSize
  blockSize = 1.2; 
  
  %%
  % Perform blocking with incrementing blockSize to get
  % better definition for bigger objects
  % NOTE: objects are larger the higher the rows
  for i=1:rows
    for j=1:cols
      minRowClamp = max(1,i-1);
      maxRowClamp = min(rows, (ceil(blockSize)-1)+i);
      minColClamp = max(1, j-1);
      maxColClamp = min(cols, (ceil(blockSize)-1)+j);
      xCoords = minRowClamp:maxRowClamp;
      yCoords = minColClamp:maxColClamp;
    
      if diffFrame(xCoords,yCoords) == 0
        continue;
      end
 
      %%
      %Threshold with second optimal threshold value
      if mean2(diffFrame(xCoords, yCoords)) > 0.2*255
        newFrame(i, j) = 255;
      else
        newFrame(i, j) = 0;
      end 
      
    end
    %% 
    %optimal incrementing value
    % 1 pixel every 20 rows
    blockSize = blockSize+0.05;
  end

  toc

end

