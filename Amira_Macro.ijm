dire = getDirectory("Choose a Directory for your .am file?");
liste = getFileList(dire);

for (i = 0; i <= liste.length - 1; i++) {
	// setBatchMode(true);
	open(dire + liste[i]);
	files = getTitle();
	endCheck = endsWith(files, ".am");
	
	if (endCheck == true) {
		 // print(dire);
		 trackTheCells(); 
	}
	else {
		Dialog.create("Let's fix it");
		Dialog.addMessage("It may be wrong file format. Please, check if you have an .am file");
		Dialog.show();
		print("Wrong file format. Please, check if you have .am file");
	}
}

// ------------------------------------ // ------------------------------------


function trackTheCells() {
	// cams = newArray("New camera", "Old camera");
	Dialog.create("Amira analysis");
	// Dialog.addRadioButtonGroup("Camera:", cams, 2, 1, cams[0]);
	Dialog.addNumber("What is the pixel size?", 1.123);
	pix_size = Dialog.getNumber();
	Dialog.addNumber("What is the interval in seconds?", 5);
	interval = Dialog.getNumber();
	Dialog.show();
	// camera = Dialog.getRadioButton();
	dim = nSlices;
	// print(pix_size);
	// print(interval);
	// print(dim);
	run("Properties...", "channels=1 slices="+ dim 	+ " frames=1 unit=micron pixel_width=" + pix_size + " pixel_height=" + pix_size + " voxel_depth=" + interval + "");
	// getSelectionCoordinates(xpoints, ypoints)
	run("Grays");
	run("8-bit");
	setThreshold(1, 255);
	
	run("Create Selection");
	roiManager("Add");
	roiManager("Split");
	roiManager("Select", 0);
	// roiManager("Delete");
	nCells_1 = roiManager("count");
	nCells_1 = nCells_1 - 1;
	// print("You tracked: "+ nCells_1 - 1 + " cells");
	Dialog.create("To sum up");
	Dialog.addMessage("Pixel size is " + pix_size + "\nThere are "+ dim + " frames");
	Dialog.addMessage("You tracked: "+ nCells_1+ " cells");
	// print(pix_size);
	// print(interval);
	// print(dim);
	Dialog.show();
	
	roiManager("reset");
	run("Create Selection");
	roiManager("Add");

	arr_1 = newArray();
	arr_2 = newArray(); 
	track();
	
	/* for (i = 0; i < nSlices; i++){
		track();
	} */
}

// ------------------------------------ // ------------------------------------


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
			makeRectangle(horizontal, vertical, 1, 1);
			makeRectangle(1, 1, 1, 1);
			
			getStatistics(area, mean, min, max, std, histogram);
			
			// print(area);
			
			Roi.getBounds(x, y, width_Pix, height_Pix);
			// print(x + " " + y);
			
			
			x_1 = x * pix_size;
			y_1 = y * pix_size;
			setResult("Mean", nResults, mean);
			setResult("x_coo", nResults - 1, x_1);
			setResult("y_coo", nResults - 1, y_1);
			run("Create Selection");
			}
		}
	}

// ------------------- 

meanValues = newArray(nResults);
x_values = newArray(nResults);
y_values = newArray(nResults);

for(i = 0; i < nResults; i++) {
	meanValues[i] = getResult("Mean", i);
	x_values[i] = getResult("x_coo", i);
	y_values[i] = getResult("y_coo", i);
}
// ---- cell -----

count_1 = 0;
sum_1_x = 0;
sum_1_y = 0;

for (j = 0; j < nResults - 1; j ++) {
	mean = 1;
	if (meanValues[j] == mean) {
		
		sum_1_x = sum_1_x + x_values[j];
		sum_1_y = sum_1_y + y_values[j];
		count_1++;
		print(meanValues[j] + " " + sum_1_x + " " + sum_1_y);
	}
}

//print(sum_1_x);
//print(count_1);
average_x = sum_1_x/count_1;
average_y = sum_1_y/count_1;
area_1 = count_1 * pix_size * pix_size; 

arr_1 = Array.concat(mean, average_x, average_y, area_1);

Array.print(arr_1);

// close("Results");
// run("Next Slice [>]");
}



// ---- cell -----

/*

count_2 = 0;
sum_2_x = 0;

for (j = 0; j < nResults - 1; j++) {
	if (meanValues[j] == 2) {
		// print(meanValues[j] + " " + print(sum_1); + " " + y_values[j]);
		sum_2_x = sum_2_x + x_values[j];
		sum_2_y = sum_2_y + y_values[j];
		count_2++;
	}
}

//print(sum_2_x);
// print(count_2);
average_x = sum_2_x/count_2;
average_y = sum_2_y/count_2;

print(average_x + " " + average_y);

// ---- cell -----



count_3 = 0;
sum_3_x = 0;

for (j = 0; j < nResults - 1; j++) {
	if (meanValues[j] == 3) {
		// print(meanValues[j] + " " + print(sum_1); + " " + y_values[j]);
		sum_3_x = sum_3_x + x_values[j];
		sum_3_y = sum_3_y + y_values[j];
		count_3++;
	}
}

// print(sum_3_x);

// print(count_3);
average_x = sum_3_x/count_3;
average_y = sum_3_y/count_3;

print(average_x + " " + average_y);


// ---- cell -----



count_4 = 0;
sum_4_x = 0;

for (j = 0; j < nResults - 1; j++) {
	if (meanValues[j] == 4) {
		// print(meanValues[j] + " " + print(sum_1); + " " + y_values[j]);
		sum_4_x = sum_4_x + x_values[j];
		sum_4_y = sum_4_y + y_values[j];
		count_4++;
	}
}

//print(sum_4_x);

//print(count_4);
average_x = sum_4_x/count_4;
average_y = sum_4_y/count_4;

print(average_x + " " + average_y);

// ---- cell -----

count_5 = 0;
sum_5_x = 0;

for (j = 0; j < nResults - 1; j++) {
	if (meanValues[j] == 5) {
		// print(meanValues[j] + " " + print(sum_1); + " " + y_values[j]);
		sum_5_x = sum_5_x + x_values[j];
		sum_5_y = sum_5_y + y_values[j];
		count_5++;
	}
}

//print(sum_5_x);

//print(count_5);
average_x = sum_5_x/count_5;
average_y = sum_5_y/count_5;

print(average_x + " " + average_y);

// ---- cell -----



count_6 = 0;
sum_6_x = 0;

for (j = 0; j < nResults - 1; j++) {
	if (meanValues[j] == 6) {
		// print(meanValues[j] + " " + print(sum_1); + " " + y_values[j]);
		sum_6_x = sum_6_x + x_values[j];
		sum_6_y = sum_6_y + y_values[j];
		count_6++;
	}
}

//print(sum_6_x);

//print(count_6);
average_x = sum_6_x/count_6;
average_y = sum_6_y/count_6;

print(average_x + " " + average_y);



// ---- cell -----



count_6 = 0;
sum_6_x = 0;

for (j = 0; j < nResults - 1; j++) {
	if (meanValues[j] == 6) {
		// print(meanValues[j] + " " + print(sum_1); + " " + y_values[j]);
		sum_6_x = sum_6_x + x_values[j];
		sum_6_y = sum_6_y + y_values[j];
		count_6++;
	}
}

//print(sum_6_x);

//print(count_6);
average_x = sum_6_x/count_6;
average_y = sum_6_y/count_6;

print(average_x + " " + average_y);

*/
		
		// ---------------------------- end track










