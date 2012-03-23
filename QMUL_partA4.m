function[newFrame] = QMUL_partA4(vidFrames, frame, threshold1, threshold2, blockSize)
    %
    %QMUL_partA4    Frame difference blocking
    % Frame blocking using differenced frames similar to QMUL_partA1
    % and QMUL_partA2 and return combined similar to QMUL_partA3.
    % We are using a sliding window appraoch with clamped borders to
    % simulate padding.
    % We assume a block is a square
    %
    % differencedFrame = QMUL_partA4(VideoFrames, FrameNumber, Threshold1, 
    % Threshold2, BlockSize)
    %
    % INPUT
    % VideoFrames - Frames of the video
    % FrameNumber - Number of frame you want to difference
    % Threshold1 - Threshold for QMUL_partA1
    % Threshold2 - Threshold for QMUL_partA2
    % BlockSize - A number to represent one side of our square block
    %
    % OUTPUT
    % differencedFrame - The blocked Frame
    
    %vidMatrix = VideoReader(video);
    %vidFrames = read(vidMatrix);
    
    %%
    % Call a subfunction to perform differencing & blocking
    
    diff1 = QMUL_partA4i(vidFrames(:,:,:,1), vidFrames(:,:,:,frame), threshold1, blockSize);
    diff2 = QMUL_partA4i(vidFrames(:,:,:,frame-1), vidFrames(:,:,:,frame), threshold2, blockSize);
    
    %%
    % logically 'and' the blocked frames
    
    newFrame = diff1 & diff2;
    
    %%
    %Display image
    
    figure(), imshow(newFrame);
end
