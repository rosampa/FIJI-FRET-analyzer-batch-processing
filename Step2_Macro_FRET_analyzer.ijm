
//// Before running this macro, there is a little correction you need to make in the makro. Starting in line 39 there are IJ robot commands (so basically FIJI clicking 
// by its own on your desktop). There you need to add the coordinates of some buttons of FRET analyzer. Open FRET analyzer with
// 2 opened images (could be any images) and place the FRET analyzer window on your desktop in a rememberable way (or just leave it in the default position that was used when prompted open) Then do Plugins  ▶ Utilities  ▶ Capture Screen. 
// and hover over the buttons you can see in all IJ Robot commands and write down the x y coordinates on your screen. Add those in the macro and you are 
// done! 
// To start just activate the macro, it will ask you for the "your sample name" folder.
//The output will be a batch of slices in the Results folder, with the FRET index encoded as signal intensity (with the lookup tables "fire"). Import all those to Fiji and do Image>Stacks>Images to stack and save the new stack. Use the StackReg plugin if correction for x-y drifting is necessary. Then the images are ready to proceed with image analysis using ROI manager to select particles of interest and plotting the temporal intensity profiles with Plot z-axis profile

dir1 = getDirectory("Choose sample directory ");
dir= dir1 + "CFP/";
dir2 = dir1 + "FRET/";
output = dir1 + "CFP-8bit/";
output2 = dir1 + "FRET-8bit/";
output3 = dir1 + "Results/";


setBatchMode(true);
list = getFileList(dir);

//for (i=0; i < list.length; i++){
for (i = 0; i < list.length - 240; i++){
		//print(list[i]);
        		open(dir + list[i]);
        		

        		selectWindow(list[i]);
				setOption("ScaleConversions", true);
				run("8-bit");
				saveAs("Tif", output + " CFP" + list[i]);
				
				open(dir2 + list[i]);
				selectWindow(list[i]);
				setOption("ScaleConversions", true);
				run("8-bit");
				saveAs("Tif", output2 + " FRET"+ list[i]);
				run("Fret Analyzer");

				run("IJ Robot", "order=Left_Click x_point=272 y_point=60 delay=100 keypress=[]");	// click FRET calculations in FRET analizer
				run("IJ Robot", "order=Left_Click x_point=270 y_point=194 delay=100 keypress=[]");	// click on "FRET channel image"
				run("IJ Robot", "order=Left_Click x_point=270 y_point=214 delay=100 keypress=[]");	// select "FRET" image
				run("IJ Robot", "order=Left_Click x_point=320 y_point=490 delay=300 keypress=[]");	// click on FRET index
				
				
				selectWindow("FRET index");
				saveAs("Tif", output3 + "cFRET"+ list[i]);        
				close();
				

				selectWindow("Colocalization diagram and FRET");
				close();
				
				selectWindow( " CFP" + list[i]);
     			close();
     			
				selectWindow(" FRET" + list[i]);
		        close();
				
        	
}


setBatchMode(false);