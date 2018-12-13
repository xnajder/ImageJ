dire = getDirectory("Choose a Directory for your .am file?");
liste = getFileList(dire);

print(liste[0]);

for (i = 0; i <= liste.length - 1; i++) {
	// setBatchMode(true);
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
	run("8-bit");
	setThreshold(1, 255);
	run("Create Selection");
	roiManager("Add");
	roiManager("Split");
	roiManager("Select", 0);
	roiManager("Delete");
	nCells = roiManager("count");
	
	print("You tracked: "+ nCells + " cells");

	track();
}

function track() {


	for (i = 0; i < nSlices; i++) {
		
		for (i = 0; i < nCells; i++) {
		
		roiManager("Select", i);
		// print(i);
		getStatistics(area, mean, min, max, std, histogram);
		getSelectionBounds(x, y, width, height);
	
		x = x * pix_size;
		y = y * (-1) * pix_size;
		area = area * pix_size * pix_size;
	
		print(x + " " + y + " " + area);
		
	}
	
		roiManager("reset")
		run("Create Selection");
		roiManager("Add");
		roiManager("Split");
		roiManager("Select", 0);
		roiManager("Delete");
		run("Next Slice [>]");




		
	}
}

















