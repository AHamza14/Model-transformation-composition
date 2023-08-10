@REM Saxon engin and java locations
set SaxonLocation="C:\Program Files\Saxonica\SaxonHE9.9N\bin\Transform"
set JavaLocation="C:\Program Files\Java\jdk-11.0.9\bin\java.exe"

@REM Specify the source code output directories
set OutputCoreCode="D:\Hamza\PHD\RE\important\Articles\Journaux\5. Model Transformation Composition\StationServiceSystem\StationServiceSystem.Core"
set OutputInfraCode="D:\Hamza\PHD\RE\important\Articles\Journaux\5. Model Transformation Composition\StationServiceSystem\StationServiceSystem.Infrastructure\"

@REM Remove output folder
RMDIR "Output" /S /Q

@REM M2M transformations (design-specific transformations)

%SaxonLocation% -t project.xml Design-transformations/SSTs/SST_clean_observer.xsl
@REM %SaxonLocation% -t project.xml Design-transformations/SSTs/SST_clean.xsl

@REM Merge PSMs
%JavaLocation% -jar XMLMergeTool.jar

@REM Generate code using M2T transformations
%SaxonLocation% -t Output/MergedModel.xml M2T/DotNET/class_m2t_template.xsl

%SaxonLocation% -t Output/Models/enumerations.xml M2T/DotNET/enumeration_m2t_template.xsl 

%SaxonLocation% -t  Output/MergedModel.xml M2T/DotNET/interface_m2t_template.xsl

%SaxonLocation% -t  Output/Models/clean_architecture_projects.xml M2T/DotNET/dotnet_project_template.xsl

%SaxonLocation% -t  project.xml M2T/DotNET/base_specification_template.xsl

%SaxonLocation% -t  project.xml M2T/DotNET/util_template.xsl

%SaxonLocation% -t  project.xml M2T/DotNET/infra_ef_repository_template.xsl

%SaxonLocation% -t  project.xml M2T/DotNET/infra_specification_evaluator_template.xsl

@REM Copy result code to the solution folder
xcopy /s "Output/Code/StationServiceSystem.Core" %OutputCoreCode% /Y
xcopy /s "Output/Code/StationServiceSystem.Infrastructure" %OutputInfraCode% /Y
