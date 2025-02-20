import QtQuick.Dialogs

MessageDialog  {
    id: root
    property bool firstTimeRun : true
    buttons: MessageDialog.Ok
    text:{
        return "Welcome!\n"+
                "It looks like this is your first time running SainoHelicopter.\n"}
    detailedText: {
        return "You can use the selector on the right hand side by drag and drop or up and down keys.\n"+
                "You can open the control panel window by pressing the space key."
    }
    onButtonClicked: {
        root.firstTimeRun = false;
    }
    onAccepted: {
        root.firstTimeRun = false;
    }
    onRejected: {
        root.firstTimeRun = false;
    }
}
