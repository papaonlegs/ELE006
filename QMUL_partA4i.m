function [newFrame] = QMUL_partA4i(refFrame, oriFrame, threshold, blockSize)
    %
    %QMUL_partA4i    difference and blocking subfunction
    % This differences input frames and blocks the result 'sliding' window
    % style.
    % This incorporates border clamping to simulate padding.
    % This function is used in QMUL_partA4 and QMUL_partA5i, which is
    % called in QMUL_partA5.
    %
    % blockedFrame = QMUL_partA4i(RefFrame, OriFrame, Threshold, 
    % BlockSize)
    %
    % INPUT
    % RefFrame - Reference Frame
    % OriFrame - Original Frame
    % Threshold - Marker to indicate threshold 
    % BlockSize - A number to represent one side of our square block
    %
    % OUTPUT
    % blockedFrame - The blocked Frame

    %%
    %Difference the Frame
    
    diffFrame = abs(double(rgb2gray(refFrame)) - double(rgb2gray(oriFrame)));
    diffFrame = uint8(diffFrame);
    
    %%
    %Create blank frame to paste result on
    
    [row col] = size(diffFrame);
    newFrame = zeros(row,col);
    
    %%
    %Perform blocking
    
    for i=1:row
        for j=1:col
            
            %Define clamps so we don't exceed matrix
            minRowClamp = max(i-1,1);
            maxRowClamp = min((blockSize-1)+i,row);
            minColClamp = max(j-1,1);
            maxColClamp = min((blockSize-1)+j, col);
            
            %Average the block range and paste in newFrame
            newFrame(i,j) = mean(mean(diffFrame(minRowClamp:maxRowClamp,minColClamp:maxColClamp)));
            
            %Threshold the pixel
            if(newFrame(i,j)>threshold)
                newFrame(i,j) = 255;
            else
                newFrame(i,j) = 0;
            end
            
        end
    end    
end