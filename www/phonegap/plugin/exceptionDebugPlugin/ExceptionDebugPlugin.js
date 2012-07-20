if (window.cordova) {
    window.document.addEventListener("deviceready", function () {
        cordova.exec(null, null, "ExceptionDebugPlugin", "ready", []);
    }, false);
}
