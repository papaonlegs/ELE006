function[diffFrame] = QMUL_partA3(video, frame, threshold1, threshold2)
    %
    %QMUL_partA3    Frame difference
    % Frame differene using a logical 'and' combination
    % of differencing from QMUL_partA1 and
    % QMUL_partA2
    %
    % differencedFrame = QMUL_partA2(VideoFrames, FrameNumber, Threshold1, 
    % Threshold2)
    %
    % INPUT
    % VideoFrames - Frames of the video
    % FrameNumber - Number of frame you want to difference
    % Threshold1 - Threshold for QMUL_partA1
    % Threshold2 - Threshold for QMUL_partA2
    %
    % OUTPUT
    % differencedFrame - The combined Frame
    
    %vidMatrix = VideoReader(video);
    %vidFrames = read(vidMatrix);
    
    %%
    %Get the two different differences 
    
    FrameVid1 = QMUL_partA1(video, frame, threshold1);
    FrameVid2 = QMUL_partA2(video, frame, threshold2);
    
    %%
    %Combine using logical 'and'
    
    diffFrame = FrameVid1 & FrameVid2;
    
    %%
    %Display combined frame
    
    figure(),imshow(diffFrame)
end
