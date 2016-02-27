PRE-REQUISITES

1.) PLEASE ENSURE YOU HAVE MATLAB 2011B OR ONE THAT SUPPORTS VideoReader() FUNCTION
i.) YOU CAN DOWNLOAD MATLAB FROM MATHWORKS.COM
2.) MAKE SURE YOUR VIDEO IS IN THE SAME FOLDER AS \SW IN THE EC09518_ELEM006 UNZIPPED FOLDER

RUNNING

NOTE : WE WILL ASSUME OUR WORKING DIRECTORY IS \MATLAB IN YOUR DOCUMENTS FOLDER

1.) UNZIP EC09518_ELEM006 IN YOUR WORKING DIRECTORY
2.) OPEN MATLAB
3.) NAVIGATE YOUR CURRENT DIRECTORY TO \SW
4.) COPY YOUR VIDEO INTO THIS DIRECTORY IF YOU HAVEN'T ALREADY
5.) RUN 'vidFrames = QMUL_VideoToFrames('videoname')' (videoname being your video name)


PART A

TO RUN QUESTION 1 TYPE 'QMUL_partA1(vidFrames, frame, threshold);' (frame being the frame number you want to difference and threshold being your threshold)
TO RUN QUESTION 2 TYPE 'QMUL_partA2(vidFrames, frame, threshold);' (frame being the frame number you want to difference and threshold being your threshold)
TO RUN QUESTION 3 TYPE 'QMUL_partA3(vidFrames, frame, threshold1, threshold2);' (frame being the frame number you want to difference and threshold1 and 2 being your thresholds)
TO RUN QUESTION 4 TYPE 'QMUL_partA4(vidFrames, frame, threshold1, threshold2, blockSize);' (frame being the frame number you want to difference, threshold1 and being your thresholds and blockSize being your block size)
TO RUN QUESTION 5 TYPE 'QMUL_partA5(vidFrames, percent, type);' (frame being the frame number you want to difference, percent being the duration of video we are allowed to use and type being the type of background generation method you want to use i.e 'block' or 'average')
TO RUN QUESTION 6 TYPE 'QMUL_partB6(vidFrames, frame);
TO RUN QUESTION 5 TYPE 'QMUL_partB7(vidFrames, method);
TO RUN QUESTION 5 TYPE 'QMUL_partB8(vidFrames, frame, method);
TO RUN QUESTION 5 TYPE 'QMUL_partB9(vidFrames);
TO RUN QUESTION 5 TYPE 'QMUL_partC10(vidFrames, frame, method);
TO RUN QUESTION 5 TYPE 'QMUL_partA5(vidFrames, frame);
TO RUN QUESTION 5 TYPE 'QMUL_partA5(vidFrames, frame);


NOTE:

1.) PLEASE DO NOT FORGET ';' AT THE END OF EVERY FUNCTION OR ELSE YOU RISK SEEING A SPILL OF MATRICES
2.) FOR MORE DETAIL ON EACH FUNCTION AND EXAMPLE JUST TYPE 'help <FUNCTION NAME>' E.G 'help QMUL_partA5'
3.) IF YOU HAVE ANY ENQUIRIES PLEASE DO NOT HESITATE TO CONTACT ME AT EC09518@EECS.QMUL.AC.UK
4.) QMUL_partB9 PERFORMS BETTER ON WINDOWS WITH MICROSOFT EXCEL INSTALLED BECAUSE OF ITS EXCEL INTEGRATION
