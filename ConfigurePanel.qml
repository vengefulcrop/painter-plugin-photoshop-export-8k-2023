import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import AlgWidgets 2.0

AlgDialog {
  id: configureDialog
  visible: false
  title: qsTr("Configure")
  width: 500
  height: 220
  minimumWidth: 400
  minimumHeight: 220

  function reload() {
    content.reload()
  }

  onAccepted: {
    if (path.text != "...") {
			alg.settings.setValue("photoshopPath", path.text);
		}
		alg.settings.setValue("launchPhotoshop", launchPhotoshopCheckBox.checked);
		alg.settings.setValue("padding", paddingCheckBox.checked);
        var index = bitDepthComboBox.currentIndex
        alg.settings.setValue("bitDepth", bitDepthModel.get(index).value);
        var resIndex = resolutionComboBox.currentIndex
        var resValueString = resolutionModel.get(resIndex).value;
        var resArray = resValueString.split(',').map(function(item) { return parseInt(item, 10); });
        alg.settings.setValue("resolutionOverride", resArray);
  }

  Rectangle {
    id: content
    parent: contentItem
    anchors.fill: parent
    anchors.margins: 12
    color: "transparent"
    clip: true

    function reload() {
      path.reload()
      launchPhotoshopCheckBox.reload()
      paddingCheckBox.reload()
      bitDepthComboBox.reload()
      resolutionComboBox.reload()
    }

    AlgScrollView {
      id: scrollView
      anchors.fill: parent

      ColumnLayout {
        spacing: 18
        Layout.maximumWidth: scrollView.viewportWidth
        Layout.minimumWidth: scrollView.viewportWidth

        ColumnLayout {
          spacing: 6
          Layout.fillWidth: true

          AlgLabel {
            text: qsTr("Path to Photoshop")
            Layout.fillWidth: true
          }

          RowLayout {
            spacing: 6
            Layout.fillWidth: true

            AlgTextEdit {
              id: path
              borderActivated: true
              wrapMode: TextEdit.Wrap
              readOnly: true
              Layout.fillWidth: true

              function reload() {
                text = alg.settings.value("photoshopPath", "...")
              }

              Component.onCompleted: {
                reload()
              }
            }

            AlgButton {
              id: searchPathButton
              text: qsTr("Set path")
              onClicked: {
                // open the search path dialog
                searchPathDialog.setVisible(true)
              }
            }
          }
        }

        RowLayout {
          spacing: 6
          Layout.fillWidth: true

          AlgLabel {
            text: qsTr("Launch photoshop after export")
            Layout.fillWidth: true
          }

          AlgCheckBox {
            id: launchPhotoshopCheckBox

            function reload() {
              checked = alg.settings.value("launchPhotoshop", false);
            }

            Component.onCompleted: {
              reload()
            }
          }
        }

        RowLayout {
          spacing: 6
          AlgLabel {
            text: qsTr("Enable padding")
            Layout.fillWidth: true
          }

          AlgCheckBox {
            id: paddingCheckBox

            function reload() {
              checked = alg.settings.value("padding", false);
            }

            Component.onCompleted: {
              reload()
            }
          }
        }

        RowLayout {
          spacing: 6
          Layout.fillWidth: true

          AlgLabel {
            text: qsTr("Export bitdepth")
            Layout.fillWidth: true
          }

          AlgComboBox {
            id: bitDepthComboBox
            textRole: "key"
            Layout.minimumWidth: 150

            model: ListModel {
              id: bitDepthModel
              ListElement { key: qsTr("8 bits"); value: 8 }
              ListElement { key: qsTr("16 bits"); value: 16 }
            }
            function reload() {
              var bitdepth_setting = alg.settings.value("bitDepth", 8);
              if (bitdepth_setting === 16) {
                currentIndex = 1;
              } else {
                currentIndex = 0;
              }
            }
            Component.onCompleted: {
              reload()
            }
          }
        }

        RowLayout {
          spacing: 6
          Layout.fillWidth: true

          AlgLabel {
            text: qsTr("Resolution Override")
            Layout.fillWidth: true
          }

          AlgComboBox {
            id: resolutionComboBox
            textRole: "key"
            Layout.minimumWidth: 150

            model: ListModel {
              id: resolutionModel
              ListElement { key: qsTr("Texture Set Size"); value: "-1,-1" }
              ListElement { key: qsTr("512x512"); value: "512,512" }
              ListElement { key: qsTr("1024x1024"); value: "1024,1024" }
              ListElement { key: qsTr("2048x2048"); value: "2048,2048" }
              ListElement { key: qsTr("4096x4096"); value: "4096,4096" }
              ListElement { key: qsTr("8192x8192"); value: "8192,8192" }
            }
            function reload() {
              var resolutionSettingArray = alg.settings.value("resolutionOverride", [8192, 8192]);
              var resolutionSettingString = resolutionSettingArray.join(',');
              for (var i = 0; i < resolutionModel.count; ++i) {
                var currentModelValueString = resolutionModel.get(i).value;
                if (resolutionSettingString === currentModelValueString) {
                  currentIndex = i;
                  break
                }
              }
            }
            Component.onCompleted: {
              reload()
            }
          }
        }
      }
    }
  }

  FileDialog {
    id: searchPathDialog
    title: qsTr("Choose a Photoshop executable file...")
    nameFilters: [ "Photoshop files (*.exe *.app)", "All files (*)" ]
    selectedNameFilter: "Executable files (*)"
    onAccepted: {
      path.text = alg.fileIO.urlToLocalFile(fileUrl.toString())
    }
    onVisibleChanged: {
      if (!visible) {
        configureDialog.requestActivate();
      }
    }
  }
}
