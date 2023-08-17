# Introduction
The goal of this project is to create complex software systems by composing reusable model transformations.   

# Files
The file "project.xml" serves as the input model (PIM), which is obtained from the Visual Paradigm project presented at Docs/StationServiceSystem.vpp. The PIM has already been parameterized with the PDMs of the clean architecture and observer design pattern.

# How to test
1.	Install the transformation engine (SaxonHE9.9N), see the Docs folder for the exe.
2.	Install Java (jdk-11.0.9).
3.	Modify the locations for Saxon and Java. Refer to the two variables "SaxonLocation" and "JavaLocation" in the file "cmd.bat."
4.	Execute the file "cmd.bat."
5.	The result of the transformation execution can be found in the "Output" folder:
   - Models: Contains the partial PSMs resulting from the execution of the SITs (system-independent transformation) of a given SST (system-specific transformation).
   - MergedModel.xml: Result of merging the partial PSMs.
   - Code: The generated code, which is the result of the M2T transformations.

