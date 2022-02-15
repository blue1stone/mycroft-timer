        // Copyright 2021, Mycroft AI Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.3

Rectangle {
    property color backgroundColor
    property var timerInfo
    property int timerCount
    property real timerOpacity: 1.0

    color: {
        if (timerInfo) {
            backgroundColor
        } else {
            "transparent"
        }
    }
    height: {
        if (timerCount <= 2) {
            return gridUnit * 26
        } else {
            return gridUnit * 12
        }
    }
    radius: 16
    width: {
        if (timerCount === 1) {
            return gridUnit * 46
        } else {
            return gridUnit * 22
        }
    }
    opacity: {
        if (timerInfo && timerInfo.expired) {
            return timerOpacity
        } else {
            return 1.0
        }
    }
    /* Flash the background when the timer expires for a visual cue */
    SequentialAnimation on timerOpacity {
        id: expireAnimation
        running: timerInfo ? timerInfo.expired : false
        loops: Animation.Infinite
        PropertyAnimation {
            from: 1;
            to: 0.25;
            duration: 500
        }
        PropertyAnimation {
            from: 0.25;
            to: 1;
            duration: 500
        }
    }

    Item {
        id: timerName
        anchors.top: parent.top
        height: {
            if (timerCount <= 2) {
                return gridUnit * 5
            } else {
                return gridUnit * 3
            }
        }
        width: parent.width

        Label {
            id: timerNameValue
            anchors.baseline: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#2C3E50"
            font.family: "Noto Sans"
            font.pixelSize: {
                if (timerCount <= 2) {
                    return 60
                } else {
                    return 40
                }
            }
            font.styleName: "Bold"
            text: timerInfo ? timerInfo.timerName : ""
        }
    }

    Item {
        id: timeDelta
        anchors.top: timerName.bottom
        height: {
            if (timerCount == 1) {
                return gridUnit * 12
            } else if (timerCount == 2) {
                return gridUnit * 10
            } else {
                return gridUnit * 5
            }
        }
        width: parent.width

        Label {
            id: timeDeltaValue
            anchors.baseline: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Noto Sans"
            font.pixelSize: {
                if (timerCount === 1) {
                    return 180
                } else if (timerCount === 2) {
                    return 100
                } else {
                    return 60
                }
            }
            font.styleName: "Bold"
            text: timerInfo ? timerInfo.timeDelta : ""
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        color: {
            if (timerInfo) {
                "#FD9E66"
            } else {
                "transparent"
            }
        }
        height: gridUnit * 2
        radius: 16
        width: timerInfo ? parent.width * timerInfo.percentRemaining : 0
    }
}
