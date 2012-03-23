function[newFrame] = QMUL_partA5i(refFrame, oriFrameref, oriFrame, threshold1, threshold2, blockSize)
    %
    %QMUL_partA5i    frame difference overlay
    % This overlays moving bodies in a frame with the same position from
    % another frame.
    % We difference and block our frames first.
    % This function is used in QMUL_partA5.
    %
    % overlayedFrame = QMUL_partA5i(RefFrame, OriFrameRef, OriFrame, 
    % Threshold1, Threshold2, BlockSize)
    %
    % INPUT
    % RefFrame - Reference Frame
    % OriFrameRef - Reference Frame 2
    % OriFrame - Original Frame
    % Threshold1 - Threshold for QMUL_partA1
    % Threshold2 - Threshold for QMUL_partA2
    % BlockSize - A number to represent one side of our square block
    %
    % OUTPUT
    % overlayedFrame - The blocked Frame
    
    %%
    % Call a subfunction to perform differencing & blocking
    
    diff1 = QMUL_partA4i(refFrame, oriFrame, threshold1, blockSize);
    diff2 = QMUL_partA4i(oriFrameref, oriFrame, threshold2, blockSize);
    
    %%
    % logically 'and' the frames
    
    finalDiff = diff1 & diff2;
    
    %%
    %Create copies of the original and reference frame for overlaying
    
    [row cols] = size(finalDiff);
    firstFrame = oriFrame;
    newFrame = refFrame;
    
    %%
    %Overlay detected moving objects with same position in different frame
    
    for i=1:row
        for j=1:cols
            if(finalDiff(i,j) == 0)
                newFrame(i,j,:) = firstFrame(i,j,:);
            end
        end
    end
end