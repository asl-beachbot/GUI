# Add more folders to ship with the application, here
folder_01.source = qml/CanvWithElements
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

QT += core qml quick websockets

QT += websockets

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

QT += svg
QTPLUGIN += qsvg

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qml/CanvWithElements/DrawingArea.qml \
    qml/CanvWithElements/Layer1.qml \
    qml/CanvWithElements/Layer2.qml \
    qml/CanvWithElements/Star.qml
