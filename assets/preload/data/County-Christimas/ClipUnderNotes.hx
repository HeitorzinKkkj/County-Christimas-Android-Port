import flixel.util.FlxGradient;

var strumHUD;
function onCreatePost(){
    game.timeTxt.visible = false;
    game.scoreTxt.visible = false;

    strumHUD = new FlxCamera();
    strumHUD.bgColor = 0x00000000;
    FlxG.cameras.add(strumHUD,false);
    FlxG.cameras.add(game.camOther,false);
    setVar('strumHUD', strumHUD);

    for (i in 0...4) game.strumLineNotes.members[i].x += 1;
    for (i in 4...8) game.strumLineNotes.members[i].x -= 1;
    for (i in 0...8) game.strumLineNotes.members[i].cameras = [strumHUD];
    for (splash in game.grpNoteSplashes) splash.cameras = [strumHUD];
    for (note in game.unspawnNotes) 
    {
       note.cameras = [strumHUD];
        if (note.isSustainNote)
        {
            note.cameras = [game.camHUD];
            note.blockHit = true; 
        }
    };
}

function onEvent(n,v1,v2){
    if (n == 'Change Character')     reloadTimeBarColor();

    return;
}

function reloadTimeBarColor(){
    var color = [
    FlxColor.fromRGB(game.boyfriend.healthColorArray[0], game.boyfriend.healthColorArray[1], game.boyfriend.healthColorArray[2]),
    FlxColor.fromRGB(game.dad.healthColorArray[0], game.dad.healthColorArray[1], game.dad.healthColorArray[2]),
    ];

    FlxGradient.overlayGradientOnFlxSprite(game.timeBar.leftBar, game.timeBar.leftBar.width, game.timeBar.leftBar.height, color, 0, 0, 1, 180);
    return;
}

function onUpdatePost(){
    for (sp in game.grpNoteSplashes) sp.cameras = [strumHUD];
    
    return;
}

function goodNoteHit(note){
    for (n in game.notes) if (!n.isSustainNote) for (sus in n.tail) sus.blockHit = false;
    
    return;
}

function noteMiss(n){
    if (n.isSustainNote){
        var tail = game.notes.members[game.notes.members.indexOf(n)].parent.tail;
        for (note in tail) {
            note.blockHit = true;
            note.ignoreNote = true;
            note.alpha = 0.2;
            note.copyAlpha = false;
        }
    }else{
        var tail = game.notes.members[game.notes.members.indexOf(n)].tail;
        for (note in tail){
            note.blockHit = true;
            note.ignoreNote = true;
        }
    }

    return;
}