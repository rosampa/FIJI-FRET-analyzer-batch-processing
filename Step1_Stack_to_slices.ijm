//This small makro will sort your time lapse stack into individual slices for pixel-by-pixel calculations needed for FRET analysis 
// In order for it to work must create yourself a "template" directory with the following 
// folders
//		Folder				Folder					Folder
// "Your sample name" -> - "CFP"			--> "Raw"
//
//						 - "FRET"			--> "Raw"
//						
//						-  "CFP-8bit" (this will be used in the macro for fret analysis)
//						-  "FRET-8bit" (this will be used in the macro for fret analysis)
//						-  "Results" (this will be used in the macro for fret analysis)
//
// Open your time lapse stack with "split channels" and save the channel stacks with the exact names ("FRET", "CFP") 
// in the raw subdirectorys of the respective folders. 
//If you have created this template folder just copy it for every sample you have.
//To start just activate the macro, it will ask you for the number of slides you have (timepoints) and the "your sample name" folder.

// Creates dialog window where you define the number of slices in your stack, is saved as variable "slices" and used later in the 
//for loop as total number of iterations

Dialog.create("How many slices in stack?");
Dialog.addNumber("Number of slices", 250);
Dialog.show();
Slices = Dialog.getNumber();



//Loop to choose input and output, saving all slices of a stack separatly with their respective numbers appended to them
// this is for FRET

dir1 = getDirectory("Choose sample directory ");
dir= dir1 + "FRET/Raw/";
dir2 = dir1 + "FRET/";

setBatchMode(true);
count = 0;
countFiles(dir);
n = 0;
processFiles(dir);

function countFiles(dir) {
    list = getFileList(dir);
    for (i=0; i<list.length; i++) {
        if (endsWith(list[i], "/"))
            countFiles(""+dir+list[i]);
        else
            count++;
    }
}

function processFiles(dir) {
    list = getFileList(dir);
    for (i=0; i<list.length; i++) {
        if (endsWith(list[i], "/"))
            processFiles(""+dir+list[i]);
        else {
            showProgress(n++, count);
            path = dir+list[i];
            processFile(path);
        }
    }

function processFile(path) {
    if (endsWith(path, ".tif")) {
        open(path);
        title=getTitle();
        len = lengthOf(title);
        lenPath = lengthOf(path);
        path = substring(path, 0, lenPath-len);
        for(i=1;i<=Slices; i++){
          newTitle = " Slice "+i;
          newPath = dir2+newTitle;
          run("Select All");
          setSlice(i);
          run("Duplicate...", " ");
          saveAs("Tiff", newPath);
          close();
         
        }
      close();
    }
} 
setBatchMode(false);





//Loop to choose input and output, saving all slices of a stack separatly with their respective numbers appended to them
// this is for CFP

dir3 = dir1 + "CFP/Raw/";
dir4= dir1 + "CFP/"; 
setBatchMode(true);
count2 = 0;
countFiles2(dir3);
n2 = 0;
processFiles2(dir3);

function countFiles2(dir3) {
    list2 = getFileList(dir3);
    for (p=0; p<list2.length; p++) {
        if (endsWith(list2[p], "/"))
            countFiles(""+dir3+list2[p]);
        else
            count2++;
    }
}

function processFiles2(dir3) {
    list2 = getFileList(dir3);
    for (p=0; p<list2.length; p++) {
        if (endsWith(list2[p], "/"))
            processFiles2(""+dir3+list2[p]);
        else {
            showProgress(n2++, count2);
            path2 = dir3+list2[p];
            processFile2(path2);
        }
    }
    
function processFile2(path2) {
    if (endsWith(path2, ".tif")) {
        open(path2);
        title2=getTitle();
        len2 = lengthOf(title2);
        lenPath2 = lengthOf(path2);
        path2 = substring(path2, 0, lenPath2-len2);
        for(p=1;p<=Slices; p++){
          newTitle2 = " Slice "+p;
          newPath2 = dir4+newTitle2;
          run("Select All");
          setSlice(p);
          run("Duplicate...", " ");
          saveAs("Tiff", newPath2);
          close();
         
        }
      close();
    }
} 
setBatchMode(false);


