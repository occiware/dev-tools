Install and Configure Eclipse
=============================
This documentation will guide you to install and configure your Eclipse environment with the necessary plugins needed to run the OCCIware project.

* Download an Eclipse Mars http://www.eclipse.org/downloads/packages/eclipse-ide-java-developers/marsr
* Launch Eclipse : "/eclipse$ ./eclipse"
* In eclipse: install the following tools from http://download.eclipse.org/releases/mars: Mylyn WikiText (for Wiki syntax support, normally pre-installed/in-built eclipse mars vers), Eclipse Modeling Framework (EMF SDK & EMF COMPARE), Acceleo Core SDK, Xtext Complete SDK, Sirius Specification Environment (check that Sirius Runtime is included), OCL Examples and Editors SDK
* In the workspace directory: git-clone the main project https://github.com/occiware/ecore (containing all projects). For example : "/workspace$ git clone git@github.com:occiware/ecore.git"
* In eclipse: import the all projects from "/workspace/ecore" directory (File > Import > Existing Project into Workspace)
* if there are still compile errors, close projects that are in "trash" and "xtext" path (including occi2ecore, clouddesigner.occi.runtime) if they don't compile. Check also the Java version (click right > properties).
NB. As we are using provided eclipse tools, these "ecore" projects are not for compilation.

Getting started :
-----------------
* to start OCCIware Studio, in the installed Eclipse (see "Install and Configure Eclipse"), right click on any project > Run as Eclipse Application
* in it, open "Modeling" perspective (window > perspective > open perspective > other > Modeling)
* to create new modeling project : File > New > Other > (Cloud Designer > OCCI Extension Project)
* to add new configuration files : File > New > Other > (Cloud Designer > OCCI Configuration File), then select the parent folder and extentions. Start modeling some new OCCI models.


Example of use - linked-data :
------------------------------
* to create new modeling project : menu File > New > Other > (Cloud Designer > OCCI Extension Project) and enter the following :

    name : org.occiware.linkeddata
    extention name : linked-data
    extention scheme: http://www.occiware.org/scheme/linked-data# (don't forget the # sharp)

   * 20150612 FEEDBACK missing : delete, change parent using mouse (but can be done in properties), constraint on link's source & target in metamodel (now in OCL)

* using designer Palette & mouse : outside the base "core" Extension, create Project & Model kinds, and their parent relationships to Resource ; create ProjectToModelLink kind, and its parent relationship to Link. Fill their terms and titles (ex. project & Project Resource for Project kind).
   * NB. OCCI mixins are similar but not exactly the same thing as Datacore mixins.
* create DataType "Version" de type "long"
   * mutable=false means readonly (even if changeable / computed) 20150812 TODO Q DISAPPEARED, WHY ?
* for Project & Model kinds, create attribute "name". To Model kind only, create attributes "version" & "majorVersion" with Type as "Version[long]".
   * mutable=false means readonly (even if changeable / computed)
* right-click on the "*.occie" file > Generate > Generate doc (textile), XML (for configuring erocci) (LATER Generate Curl for POSTing OCCI Resources to a configured erocci server - TODO but only for conf & Generate Conf only for Docker). The files will be generated in "/src-gen" sub-directory.
   * 20150612 FEEDBACK generated stuff is missing generated type (& custom data types)

Advanced uses :
---------------
* to add constraints, specify them in OCL (within EMF, but won't be in exported OCCI) : either textual .ocl (but must be loaded each time with OCL > Load), or within textual .ecore
* to edit the modeler : edit occi.design/ OCCIware.odesign
* to add custom behaviours (computed attributes...) : generate EMF Java and code in it (this is the EMF way to do it)


