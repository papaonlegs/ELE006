function[diffFrame] = QMUL_partA1(vidFrames, frame, threshold)
    %
    %QMUL_partA1    Frame difference
    % Frame differene using the first frame as reference frame
    % and specified frame as original frame
    % Apply specified threshold and display image
    %
    % differencedFrame = QMUL_partA1(VideoFrames, FrameNumber, Threshold)
    %
    % INPUT
    % VideoFrames - Frames of the video
    % FrameNumber - Number of frame you want to difference
    % Threshold - Marker to indicate threshold
    %
    % OUTPUT
    % differencedFrame - The thresholded differenced Frame
    
    %vidMatrix = VideoReader(video);
    %vidFrames = read(vidMatrix);
    
    %%
    %Difference the Frame
    
    diffFrame = uint8(abs(double(rgb2gray(vidFrames(:,:,:,1))) - double(rgb2gray(vidFrames(:,:,:, frame)))));
    
    %%
    %Apply Threshold if specified
    
    if(threshold>0)
        diffFrame(diffFrame<threshold) = 0;
        diffFrame(diffFrame>threshold) = 255;
    end
    
    %%
    %Display thresholded frame
    imwrite(diffFrame, 'question1.bmp', 'bmp');
    figure(),imshow(diffFrame)
end
