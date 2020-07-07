<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <%--    <link rel="stylesheet" type="text/css" href="src/main/webapp/WEB-INF/view/styles.css">--%>
    <style>
        <%@include file="styles.css" %>
        .div1 {
            display: inline-block;
        }

    </style>
    <title>Your own note recognizer page</title>
</head>
<body>dtcnb
<h1 align="center" style="font-size: 76px">NOTE RECOGNiZER</h1>
<p style="font-size: 48px"><strong>Your client code:</strong> ${code}</p>
<div>
    <play onclick="playAll()">PLAY</play>
    <play onclick="addColumn()" style="width:400px ">ADD</play>
</div>
<div style="position:relative">
    <div id="notesList" style="width:max-content;position:absolute;top: 0; margin-left:370px;margin-top: 19px">
    </div>
    <div id="pianoBlack" style="position: absolute;top: 0;z-index: 1;">
    </div>
    <div id="pianoWhite" style="position:absolute;top: 0">
    </div>
</div>
<script type="text/javascript">
    context = window.AudioContext ? new AudioContext() : new webkitAudioContext();
    toneArr =${notes};
    noteArr = [[], []]
    noteCounter = 0;
</script>


<script type="text/javascript">
    function playNote() {
        var id = this.id;
        play(id);
    }

    function play(id) {
        var noteNumber = 0;
        if (id.charAt(0) == "w") {
            noteNumber = id.split("w")[1];
            noteNumber = 59 - noteNumber;

        } //is whiteKey
        if (id.charAt(1) == "b") {
            noteNumber = id.split("b")[1];
            noteNumber = 59 - noteNumber;
        }// blackKey
        if (id.charAt(0) == "n") {
            var arr = id.split("n");
            noteNumber = Number(arr[1]);
            noteNumber = 59 - noteNumber;
        }//note element
        var etalon = 59 - 31;//a4
        var tones = noteNumber - etalon;
        var fr = 440 * Math.pow(2, tones / 12);
        var osc = context.createOscillator();
        osc.frequency.value = fr;
        osc.connect(context.destination);
        osc.type = "sine";
        osc.start(0);
        setTimeout(function () {
            osc.stop(0);
            osc.disconnect(context.destination);
        }, 500);
    }

    function playAll() {
        var j = 0;
        noteArr.forEach(function (item, i, arr) {
            var delay = 500 * j;
            j++;
            item.forEach(function (item, i, arr) {
                setTimeout(function () {
                    play(item)
                }, delay);
            });
        });
    }

</script>


<script type="text/javascript">
    //onClick on note
    function onClickNote() {
        if (this.tagName == "NOTE") {
            var id = this.id;
            var newNote = document.createElement("spaceNote");
            newNote.id = id
            newNote.onclick = onClickNote;
            var column = id.split("n")[2];
            var noteNumber = id.split("n")[1];
            delete noteArr[column][noteNumber];
            document.getElementById(id).replaceWith(newNote);
        }
        if (this.tagName == "SPACENOTE") {
            var id = this.id;
            var newNote = document.createElement("note");
            newNote.id = id
            var column = id.split("n")[2];
            var noteNumber = id.split("n")[1];
            noteArr[column][noteNumber] = id;
            newNote.onclick = onClickNote;
            document.getElementById(id).replaceWith(newNote);
            play(id);
        }

    }
</script>

<script type="text/javascript" defer>
    //рисуем белые клавиши
    var svgWhite = document.getElementById("pianoWhite")


    //создаем черные клавиши
    var svg = document.getElementById("pianoBlack")
    svg.appendChild(document.createElement("br"));
    for (var i = 1; i < 6; i++) {

        var key1w = document.createElement("white");
        key1w.id = "w" + noteCounter;
        key1w.onclick = playNote;

        noteCounter++;

        var key1 = document.createElement("black");
        key1.id = "1b" + noteCounter;
        key1.onclick = playNote;
        key1.style.marginTop = "40px";

        noteCounter++;


        var key2w = document.createElement("white");
        key2w.id = "w" + noteCounter;
        key2w.onclick = playNote;

        noteCounter++;


        var key2 = document.createElement("black");
        key2.id = "2b" + noteCounter;
        key2.onclick = playNote;
        key2.style.marginTop = "40px";

        noteCounter++;


        var key3w = document.createElement("white");
        key3w.id = "w" + noteCounter;
        key3w.onclick = playNote;

        noteCounter++;

        var key4w = document.createElement("white");
        key4w.id = "w" + noteCounter;
        key4w.onclick = playNote;

        noteCounter++;

        var key3 = document.createElement("black");
        key3.id = "3b" + noteCounter;
        key3.onclick = playNote;
        key3.style.marginTop = "116px";

        noteCounter++;

        var key5w = document.createElement("white");
        key5w.id = "w" + noteCounter;
        key5w.onclick = playNote;

        noteCounter++;

        var key4 = document.createElement("black");
        key4.id = "4b" + noteCounter;
        key4.onclick = playNote;
        key4.style.marginTop = "38px";

        noteCounter++;

        var key6w = document.createElement("white");
        key6w.id = "w" + noteCounter;
        key6w.onclick = playNote;

        noteCounter++;

        var key5 = document.createElement("black");
        key5.id = "5b" + noteCounter;
        key5.onclick = playNote;
        key5.style.marginTop = "38px";
        key5.style.marginBottom = "76px";

        noteCounter++;

        var key7w = document.createElement("white");
        key7w.id = "w" + noteCounter;
        key7w.onclick = playNote;

        noteCounter++;


        arrWhite = [key1w, key2w, key3w, key4w, key5w, key6w, key7w];
        arrBlack = [key1, key2, key3, key4, key5];

        for (key in arrWhite) {
            arrWhite[key].textContent = ".";
            svgWhite.appendChild(arrWhite[key]);
            svgWhite.appendChild(document.createElement("br"))
        }

        for (key in arrBlack) {
            svg.appendChild(arrBlack[key]);
            svg.appendChild(document.createElement("br"));

        }
    }

</script>

<script type="text/javascript" defer>
    //заполняем пустыми нотами
    var mainDiv = document.getElementById("notesList");
    var form = toneArr;
    var counterNote = 0;
    counterColumn = 0;
    var countOfNotes = form.length;
    for (var j = 0; j < countOfNotes; j++) {
        var div = document.createElement("div");
        div.className = "div1";
        div.id = j + "divNotes";

        // div.style.marginTop = "18px";
        mainDiv.appendChild(div);
        for (var i = 0; i < 69; i++) {
            if (((i - 5) % 14) == 0 || ((i - 13) % 14) == 0) {
                div.appendChild(document.createElement("noneNote"));
                div.appendChild(document.createElement("br"));
            } else {
                var note = document.createElement("spaceNote");
                note.id = "n" + counterNote + "n" + counterColumn;
                note.onclick = onClickNote;
                counterNote++;
                div.appendChild(note);
                div.appendChild(document.createElement("br"))

            }
        }
        counterColumn++;
        counterNote = 0;
    }

    //расстановка нот
    for (var i = 0; i < form.length; i++) {
        noteArr[i] = [];
        var curr = 31 - form[i];
        var newNote = document.createElement("note");
        newNote.id = "n" + curr + "n" + i;
        noteArr[i][curr] = newNote.id;
        newNote.onclick = onClickNote;
        document.getElementById("n" + curr + "n" + i).replaceWith(newNote);
    }

    function addColumn() {
        var counterNote = 0;
        var mainDiv = document.getElementById("notesList");
        var div = document.createElement("div");
        div.className = "div1";
        mainDiv.appendChild(div);
        noteArr[counterColumn] = [];
        for (var i = 0; i < 69; i++) {
            if (((i - 5) % 14) == 0 || ((i - 13) % 14) == 0) {
                div.appendChild(document.createElement("noneNote"));
                div.appendChild(document.createElement("br"));
            } else {
                var note = document.createElement("spaceNote");
                note.id = "n" + counterNote + "n" + counterColumn;
                note.onclick = onClickNote;
                counterNote++;
                div.appendChild(note);
                div.appendChild(document.createElement("br"))

            }
        }
        counterColumn++;


    }

</script>


</body>
</html>