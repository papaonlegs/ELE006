function[finalFrame] = QMUL_partB6(vid, frame)
    %
    %QMUL_part6    Frame Differencing
    % This is an efficient frame differencing function that subtracts
    % background from frame. The backgrounding method is 'average'. It
    % displays a bar graph of zeros and ones.
    %
    % finalFrame = QMUL_partB6(vidFrames, frame)
    %
    % INPUT
    % vidFrames - Frames of the video
    % frame - Frame to use
    %
    % OUTPUT
    % finalFrame - The BW differenced and thresholded frame
    %
    % SOURCES NEEDED
    % QMUL_partA5.m and QMUL_thresholding.m
    
    %%
    %CALL other functions to derive background then difference
    tic;
    background = QMUL_partA5(vid, 100, 'average');
    finalFrame = QMUL_thresholding(background, vid(:,:,:,frame));
    toc

    %%
    %Display differenced frame and bar graph of zeros and ones
    imshow(finalFrame);
    
    onezero = [1, 0];
    times = [sum(sum(finalFrame > 0)), sum(sum(finalFrame == 0))];
    figure, bar(onezero, times);

end
