import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtMultimedia 5.5
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.3
import QtQml.Models 2.2

import FileIO 1.0
import DataObject 1.0

ApplicationWindow {
    visible: true
    width: 1024
    height: 768
    title: qsTr("智能监控系统演示")

    FileDialog {
        id: fileDialog
        title: "选择一个视频文件"
        folder: shortcuts.home
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrl)
            video.source = fileDialog.fileUrl
            textField1.text = fileDialog.fileUrl
            progressBar.value = 0
            for_show_model.clear()
            all_event_model.clear()
            console.log("Video Duration: ", video.duration)
            simpletimer.interval = 500
            simpletimer.start()
        }
        onRejected: {
            console.log("Canceled")
        }
        Component.onCompleted: visible = false
    }



    ProgressBar {
        id: progressBar
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 64
        anchors.top: parent.top
        width: 306
        height: 14
        indeterminate: false
    }

    GridLayout {
        id: grid
        columns: 1
        anchors.horizontalCenterOffset: 340
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 128
        anchors.top: parent.top

        Text {
            id: gender
            text: qsTr("性别:")
            verticalAlignment: Text.AlignTop
            font.bold: true;
        }
        RowLayout {
                CheckBox {
                    id: male
                    text: qsTr("男性")
                    checkable: true
                }
                CheckBox {
                    id: female
                    text: qsTr("女性")
                    checkable: true
                }
        }

        Text {
            id: age
            text: qsTr("年龄:")
            verticalAlignment: Text.AlignTop
            font.bold: true;
        }
        RowLayout
        {
            CheckBox {
                id: youth
                text: qsTr("小孩")
                checkable: true
            }
            CheckBox {
                id: mid_age
                text: qsTr("成年")
                checkable: true
            }
            CheckBox {
                id: senior
                text: qsTr("老年")
                checkable: true
            }
        }

        Text {
            id: clothes_color
            text: qsTr("服装颜色:")
            verticalAlignment: Text.AlignTop
            font.bold: true;
        }
        GridLayout {
            columns: 3
            CheckBox {
                id: black
                text: qsTr("黑色")
                checkable: true
            }
            CheckBox {
                id: white
                text: qsTr("白色")
                checkable: true
            }
            CheckBox {
                id: blue
                text: qsTr("蓝色")
                checkable: true
            }
            CheckBox {
                id: red
                text: qsTr("红色")
                checkable: true
            }
            CheckBox {
                id: green
                text: qsTr("绿色")
                checkable: true
            }
            CheckBox {
                id: yellow
                text: qsTr("黄色")
                checkable: true
            }
        }

        Text {
            id: action
            text: qsTr("动作:")
            verticalAlignment: Text.AlignTop
            font.bold: true;
        }
        RowLayout
        {
            CheckBox {
                id: leave
                text: qsTr("遗留")
                checkable: true
            }
            CheckBox {
                id: run
                text: qsTr("跑动")
                checkable: true
            }
            CheckBox {
                id: sit
                text: qsTr("坐下")
                checkable: true
            }
        }

        Text {
            id: object
            text: qsTr("物品:")
            verticalAlignment: Text.AlignTop
            font.bold: true;
        }
        RowLayout
        {
            CheckBox {
                id: luggage
                text: qsTr("箱子")
                checkable: true
            }
            CheckBox {
                id: bag
                text: qsTr("提包")
                checkable: true
            }
            CheckBox {
                id: backpack
                text: qsTr("背包")
                checkable: true
            }
        }
        Button {
            id: button2
            text: qsTr("检索")
            onClicked: {
                console.log("Button2 Pressed")

                var tranlation = {
                    "male":"男性",
                    "female":"女性",
                    "child":"小孩",
                    "adult":"成年",
                    "senior":"老年",
                    "black":"黑色",
                    "white":"白色",
                    "blue":"蓝色",
                    "red":"红色",
                    "green":"绿色",
                    "yellow":"黄色",
                    "leave":"遗留",
                    "run":"跑动",
                    "sit":"坐下",
                    "luggage":"箱子",
                    "bag":"提包",
                    "backpack":"背包",
                    "no":"-"
                }

                video.stop()
                for_show_model.clear()
                var gender_list = []
                var age_list = []
                var color_list = []
                var action_list = []
                var object_list = []
                //gender
                if (male.checked)
                    gender_list.push("male")
                if (female.checked)
                    gender_list.push("female")
                //age
                if (youth.checked)
                    age_list.push("child")
                if (mid_age.checked)
                    age_list.push("adult")
                if (senior.checked)
                    age_list.push("senior")
                //color
                if (black.checked)
                    color_list.push("black")
                if (white.checked)
                    color_list.push("white")
                if (blue.checked)
                    color_list.push("blue")
                if (red.checked)
                    color_list.push("red")
                if (green.checked)
                    color_list.push("green")
                if (yellow.checked)
                    color_list.push("yellow")
                //action
                if (leave.checked)
                    action_list.push("leave")
                if (run.checked)
                    action_list.push("run")
                if (sit.checked)
                    action_list.push("sit")
                //object
                if (luggage.checked)
                    object_list.push("luggage")
                if (bag.checked)
                    object_list.push("bag")
                if (backpack.checked)
                    object_list.push("backpack")

                for(var i=0; i<all_event_model.count; i++)
                {
                    var gender_in = true
                    var age_in = true
                    var color_in = true
                    var action_in = true
                    var object_in = true
                    //console.log(all_event_model.get(i).gender)
                    var j = 0
                    //gender
                    for(;j<gender_list.length;j++)
                    {
                        if (all_event_model.get(i).gender === gender_list[j])
                            break
                    }
                    if (j==gender_list.length && gender_list.length>0)
                    {
                        gender_in = false
                        continue
                    }
                    //age
                    j = 0
                    for(;j<age_list.length;j++)
                    {
                        if (all_event_model.get(i).age === age_list[j])
                            break
                    }
                    if (j==age_list.length && age_list.length>0)
                    {
                        age_in = false
                        continue
                    }
                    //color
                    j = 0
                    for(;j<color_list.length;j++)
                    {
                        if (all_event_model.get(i).color === color_list[j])
                            break
                    }
                    if (j==color_list.length && color_list.length>0)
                    {
                        color_in = false
                        continue
                    }
                    //action
                    j = 0
                    for(;j<action_list.length;j++)
                    {
                        if (all_event_model.get(i).action === action_list[j])
                            break
                    }
                    if (j==action_list.length && action_list.length>0)
                    {
                        action_in = false
                        continue
                    }
                    //object
                    j = 0
                    for(;j<object_list.length;j++)
                    {
                        if (all_event_model.get(i).object === object_list[j])
                            break
                    }
                    if (j==object_list.length && object_list.length>0)
                    {
                        object_in = false
                        continue
                    }
                    if(gender_in && age_in && color_in && action_in && object_in)
                    {
                        //console.log("append", all_event_model.get(i))
                        var an_object = all_event_model.get(i)
                        tmp_data_object.name = an_object.name
                        tmp_data_object.time = an_object.time
                        tmp_data_object.gender = tranlation[an_object.gender]
                        tmp_data_object.age = tranlation[an_object.age]
                        tmp_data_object.color = tranlation[an_object.color]
                        tmp_data_object.action = tranlation[an_object.action]
                        tmp_data_object.object = tranlation[an_object.object]
                        tmp_data_object.coord = an_object.coord
                        for_show_model.append(tmp_data_object)
                    }
                }
            }
        }
    }

    Timer {
        id: simpletimer
        repeat: true
        running: false
        onTriggered: {
            progressBar.value < 1 ? progressBar.value += 0.1 : progressBar.value = 0.0
            if(progressBar.value>0.99)
            {
                simpletimer.stop()
                myFile.source = fileDialog.fileUrl.toString().substring(8, fileDialog.fileUrl.length)+".txt"
                console.log( myFile.source)
                var all_event_list = myFile.read()
                all_event_model.clear()
                for (var i = 0; i<all_event_list.length; i++)
                    all_event_model.append(all_event_list[i])
            }
        }
    }

    RowLayout {
        id: rowLayout1
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 14
        anchors.top: parent.top

        TextField {
            id: textField1
            placeholderText: qsTr("选择一个视频文件")
        }

        Button {
            id: button1
            text: qsTr("浏览")
            onClicked: {
                    console.log("Button1 Pressed.");
                    video.stop()
                    fileDialog.open()
            }
        }

    }

    TableView {
        id: list_table
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 580
        anchors.top: parent.top

        width: 930
        /*
        TableViewColumn {
            role: "idx"
            title: "序号"
            width: 60
        }*/
        TableViewColumn {
            role: "name"
            title: "文件名"
            width: 200
        }
        TableViewColumn {
            role: "time"
            title: "时间"
            width: 100
        }
        TableViewColumn {
            role: "gender"
            title: "性别"
            width: 100
        }
        TableViewColumn {
            role: "age"
            title: "年龄"
            width: 100
        }
        TableViewColumn {
            role: "color"
            title: "服装颜色"
            width: 100
        }
        TableViewColumn {
            role: "action"
            title: "动作"
            width: 100
        }
        TableViewColumn {
            role: "object"
            title: "行李"
            width: 100
        }
        model: for_show_model

        onDoubleClicked: {
            //frame.color = "transparent"
            //console.log(currentRow)
            video.stop()
            var time_start_end = for_show_model.get(currentRow).time.split("-")
            console.log("[start,end]:", time_start_end)
            start_end.start = parseInt(time_start_end[0].split(":")[0])*60*1000 + parseInt(time_start_end[0].split(":")[1])*1000
            start_end.end = parseInt(time_start_end[1].split(":")[0])*60*1000 + parseInt(time_start_end[1].split(":")[1])*1000
            var coord = for_show_model.get(currentRow).coord.split("-")
            bbox.width = 20
            bbox.height = 20
            bbox.x = parseFloat(coord[0])*bbox.parent.width
            bbox.y = parseFloat(coord[1])*bbox.parent.height
            bbox.radius = 10

            video.seek(start_end.start)
            video.play()
            video_timer.start()
        }

        Item {
            id: start_end
            property var start
            property var end
        }

        DataObject {
            id: tmp_data_object
        }
    }

    Timer {
        id: video_timer
        repeat: true
        running: false
        interval: 10
        onTriggered: {
            //console.log("video.position", video.position, start_end.end)
            if(video.position >= start_end.start + 1000)
                bbox.width=0

            if(video.position >= start_end.end)
            {
                video.pause()
                video_timer.stop()
            }
        }
    }

    ListModel {
        id: for_show_model
    }
    ListModel {
        id: all_event_model
    }
    FileIO {
           id: myFile
           onError: console.log(msg)
    }
    Rectangle
    {
        id: frame
        anchors.horizontalCenterOffset: -145
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 90
        anchors.top: parent.top

        border.color: "black"
        border.width: 2
        width: 640
        height: 480
        color: "grey"


        MediaPlayer  {
            id: video
            //anchors.horizontalCenterOffset: -145
            //anchors.horizontalCenter: parent.horizontalCenter
            //anchors.topMargin: 90
            //anchors.top: parent.top
            //width: 636
            //height: 476
        }

        VideoOutput {
            id: videoOutput
            source: video
            anchors.fill: parent

            Rectangle {
                id: bbox
                color: "red"
                //border.width: 3
                //border.color: "red"
            }
        }
    }


}
