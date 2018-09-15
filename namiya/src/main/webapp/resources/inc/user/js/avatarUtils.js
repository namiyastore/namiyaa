function isSupportedBrowser() {
    var canvas = document.createElement('canvas');
    var checkCanvas = Boolean(canvas && document.createElement('canvas').toDataURL);
    var checkImgCors = typeof new Image().crossOrigin !== 'undefined';
    var checkBase64 = typeof Uint8Array !== 'undefined';

    return checkCanvas && (checkImgCors || checkBase64);
}

function closeToolTip() {
    $("#coach_tooltip").hide();
}

function onReceiveProfileUrl(imageUrl, token) {
    clearInterval(childWindowCheck);
    $(".dim_layer").hide();
    profile.setAvatarImage(imageUrl);
}

function isOverDueDate() {
    currentDate = new Date().getTime();
    dueDate = new Date("2018-03-08").getTime();
    return currentDate > dueDate;
}