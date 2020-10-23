# Using FME Workbench for combining AB Core CSV tiles

### The FME Workbench can be found [here](https://github.com/OrdnanceSurvey/OS-ABcore-AOI/blob/main/ABCore_AOICSV_combine.fmw) 

#### Access The Workbench
To access the workbench, you can download the repository as a .zip file.  
  * In the repository, click the green button in the top right-hand corner labelled 'code'.  
  * At the bottom of the dropdown, select 'Download zip'. This will download the entire repository into your local folders.

#### Running the Workbench
Once the workbench is open, 3 boxes will appear. In the box labelled 'ABCore CSVs', you will find a reader called 'CSV'.   
  * Right-click on the reader and select 'Edit...Parameters'
  * To the right of the 'Source CSV File' box is three dots. Select this and proceed to the zip files you would like to load. **These zip files do not need to be unzipped**. Select all zip folders and click ok, and ok again.    

In the box labelled ABCore Combined CSVs, you will find a writer named 'ABCore_TILED_Combined'
  * Right-click on this writer and select 'Edit...Parameters'.  
  * Select the folder you would like to save the combined CSV to. Click ok, and ok again.  

Press the green 'Run' button to run the workbench.
