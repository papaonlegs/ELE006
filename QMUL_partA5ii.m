function[newFrame] = QMUL_partA5ii(vidFrames, limit)
    %
    %QMUL_partA5ii    frame averaging
    % This averages the RGB values of all the frames given.
    % 90 percent of most videos are background so our image will tend
    % towards the background
    % This function is used in QMUL_partA5.
    %
    % averagedFrame = QMUL_partA5i(vidFrames, limit)
    %
    % INPUT
    % vidFrames - Video frames
    % Limit - The limit of frames we are allowed to use
    %
    % OUTPUT
    % averagedFrame - The background Frame
    
    %%
    %Create a blank frame to put averaged pixels on
    
    [rows cols depth frames] = size(vidFrames);
    newFrame = zeros(rows, cols, depth);
    
    %%
    %Average RGB pixels across the 'limit' of frames
    
    for i=1:rows
        for j=1:cols
            for k=1:depth
                newFrame(i,j,k) = mean(vidFrames(i,j,k,1:limit));
            end
        end
    end
    
    %render frame in uint8 before passing back
    newFrame = uint8(newFrame);
end