% Define the folder path containing MRI images
folderPath = '/MATLAB Drive/test';

% Get a list of all images in the folder
imageFiles = dir(fullfile(folderPath, '*.jpg')); % Change '*.jpg' if images are in a different format
disp(['Number of images found: ', num2str(length(imageFiles))]); % Check the number of images found

% Check if there are no images found
if isempty(imageFiles)
    disp('No images found in the specified folder. Check the folder path and file extension.');
else
    % Loop through each image in the folder
    for k = 1:5
        disp(['Processing Image: ', imageFiles(k).name]); % Display the current image being processed

        % Load the image
        filePath = fullfile(folderPath, imageFiles(k).name);
        I = imread(filePath);

        % Display the original image
        figure;
        imshow(I);
        title(['Original MRI Scan: ', imageFiles(k).name]);

        % Convert image to grayscale if it is not already
        if size(I, 3) == 3
            grayImage = rgb2gray(I);
        else
            grayImage = I;
        end

    % Apply Gaussian filter for noise reduction
    filteredImage = imgaussfilt(grayImage, 2);

    % Resize the image to 256x256
    resizedImage = imresize(filteredImage, [256 256]);

    % Edge detection using Sobel
    edges = edge(resizedImage, 'Sobel');

    % Display the edges
    figure;
    imshow(edges);
    title('Edges Detected');

    % Adaptive thresholding for segmentation
    adaptiveThreshold = adaptthresh(resizedImage, 0.5);
    binaryImage = imbinarize(resizedImage, adaptiveThreshold);

    % Apply morphological operations to improve segmentation
    binaryImage = imopen(binaryImage, strel('disk', 3)); % Removes small noise
    binaryImage = imclose(binaryImage, strel('disk', 5)); % Closes gaps in detected regions

    % Display the binary image after morphological processing
    figure;
    imshow(binaryImage);
    title('Binary Image with Morphological Operations');

    % Debug: Count and display the number of white pixels
    whitePixelCount = sum(binaryImage(:));
    disp(['White pixel count: ', num2str(whitePixelCount)]);

    % Detect tumor based on area of high-intensity regions
    % Set a threshold for the area that indicates a tumor presence
    tumorAreaThreshold = 100;  % Adjust this value based on your images
    tumorDetected = whitePixelCount > tumorAreaThreshold;

    % Display result
    if tumorDetected
        disp('Tumor Detected');
    else
        disp('No Tumor Detected');
    end
    end
end
