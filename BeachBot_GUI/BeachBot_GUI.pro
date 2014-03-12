# Add more folders to ship with the application, here
folder_01.source = qml/BeachBot_GUI
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qml/BeachBot_GUI/JoyStick.qml \
    qml/BeachBot_GUI/JoyStick_BackGround.qml \
    qml/BeachBot_GUI/JoyStick_Screen.qml \
    qml/BeachBot_GUI/JoyStick_Mover.qml \
    qml/BeachBot_GUI/JoyStick_Button.qml \
    qml/BeachBot_GUI/JoyStickTest.qml \
    qml/BeachBot_GUI/xmlRequestTest.qml
