function [ graph ] = QMUL_partB7( vid, method )
    %
    %QMUL_part7    Object Counting
    % Counts number of objects in each frame and plots a graph.
    % of cars vs frame number. It can use either an in-built connection 
    % analyzer or flood fill.
    %
    % graph = QMUL_partB7(vidFrames, method)
    %
    % INPUT
    % vidFrames - Frames of the video
    % method - Method to use. 'conn' or 'average'
    %
    % OUTPUT
    % graph - The BW differenced and thresholded frame
    %
    % SOURCES NEEDED
    % QMUL_partA5.m , QMUL_thresholding.m and QMUL_FloodFill.m

  graph = zeros(1,2);
  tic;
  %%
  %Get The background frame
  background = QMUL_partA5(vid, 100, 'average');
  
  [row col ch frames] = size(vid);
  
  %loop through frames
  for frame=1:frames
      %%
      %Get the BW differenced frame
      BWFrame = QMUL_thresholding(background, vid(:,:,:,frame));
       
      switch method
          case 'conn'
              %%
              %Get a connectivity Structure and use the number of objects field
              conCom = bwconncomp(BWFrame);
              cars = conCom.NumObjects;
              graph(1,frame) = cars;
          case 'flood'
              %%
              %Use flood fill algorithm and return the bounds of each objects
              [objects bounds hi low] = QMUL_FloodFill(BWFrame);

              [cars x y] = size(bounds);
              graph(1,frame) = cars;
      end
  end
  toc
  %%
  %plot a graph of objects vs frame number
  plot(graph);
end

