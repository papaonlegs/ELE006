function[vidFrames] = QMUL_VideoToFrames(VideoName)
    %load Video
    
    vidObj = VideoReader(VideoName);
    vidFrames = read(vidObj);
    
end