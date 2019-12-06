# XCreadouts
## Plots for Thermo Orbitrap instrument logs

This is a small package to help users of Thermo Orbitrap Q Exactive instruments access and plot some of the instrument readback logs.
Some of these kinds of readbacks are readily available in Waters MassLynx software, but for some reason are not available in a ready and intuitive format for the Orbitraps.
These readbacks can be really helpful for instrument issue diagnostics and checking why there might be some unexplained glitch in your data.

In order to be most use, XCreadouts is meant to be agnostic to what comes out of the logfile, other than that the data should be numeric apart from the logdate. Please do let me know if you encounter any bugs by sending the error message and some of your logfiles ideally.

The functions still need testing for other Thermo instruments. I'm totally happy to incorporate testing for this, drop me a mail if you'd like it incorporated.

On our instrument, the available readbacks include: 
-instrument up-time
-turbomolecular readbacks (°C, mBar, voltages, currents, including motors and bearings)
-ambient temperature and humidity
-capillary temperature
-various other instrument temperatures like heatsinks, the capillary, analyzer and quad detector
-various other instrument voltages like flatapoles and C-trap

You'll need to locate the logfiles on your instrument. For Exactive instruments, these should be on your instrument PC in C:/Xcalibur/system/Exactive/log (substitute the instrument name as appropriate, make sure you can manually locate the log folder first).
           
### How to use XCreadouts
Download the R folder in the repo for now - it will be made into an R package/Python version/standalone exe as soon as I get round to it.

Open the runXCreadouts file, and run the whole script. You will then be prompted to input the furthest date back in time that you want to check, so if you enter today's date (e.g. 2019-12-06) then it will plot all the logs from today only; if you input e.g. 2019-12-06 then it will produce everything from the last year.
The longer the date range, the more the function will struggle to produce the plot, so consider how much information you really need.
I will adjust so the last date can be other than the most recent file soon.

Prompt:
Enter required date as year-month-day, e.g. 2019-11-11: 2019-12-01

Which will then return all the column names of the data contained within the logs like so:

 [1] "Time [sec]"                                      
 [2] "Date"                                            
 [3] "Up-Time [days]"                                  
 [4] "Vacuum 1 (HV) [mbar]"                            
 [5] "Vacuum 2 (UHV) [mbar]"                           
 [6] "Vacuum 3 (Fore) [mbar]"                          
 [7] "Vacuum 4/humidity [mbar]"                        
 [8] "TURBO1_TEMP_BEARING_R [°C]"
 ...
 
 You will then be prompted to input the number of the readback type for the plot. So, if you wanted to plot [4] "Vacuum 1 (HV) [mbar]":
 
 44] "Analyzer temp sensor (filtered) [°C]"            
[45] "Analyzer temperature (with delay model) [°C]"    
[46] "CEPS Peltier temperature sensor [°C]"            
[47] "Quad Detector Temperature [°C]"                  
[48] ""                                                
Enter required column: 4

The plot will then be produced automatically, and stored in a folder called "Readback plots" inside your instrument log folder as a web-browser viewable HTML file. You can then save this as a PNG file in the browser. I will add in functionality to produce and save a high-res JPEG file soon.

![Example image of ambient temp readout](https://github.com/katewolfer/XCreadouts/blob/master/examples/test%20ambient.png)
