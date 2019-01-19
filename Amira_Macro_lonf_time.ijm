dire = getDirectory("Choose a Directory for your .am file?");
liste = getFileList(dire);

	
files = liste[0];

file = replace(files, ".am", "_track");

// print(file);

trackTheCells(); 

function trackTheCells() {
	// setBatchMode(true);
	open(dire + liste[0]);
	Dialog.create("Amira analysis");
	Dialog.addNumber("What is the pixel size?", 1.123);
	pix_size = Dialog.getNumber();
	Dialog.addNumber("What is the interval in seconds?", 5);
	interval = Dialog.getNumber();
	Dialog.show();
	dim = nSlices;
	run("Properties...", "channels=1 slices="+ dim 	+ " frames=1 unit=micron pixel_width=" + pix_size + " pixel_height=" + pix_size + " voxel_depth=" + interval + "");
	// getSelectionCoordinates(xpoints, ypoints)
	run("Grays");
	run("8-bit");
	setThreshold(1, 255);
	run("Create Selection");
	roiManager("Add");
	roiManager("Split");
	roiManager("Select", 0);
	nCells_1 = roiManager("count");
	nCells_1 = nCells_1 - 1;
	Dialog.create("To sum up");
	Dialog.addMessage("Pixel size is " + pix_size + "\nThere are "+ dim + " frames");
	Dialog.addMessage("You tracked: "+ nCells_1+ " cells");
	Dialog.show();
	roiManager("reset");
	run("Create Selection");
	roiManager("Add");
	arr_1 = newArray();
	arr_2 = newArray(); 

	// run("Clear Results");
	// 

	
	for (i = 0; i < 1; i++){
		run("Clear Results");
		track();
		print(i);


}

function track() {
	getDimensions(width, height, channels, slices, frames);
	if (width >= height) {
		w = width;
		h = height;
	}
	else {
		w = height;
		h = width;
	}

		for (vertical  = 0; vertical <= h; vertical++) {
		for (horizontal = 0; horizontal <= w; horizontal++) {
			if ( Roi.contains(horizontal, vertical)) {
				sum_1_x = 0;
				sum_1_y = 0;
				count_1 = 0;
				
				average_x = 0;
				average_y = 0;
				area_1 = 0;

				for (p == 1; p < 3; p++) {
					sum_1_x = sum_1_x + horizontal;
					sum_1_y = sum_1_y + vertical;
					count_1++;
				}

				print(count_1);

				average_x = sum_1_x/count_1;
				average_y = sum_1_y/count_1;
				area_1 = count_1 * pix_size * pix_size; 
				fin_dir = dire + file + "_Z" + i + ".txt"; 
				// File.append(average_x  + " \t" + average_y + " \t" + area_1 + " \t", fin_dir);		
			}
		}
		}
		run("Clear Results");
    run("Next Slice [>]");
}

//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			
	
			Roi.getBounds(x, y, width_Pix, height_Pix);				
			x_1 = x * pix_size;
			y_1 = y * pix_size;
			setResult("Mean", nResults, mean);
			setResult("x_coo", nResults - 1, x_1);
			setResult("y_coo", nResults - 1, y_1);
			run("Create Selection");

			}
		}
	}

	meanValues = newArray(nResults);
	x_values = newArray(nResults);
	y_values = newArray(nResults);
	
	for(i = 0; i < nResults; i++) {
		meanValues[i] = getResult("Mean", i);
		x_values[i] = getResult("x_coo", i);
		y_values[i] = getResult("y_coo", i);
	}
// ----------------------- cell ----------------------------------------------------------------------------------------------------


	for (i = 1; i < 21; i++) {
	
		count_1 = 0;
		sum_1_x = 0;
		sum_1_y = 0;
	
		average_x = 0;
		average_y = 0;
		area_1 = 0;
	
		for (j = 0; j < nResults - 1; j ++) {
			if (meanValues[j] == i) {
				sum_1_x = sum_1_x + x_values[j];
				sum_1_y = sum_1_y + y_values[j];
				count_1++;
				// print(meanValues[j] + " " + sum_1_x + " " + sum_1_y);
			}
		}
		
		average_x = sum_1_x/count_1;
		average_y = sum_1_y/count_1;
		area_1 = count_1 * pix_size * pix_size; 
	
		fin_dir = dire + file + "_Z" + i + ".txt"; 
		//print(_1,  " \t" + average_x  + " \t" + average_y + " \t" + area_1);
		//File.close(_1);
		File.append(average_x  + " \t" + average_y + " \t" + area_1 + " \t", fin_dir);

	
}
// ----------------------- cell ----------------------------------------------------------------------------------------------------
	
	run("Clear Results");
    run("Next Slice [>]");
}


