/*
* Copyright 2013 Sebastian Kügler <sebas@kde.org>
* Copyright 2015 Beat Küng <beat-kueng@gmx.net>
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public License as
* published by the Free Software Foundation; either version 2 of
* the License or (at your option) version 3 or any later version
* accepted by the membership of KDE e.V. (or its successor approved
* by the membership of KDE e.V.), which shall act as a proxy
* defined in Section 14 of version 3 of the license.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http: //www.gnu.org/licenses/>
*/

import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

Item {
    id: root

    width: childrenRect.width
    height: childrenRect.height
    implicitWidth: pageColumn.implicitWidth
    implicitHeight: pageColumn.implicitHeight

    property alias cfg_widgetWidth: widgetWidth.value
    property alias cfg_displayArtist: root.displayArtistPosition

    property int displayArtistPosition: 0

    ColumnLayout {
        id: pageColumn
        GroupBox {
            Layout.fillWidth: true

            title: i18n("Size")
            flat: true

            ColumnLayout {
                Layout.fillWidth: true

                RowLayout {
                    Layout.fillHeight: false

                    Label {
                        text: i18n("Widget width: ")
                    }

                    SpinBox {
                        id: widgetWidth
                        minimumValue: 100
                        maximumValue: 2000
                    }
                }
            }
        }

        GroupBox {
            Layout.fillWidth: true

            title: i18n("Display")
            flat: true

            ExclusiveGroup {
                id: displayArtistPositionGroup
                onCurrentChanged: {
                    root.displayArtistPosition = current.type;
                }
            }

            RowLayout {
                RadioButton {
                    id: displayNone
                    checked: root.displayArtistPosition === 0
                    exlusiveGroupe: displayArtistPositionGroup

                    readonly property int type: 0
                }
            }

            RowLayout {
                RadioButton {
                    id: displayBelow
                    checked: root.displayArtistPosition === 1
                    exlusiveGroupe: displayArtistPositionGroup

                    readonly property int type: 1
                }
            }

            RowLayout {
                RadioButton {
                    id: displayBefore
                    checked: root.displayArtistPosition === 2
                    exlusiveGroupe: displayArtistPositionGroup

                    readonly property int type: 2
                }
            }

            RowLayout {
                RadioButton {
                    id: displayAfter
                    checked: root.displayArtistPosition === 3
                    exlusiveGroupe: displayArtistPositionGroup

                    readonly property int type: 3
                }
            }
        }

    }
}
}