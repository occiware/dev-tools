Install and Configure Eclipse
=============================
This documentation will guide you to install and configure your Eclipse environment with the necessary plugins needed to run the OCCIware project.

Windows, Linux
--------------
* Download the Eclipse installer, which corresponds to your platform here: https://wiki.eclipse.org/Eclipse_Installer.
* Launch the installer.
* Switch in advanced mode.
* On the `Product` page choose `Eclipse IDE for Java Developers` and `Latest release (Luna)` (about to change) and click the `Next` button.
* On the `Project` page choose `Eclipse.org` and click on the `+` button situated on the top of the page and paste this URL: https://raw.githubusercontent.com/occiware/ecore/master/clouddesigner/org.occiware.clouddesigner.dev/OcciwareDev.setup
* Follow the instructions to finish the settings.

Manual installation (including Mac)
-----------------------------------
* Download an Eclipse Luna https://www.eclipse.org/downloads/packages/eclipse-ide-java-developers/lunasr2
* Launch Eclipse 
* Install the following tools from http://download.eclipse.org/releases/luna: Mylyn WikiText (for Wiki syntax support), EMF SDK, OCL Examples and Editors SDK, Acceleo Core SDK, Xtext Complete SDK, Sirius Runtime IDE, Sirius Specification Environment
* Then install the K3 feature (for the Docker Connector) from http://www.kermeta.org/k3/update/ (only once previous deps have been installed, otherwise they will be)
* Then install Sirius OCL from sirius luna nightly update site http://download.eclipse.org/sirius/updates/nightly/latest/luna
* if there are still compile errors, close projects that are in "trash" and "xtext" path (including occi2ecore, clouddesigner.occi.runtime) if they don't compile

Getting started :
-----------------
* to start OCCIware Studio, in the installed Eclipse, right click > run as eclipse application
* in it, open "Modeling" perspective
* click on File > New > Others... > Cloud Designer > OCCI Extension Project (LATER : also OCCI Configuration File) to start modeling some new OCCI models

Example of use - linked-data :
------------------------------
* click on File > New > Others... > Cloud Designer > OCCI Extension Project (LATER : also OCCI Configuration File) and enter the following :

    org.occiware.linkeddata
    linked-data
    http://www.occiware.org/scheme/linked-data# (don't forget the # sharp)

   * 20150612 FEEDBACK missing : delete, change parent using mouse (but can be done in properties), constraint on link's source & target in metamodel (now in OCL)

* using designer Palette & mouse : create Project & Model kinds, and their parent relationships to Resource ; create ProjectToModelLink, and its parent relationship to Link. Fill their terms and titles (ex. project & Project Resource for Project kind). NB. OCCI mixins are similar but not exactly the same thing as Datacore mixins.
* create DataType Version long : mutable=false means readonly (even if changeable / computed)
* create "name" attributes on Project & Model kinds, and version & majorVersion attributes with DataType Version on Model kind
* right-click on extension > Generate > Textile from OCCI extension OR Acceleo Model to Text > Generate doc (textile), XML (for erocci) (BUT Curlfor erocci but only for conf & Conf only for Docker)
   * 20150612 FEEDBACK generated stuff is missing generated type (& custom data types)

Advanced uses :
---------------
* to add constraints, specify them in OCL (within EMF, but won't be in exported OCCI) : either textual .ocl (but must be loaded each time with OCL > Load), or within textual .ecore
* to edit the modeler : edit occi.design/ OCCIware.odesign
* to add custom behaviours (computed attributes...) : generate EMF Java and code in it (this is the EMF way to do it)


