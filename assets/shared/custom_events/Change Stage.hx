import backend.StageData;
import flixel.FlxG;

var eventOptions:Map<String, Dynamic> = [
	"runCustomCallback" => true,
	"customCallback" => "onStageAdded"
];

function onEvent(name:String, value1:String, value2:String) {
	if(name == "Change Stage") {

		if(value2 == null || value2 == "") {
			game.addTextToDebug("Change Stage.hx:Error - Value 2 must be 'lua' or 'hx'!", 0xFFFF0000);
			return;
		}
		if(value1 == null || value1 == "") {
			game.addTextToDebug("Change Stage.hx:Error - Value 1 must be a stage name!", 0xFFFF0000);
			return;
		}
		
		var newStageData = StageData.getStageFile(value1);
		
		// Camera zoom
		PlayState.instance.defaultCamZoom = newStageData.defaultZoom;
		FlxG.camera.zoom = PlayState.instance.defaultCamZoom;
		
		// Camera speed
		if(newStageData.camera_speed != null)
			PlayState.instance.cameraSpeed = newStageData.camera_speed;
		
		// ✅ BOYFRIEND (fixed positioning)
		PlayState.instance.BF_X = newStageData.boyfriend[0];
		PlayState.instance.BF_Y = newStageData.boyfriend[1];
		PlayState.instance.boyfriend.setPosition(
			PlayState.instance.BF_X,
			PlayState.instance.BF_Y
		);
		PlayState.instance.boyfriend.updateHitbox();
		
		// ✅ DAD
		PlayState.instance.DAD_X = newStageData.opponent[0];
		PlayState.instance.DAD_Y = newStageData.opponent[1];
		PlayState.instance.dad.setPosition(
			PlayState.instance.DAD_X,
			PlayState.instance.DAD_Y
		);
		PlayState.instance.dad.updateHitbox();
		PlayState.instance.boyfriend.y += 50;
		
		// 🚫 GF completely ignored
		
		// Camera offsets
		PlayState.instance.boyfriendCameraOffset = newStageData.camera_boyfriend;
		if(PlayState.instance.boyfriendCameraOffset == null)
			PlayState.instance.boyfriendCameraOffset = [0, 0];

		PlayState.instance.opponentCameraOffset = newStageData.camera_opponent;
		if(PlayState.instance.opponentCameraOffset == null)
			PlayState.instance.opponentCameraOffset = [0, 0];
		
		// Load stage script
		if(value2 == "lua")
			PlayState.instance.startLuasNamed('stages/' + value1 + '.lua');
		else if(value2 == "hx")
			PlayState.instance.startHScriptsNamed('stages/' + value1 + '.hx');
		
		// Run custom callback
		if(eventOptions.get("runCustomCallback")) {
			if(value2 == "lua")
				PlayState.instance.callOnLuas(eventOptions.get("customCallback"), []);
			else if(value2 == "hx")
				PlayState.instance.callOnHScript(eventOptions.get("customCallback"), []);
		}
	}
}