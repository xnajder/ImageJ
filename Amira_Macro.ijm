dire = getDirectory("Choose a Directory for your .am file?");
liste = getFileList(dire);

print(liste[0]);

for (i = 0; i <= liste.length - 1; i++) {
	setBatchMode(true);
	open(dire + liste[i]);
	files = getTitle();
	endCheck = endsWith(files, ".am");
	
	if (endCheck == true) {
		 print(dire);
		 trackTheCells(); 
	}
	else {
		Dialog.create("Let's fix it");
		Dialog.addMessage("It may be wrong file format. Please, check if you have an .am file");
		Dialog.show();
		print("Wrong file format. Please, check if you have .am file");
	}
}

// ------------------------------------


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
	print(pix_size);
	print(interval);
	print(dim);

	Dialog.create("To sum up");
	Dialog.addMessage("You have "+ dim + " frames");
	Dialog.show();

	
	run("Properties...", "channels=1 slices="+ dim 	+ " frames=1 unit=micron pixel_width=" + pix_size + " pixel_height=" + pix_size + " voxel_depth=" + interval + "");
	
	// getSelectionCoordinates(xpoints, ypoints)
	run("16-bit");
	setThreshold(1, 65535);
	run("Create Selection");
	roiManager("Add");
	roiManager("Split");
	roiManager("Select", 0);
	roiManager("Delete");
	nCells_1 = roiManager("count");
	print("You tracked: "+ nCells_1 + " cells");
	
	track();
}




function track() {
	for (i = 0; i < nSlices; i++) {
		
		if (nCells_1 == roiManager("count")) {

			for (t = 0; t <= nCells_1 - 1; t++) {
			roiManager("Select", t);
			// print(i);
			getStatistics(area, mean, min, max, std, histogram);
			getSelectionBounds(x, y, width, height);

			
			
			x = x * pix_size;
			y = y * (-1) * pix_size;
			area = area * pix_size * pix_size;
		
			print(x + " " + y + " " + area + mean + "");
			
			run("Next Slice [>]");
			
		
	}
		}

	else {
		fin_areas = newArray();
		less_dots = roiManager("count");
		for (ncel = 0; ncel <= less_dots - 1; ncel++) {
			lack = nCells_1 - less_dots;
			getStatistics(area, mean, min, max, std, histogram);
			getSelectionBounds(x, y, width, height);
			x = x * pix_size;
			y = y * (-1) * pix_size;
			area = area * pix_size * pix_size;
			fin_areas = Array.concat(fin_areas, area);
	
		}

		Array.sort(fin_areas);
		print(fin_areas[0] + "-------------------------------------");
		roiManager("Select", 0);
		a = Roi.getName();
		print(a);
		print(roiManager("count"));
		run("Next Slice [>]");
			}

			
		roiManager("reset");
		run("Create Selection");
		roiManager("Add");
		roiManager("Split");
		roiManager("Select", 0);
		roiManager("Delete"); 

		
		
			
	} 
}

getI













