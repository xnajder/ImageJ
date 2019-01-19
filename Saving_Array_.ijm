d = newArray(2, 6, 8);
Array.show(d);

g = newArray();


for (i =0; i < d.length; i++){
	if (d[i] == 6) {
		g = Array.concat(g, d[i]);
		
	}

	f = File.open("C:/Users/Karolina/Desktop/Logs/Log.txt"); // display file open dialog
   //f = File.open("/Users/wayne/table.txt");
   // use d2s() function (double to string) to specify decimal places 
	for (i = 0; i <= d.length; i++) {
		print(f, d2s(i,3) + "  \t" + 3 + " \t" + 5);
		// saveAs("Text", "C:/Users/Karolina/Desktop/Log.txt");
		File.append("jeszcze to", "C:/Users/Karolina/Desktop/Logs/Log.txt");
	}
		File.append("jeszcze to ", "C:/Users/Karolina/Desktop/Logs/Log.txt");
		File.close(f);
		g = File.open("C:/Users/Karolina/Desktop/Logs/Log_2.txt"); // display file open dialog
   //f = File.open("/Users/wayne/table.txt");
   // use d2s() function (double to string) to specify decimal places 
	for (i = 0; i <= d.length; i++) {
		print(f, d2s(i,3) + "  \t" + 3 + " \t" + "tralalal");
		// saveAs("Text", "C:/Users/Karolina/Desktop/Log.txt");
	}
      	//print(f, d2s(i,6) + "  \t" + d2s(sin(i),6) + " \t" + d2s(cos(i),6));
		//saveAs("Text", "C:/Users/Karolina/Desktop/Log.txt");
}




