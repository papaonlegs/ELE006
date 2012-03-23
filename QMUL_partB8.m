function [ boundedPicture ] = QMUL_partB8( vid, picture )
    %
    %QMUL_part8    Object bounding
    % Counts number of objects in frame and outlines them in bounds
    %
    % boundedPicture = QMUL_partB8(vidFrames, frame)
    %
    % INPUT
    % vidFrames - Frames of the video
    % frame - Frame to use
    %
    % OUTPUT
    % boundedPicture - The picture with objects bounded
    %
    % SOURCES NEEDED
    % QMUL_partA5.m , QMUL_thresholding.m and QMUL_FloodFill.m

  %if we want video
  vido = VideoWriter('boundcars.avi');
  open(vido);
  
  tic;
  [row col ch frames] = size(vid);
  %%
  %Get The background frame
  backgroundFrame = QMUL_partA5(vid, 100, 'average');

  %loop if we want to output a video
  %for frame=1:frames
      frame = picture;
      %%
      %Get the BW differenced frame
      BWFrame = QMUL_thresholding(backgroundFrame, vid(:,:,:,frame));
      boundedFrame = vid(:,:,:,frame);

      %%
      %Use flood fill algorithm and return the bounds of each objects
      [cars bounds highs lows] = QMUL_FloodFill(BWFrame);

      %%
      %find highest and lowest X & Y to draw boxes

      %[xaxis yaxis] = size(highs);
      %for axis=1:xaxis
      %  lowY = lows(axis,2);
      %  highY = highs(axis,2);
      %  for inc=lows(axis,1):highs(axis:1)
      %      boundedFrame(inc, lowY, :) =[0 0 0];
      %      boundedFrame(inc, highY,:) =[0 0 0];
      %  end
      %  lowX = lows(axis,1);
      %  highX = highs(axis,1);
      %  for dec=lows(axis,2):highs(axis,2)
      %      boundedFrame(lowX, dec, :) =[0 0 0];
      %      boundedFrame(highX,dec, :) =[0 0 0];
      %  end
      %end
      
      %%
      %Draw the bounds on frame as is

      [num amount xy] = size(bounds);
      for i = 1: num
          for j=1:amount
              if bounds(i,j,1) == 0
                  continue;
              end

              for k=1:3
                boundedFrame(bounds(i,j,1), bounds(i,j,2), k) = 0;
              end
          end
      end
      
      %%
      %Write frame to videobuffer and output picture if frame specified

      writeVideo(vido, boundedFrame);
      imshow(boundedFrame);
      if frame == picture
          boundedPicture = boundedFrame;
          imwrite(boundedFrame, 'getthresh.jpg', 'jpg');
      end

  %end
  toc

  %%
  %Close video buffer
  close(vido);
end


