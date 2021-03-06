Install and Configure Eclipse
=============================
This documentation will guide you to install and configure your Eclipse environment with the necessary plugins needed to run the OCCIware project.

NB: Here is not described how to modify and/or compile the below mentioned "ecore" projects (but you can do it , under your own risk, if you really need it).

1. download an Eclipse Mars http://www.eclipse.org/downloads/packages/eclipse-ide-java-developers/marsr 
2. launch Eclipse : "/eclipse$ ./eclipse"
3. in eclipse: install the following tools from http://download.eclipse.org/releases/mars: Mylyn WikiText (for Wiki syntax support, normally pre-installed/in-built eclipse mars vers), Eclipse Modeling Framework (EMF SDK & EMF COMPARE), Acceleo Core SDK, Xtext Complete SDK, Sirius Specification Environment (check that Sirius Runtime is included), OCL Examples and Editors SDK.
4. in the workspace directory: git-clone the main project https://github.com/occiware/ecore (containing all projects). For example : "/workspace$ git clone git@github.com:occiware/ecore.git"
5. in eclipse: import the all projects from "/workspace/ecore" directory (File > Import > Existing Project into Workspace).
6. verify that there are no errors on compiled projects. If errors are marked and the projects can't compile, close projects that are in "trash" and in "xtext" path (including occi2ecore, clouddesigner.occi.runtime). Also check the Java (JRE) version (right-click on project > properties).

NOTE: with MACOS, you must launch eclipse with the following options:
./Eclipse.app/Contents/MacOS/eclipse --launcher.ini ./Eclipse.app/Contents/MacOS/eclipse.ini 
Otherwise this will lead to memory issues.

### Install and launch Obeo's CloudDesigner version (beta)

A new Eclipse based OCCIware CloudDesigner can be downloaded (eclipse IDE containing all required files) in: TODO

1. Unzip the bundle, then launch the eclipse application (./eclipse).
  - In case you cannot launch the eclipse, you can try by changin the file permissons (cd ~/folder/where/you/unpacked-it ; chmod +x ./eclipse ; ./eclipse)
2. Select the workspace (you can type "./workspace" to put the data under the CloudDesigner installation directory.)

Getting started :
-----------------
Here is explained how to create and configure a very basic Extention model.

1. to start OCCIware Studio, in the installed Eclipse (see "Install and Configure Eclipse"), right click on any project > Run as Eclipse Application
2. in it, open "Modeling" perspective (window > perspective > open perspective > other > Modeling)
3. Start modeling some new OCCI models.
   - to create new modeling project : File > New > Other > (Cloud Designer > OCCI Extension Project)
   - to add new configuration files (models) : File > New > Other > (Cloud Designer > OCCI Configuration File), then select the parent folder and extentions. 
   - to import existing modeling projects : File > Import > (Existing Projects into Workspace)



Usage example - linked-data :
------------------------------
Here is explained how to create and configure a "Liked-Data Extention" simple model, which should illustrate the way of working with OCCIware tools.

* to create new modeling project : menu File > New > Other > (Cloud Designer > OCCI Extension Project) and enter the following :
    - name: org.occiware.linkeddata
    - extention name: linked-data
    - extention scheme: http://www.occiware.org/scheme/linked-data# (don't forget the # sharp)

* using the designer view "Palette" (outside the base "core" Extension witch a faded-in gray rectangle shape) :
  * create kinds "Project", "Model" and add their parent relationships to "Resource"
  * create kind  "ProjectToModelLink" and add its parent relationship to "Link"
  * for all created kinds, fill their terms and titles (ex. for "Project" => term="project", title="Project Resource").
  * create DataType "Version" as type "long" 
  * create attributes :
    - "name" for "Project" & "Model" kinds
    - "version" & "majorVersion" with Type as "Version[long]" for "Model" kind only
* generate configuration and docs files : right-click on the "*.occie" file > Generate > Generate doc (textile), & XML (for configuring erocci) (LATER Generate Curl for POSTing OCCI Resources to a configured erocci server - TODO but only for conf & Generate Conf only for Docker). The files will be generated in "/src-gen" sub-directory.

Important notes : 
  * *20150612 FEEDBACK generated stuff are missing: generated type (& custom data types)*
  * *20150612 FEEDBACK missing : delete or change parent using mouse (but can be done in properties), constraint on link's source & target in metamodel (now in OCL)*
  * *OCCI mixins are similar but not exactly the same thing as Datacore mixins.*
  * *mutable=false means readonly (even if changeable / computed). 20150812 TODO Q DISAPPEARED, WHY ?*

![Liked-data model - sample image.](/eclipse/images/linked-data.png)

Advanced uses :
---------------
Other interesting fonctions on using dev-tools.

* to add constraints, specify them in OCL (within EMF, but won't be in exported OCCI) : either textual .ocl (but must be loaded each time with OCL > Load), or within textual .ecore
* to edit the modeler : edit occi.design/ OCCIware.odesign
* to add custom behaviours (computed attributes...) : generate EMF Java and code in it (this is the EMF way to do it)

Generate code from models using Acceleo (on Obeo's CloudDesigner) :
-----------------------------------------
The following steps allow to create an Acceleo generator based on the OCCI metamodel:
- File > New > Acceleo Project
- Select a project name (or use the default one, juste ensure it does not already exists)
- Click "Next"

![Acceleo Project](/eclipse/images/generator1.png)

In the next window you have to set the generator options :

![Generator](/eclipse/images/generator2.png)

- Click on finish. This will open the Acceleo perpspective.
- Modify the *.mtl file with whatever you want to put in the file.

Then to execut the generator manually do as next:
- In the new project, open the "generate.mtl" file from the navigator view (left panel). This file is located under the src/ directory, in the <project_name>.main package
- Set the generated file name. This can be a dynamic expression, e.g.:
	file (extension.name, false, 'UTF-8')
	or a static one:
	file ('configuration.xml', false, 'UTF-8')
 (this example is on purpose, as a Configuration doesn't have any attribute usable to generate a distinct name)
- Inside of the "file" markups, write the generator: static text, dynamic text using ocl generation, templates calls.. 
	Please refer to the acceleo documentation for more informations on how to write a generator.
	The extension documentation generator can be used as an inspiration: https://github.com/occiware/ecore/blob/master/clouddesigner/org.occiware.clouddesigner.occi.gen.doc/src/org/occiware/clouddesigner/occi/gen/doc/main/generate.mtl

- To test the generator, right-click on the "generate.mtl" file et select "Run as > Launch Acceleo application"
- Add the OCCI metamodel URI: click on the "+" button then select "http://schemas.ogf.org/occi"
- Select the input model (delete the "xmi" filter in the dialog in order to display all files), to use (the root type of the generator): Extension or Configuration (depending whether you want to generate from an occie or occic extension)

![Add the OCCI metamodel URI](/eclipse/images/generator3.png)

![Select the root type of the generator](/eclipse/images/generator4.png)

- And select the Target (project) directory where the generated files are going to be stored.

![Select the root type of the generator](/eclipse/images/generator5.png)

- Check the "Main template" & "Generate file" options
- Configuration : Runner => Java Application
- Then click "Run".
- Open the generated file in the target directory to check the result
![Select a](/eclipse/images/generator6.png)

Tip: To ease the development of the generator, you can open both generator and result files and drag one of them in order to have both in view at the same time.
To relaunch a generation, when the focus is on the generate.mtl file hit CTRL+F11 
