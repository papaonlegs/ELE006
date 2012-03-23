function[newFrame] = QMUL_partA5(vidFrames, percent, type)
    %
    %QMUL_part5    Background Discovery
    % This calculates the background frame from a set of Video Frames.
    % We use a blocked frame difference overlay subfunction or an RGB
    % averaging function.
    %
    % backgroundFrame = QMUL_partA5(vidFrames, Percent, Type)
    %
    % INPUT
    % vidFrames - Frames of the video
    % Percent - Percent of video to use
    % Type - Method of baground frame discovery. 'overlay' or 'average'
    %
    % OUTPUT
    % backgroundFrame - The background Frame
    
    %%
    %Ideal values that also ensure speed in processing
    
    blockSize = 2;
    threshold1 = 6;
    threshold2 = 3;
    clarity = 5;
    
    %%
    %Calculate frames available for us to use
    
    [row col depth frameNum] = size(vidFrames);
    percentage = percent/100;
    totalFrames = ceil(percentage*frameNum);
    
    
    %%
    % Use method dependent on input
    
    switch type
        case 'block'
            %%
            %Iterate through our overlay subfunction to attempt clarity of
            %background
    
            newFrame = vidFrames(:,:,:,1);
            frameMultiple = totalFrames/clarity;
    
            for i=1:clarity
                frame = floor(((clarity+1)-i)*frameMultiple);
                
                % use frame overlay method
                newFrame = QMUL_partA5i(newFrame, vidFrames(:,:,:,frame), vidFrames(:,:,:,frame+1), threshold1, threshold2, blockSize);
            end
            
            
            %Display background frame
            figure(), imshow(newFrame);
      
        case 'average'
            
            %use averaging method
            newFrame = QMUL_partA5ii(vidFrames, totalFrames);
            
            %Display background frame
            figure(), imshow(newFrame);
        otherwise
            
            %Display background frame
            display('Please input block or average in the type parameter');
    end
    
    
    
end