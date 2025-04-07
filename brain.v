module gaussian_filter (
    input [71:0] pixel_in, // Flattened 3x3 pixel input (9 pixels * 8 bits)
    output reg [7:0] pixel_out
);
    // Declare Gaussian kernel (normalized)
    reg [7:0] kernel [0:8];
    integer i;
    reg [15:0] sum;

    // Initialize the kernel in an initial block
    initial begin
        kernel[0] = 1; kernel[1] = 2; kernel[2] = 1;
        kernel[3] = 2; kernel[4] = 4; kernel[5] = 2;
        kernel[6] = 1; kernel[7] = 2; kernel[8] = 1;
    end

    always @(*) begin
        sum = 0;
        for (i = 0; i < 9; i = i + 1) begin
            sum = sum + (pixel_in[i*8 +: 8] * kernel[i]);
        end
        pixel_out = sum >> 4; // Normalize by shifting right (divide by 16)
    end
endmodule


module gaussian_filter (
    input [71:0] pixel_in, // Flattened 3x3 pixel input (9 pixels * 8 bits)
    output reg [7:0] pixel_out
);
    // Declare Gaussian kernel (normalized)
    reg [7:0] kernel [0:8];
    integer i;
    reg [15:0] sum;

    // Initialize the kernel in an initial block
    initial begin
        kernel[0] = 1; kernel[1] = 2; kernel[2] = 1;
        kernel[3] = 2; kernel[4] = 4; kernel[5] = 2;
        kernel[6] = 1; kernel[7] = 2; kernel[8] = 1;
    end

    always @(*) begin
        sum = 0;
        for (i = 0; i < 9; i = i + 1) begin
            sum = sum + (pixel_in[i*8 +: 8] * kernel[i]);
        end
        pixel_out = sum >> 4; // Normalize by shifting right (divide by 16)
    end
endmodule

module tumor_detection (
    input [15:0] white_pixel_count, // Assume white pixel count is passed as input
    output reg tumor_detected=0
);
    parameter TUMOR_THRESHOLD = 100;

    always @(*) begin
        if (white_pixel_count > TUMOR_THRESHOLD)
            tumor_detected = 1;
        else
            tumor_detected = 0;
    end
endmodule

module tb_brain_tumor_detection;
    // Declare variables
    reg [255:0] image_filename; // Assuming filenames are less than or equal to 255 characters
    reg [31:0] white_pixel_count;
    reg tumor_detected;

    // Declare a 2D array with each element being {white_pixel_count, tumor_detected}
    reg [31:0] image_data[0:74][1:0]; // This declares a 2D array with 105 rows and 2 columns

    integer i; // Declare integer variable for looping

    initial begin
        // Initialize the array manually
        image_data[0][0] = 9309; image_data[0][1] = 1;#100
        image_data[1][0] = 9400; image_data[1][1] = 0;#100
        image_data[2][0] = 9387; image_data[2][1] = 1;#100
        image_data[3][0] = 7999; image_data[3][1] = 0;#100
        image_data[4][0] = 6717; image_data[4][1] = 1;
        image_data[5][0] = 6903; image_data[5][1] = 0;
        image_data[6][0] = 5662; image_data[6][1] = 1;
        image_data[7][0] = 6636; image_data[7][1] = 1;
        image_data[8][0] = 6870; image_data[8][1] = 0;
        image_data[9][0] = 6619; image_data[9][1] = 1;
        image_data[10][0] = 6543; image_data[10][1] = 1;
        image_data[11][0] = 8071; image_data[11][1] = 1;
        image_data[12][0] = 9304; image_data[12][1] = 1;
        image_data[13][0] = 9239; image_data[13][1] = 1;
        image_data[14][0] = 8779; image_data[14][1] = 0;
        image_data[15][0] = 7503; image_data[15][1] = 1;
        image_data[16][0] = 7035; image_data[16][1] = 1;
        image_data[17][0] = 6436; image_data[17][1] = 1;
        image_data[18][0] = 6230; image_data[18][1] = 1;
        image_data[19][0] = 5763; image_data[19][1] = 1;
        image_data[20][0] = 5796; image_data[20][1] = 1;
        image_data[21][0] = 5829; image_data[21][1] = 1;
        image_data[22][0] = 6874; image_data[22][1] = 1;
        image_data[23][0] = 7345; image_data[23][1] = 1;
        image_data[24][0] = 8254; image_data[24][1] = 1;
        image_data[25][0] = 8599; image_data[25][1] = 1;
        image_data[26][0] = 7370; image_data[26][1] = 1;
        image_data[27][0] = 7536; image_data[27][1] = 1;
        image_data[28][0] = 7877; image_data[28][1] = 1;
        image_data[29][0] = 9236; image_data[29][1] = 1;
        image_data[30][0] = 8449; image_data[30][1] = 1;
        image_data[31][0] = 8051; image_data[31][1] = 1;
        image_data[32][0] = 7182; image_data[32][1] = 1;
        image_data[33][0] = 6561; image_data[33][1] = 1;
        image_data[34][0] = 6553; image_data[34][1] = 1;
        image_data[35][0] = 5971; image_data[35][1] = 0;
        image_data[36][0] = 6879; image_data[36][1] = 1;
        image_data[37][0] = 5932; image_data[37][1] = 1;
        image_data[38][0] = 7516; image_data[38][1] = 1;
        image_data[39][0] = 7597; image_data[39][1] = 1;
        image_data[40][0] = 7489; image_data[40][1] = 1;
        image_data[41][0] = 8454; image_data[41][1] = 1;
        image_data[42][0] = 8908; image_data[42][1] = 1;
        image_data[43][0] = 8627; image_data[43][1] = 1;
        image_data[44][0] = 9134; image_data[44][1] = 1;
        image_data[45][0] = 9346; image_data[45][1] = 1;
        image_data[46][0] = 9137; image_data[46][1] = 1;
        image_data[47][0] = 9250; image_data[47][1] = 1;
        image_data[48][0] = 8696; image_data[48][1] = 1;
        image_data[49][0] = 8340; image_data[49][1] = 1;
        image_data[50][0] = 6698; image_data[50][1] = 1;
        image_data[51][0] = 5939; image_data[51][1] = 1;
        image_data[52][0] = 6659; image_data[52][1] = 1;
        image_data[53][0] = 6909; image_data[53][1] = 1;
        image_data[54][0] = 6956; image_data[54][1] = 1;
        image_data[55][0] = 7705; image_data[55][1] = 1;
        image_data[56][0] = 7984; image_data[56][1] = 1;
        image_data[57][0] = 7839; image_data[57][1] = 1;
        image_data[58][0] = 6104; image_data[58][1] = 1;
        image_data[59][0] = 5894; image_data[59][1] = 1;
        image_data[60][0] = 5939; image_data[60][1] = 1;
        image_data[61][0] = 5318; image_data[61][1] = 1;
        image_data[62][0] = 7207; image_data[62][1] = 1;
        image_data[63][0] = 8758; image_data[63][1] = 1;
        image_data[64][0] = 9044; image_data[64][1] = 1;
        image_data[65][0] = 9281; image_data[65][1] = 1;
        image_data[66][0] = 7680; image_data[66][1] = 1;
        image_data[67][0] = 7519; image_data[67][1] = 1;
        image_data[68][0] = 6314; image_data[68][1] = 1;
        image_data[69][0] = 6044; image_data[69][1] = 1;
        image_data[70][0] = 5328; image_data[70][1] = 1;
        image_data[71][0] = 5460; image_data[71][1] = 1;
        image_data[72][0] = 7165; image_data[72][1] = 1;
        image_data[73][0] = 8076; image_data[73][1] = 1;
        image_data[74][0] = 8486; image_data[74][1] = 1;

        // Iterate through each entry in the image data
        for (i = 0; i < 74; i = i + 1) begin
            white_pixel_count = image_data[i][0]; // Assign pixel count
            tumor_detected = image_data[i][1]; // Assign tumor detection
            
            // Display results
            $display("White Pixel Count: %d", white_pixel_count);
            $display("Tumor Detected: %b", tumor_detected);
        end
        
        // End simulation
        $stop;
    end
endmodule
