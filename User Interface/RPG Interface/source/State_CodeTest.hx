import flash.geom.Rectangle;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIRadioGroup;
import flixel.addons.ui.FlxUISprite;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUIText;
import flixel.text.FlxText;
import haxe.xml.Fast;
import flash.Lib;
import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.FlxInputText;
import openfl.Assets;
/**
 * @author Lars Doucet
 */

class State_CodeTest extends FlxUIState
{

	override public function create() 
	{
		super.create();
		//NO XML is referenced or created!
		makeStuffByHand();
	}
	
	public override function getRequest(id:String, target:Dynamic, data:Dynamic):Dynamic {
		return null;
	}	
	
	public override function eventResponse(id:String,target:Dynamic,data:Array<Dynamic>):Void {
		if (data != null) {
			switch(cast(data[0], String)) {
				case "back": FlxG.switchState(new State_Title());
			}
		}
	}
	
	private function makeStuffByHand():Void {
		
		/***Basic Sprite***/
		
		var back = new FlxUISprite(0, 0, "assets/gfx/ui/title_back.png");
		add(back);
		
		/***Basic Text***/
		
		var text = new FlxUIText(0, 150, 350, _tongue.get("$CODE_DESC", "ui"));
		text.x = (FlxG.width - text.width) / 2;
		text.alignment = "center";
		add(text);
		
		/***Basic Chrome***/
		
		var chrome = new FlxUI9SliceSprite(50, 180, null, new Rectangle(0,0,700,300));
		add(chrome);
		
		/***Check boxes***/
		
		var check_1 = new FlxUICheckBox(60, 200, null, null, _tongue.get("$MENU_THING_1", "ui"), 100, _onClickCheckBox, ["thing 1"]);
		var check_2 = new FlxUICheckBox(60, check_1.y+20, null, null, _tongue.get("$MENU_THING_2", "ui"), 100, _onClickCheckBox, ["thing 2"]);
		
		add(check_1);
		add(check_2);
		
		/***Radio group***/
		
		var radio_1 = new FlxUIRadioGroup(170, 200, 
		    ["1_fish", "2_fish", "0xff000000_fish", "0x0000ff_fish"],
		    [_tongue.get("$MENU_1_FISH","ui"),
			 _tongue.get("$MENU_2_FISH","ui"),
			 _tongue.get("$MENU_RED_FISH","ui"),
			 _tongue.get("$MENU_BLUE_FISH", "ui")],
			_onClickRadioGroup);
		add(radio_1);
		
		/***Toggle buttons***/
			
		var button1 = new FlxUIButton(300, 200, _tongue.get("$MENU_TOGGLE", "ui"), _onClickButton);
		button1.loadGraphicSlice9(null, 0, 0, null, -1, true);
		
		var button2 = new FlxUIButton(300, 230, _tongue.get("$MENU_TOGGLE", "ui"), _onClickButton);
		button2.loadGraphicSlice9(null, 0, 0, null, -1, true);
		
		var button3 = new FlxUIButton(300, 260, _tongue.get("$MENU_TOGGLE", "ui"), _onClickButton);
		button3.loadGraphicSlice9(null, 0, 0, null, -1, true);
		
		var button4 = new FlxUIButton(300, 290, _tongue.get("$MENU_TOGGLE", "ui"), _onClickButton);
		button4.loadGraphicSlice9(null, 0, 0, null, -1, true);		
		
		add(button1);
		add(button2);
		add(button3);
		add(button4);
		
		/***TAB GROUP***/
		
		//This one is particularly unwieldy to create by hand
				
		//Define the tabs:
		var tabs = [ { id:"tab_1", label:_tongue.get("$MENU_TAB_1", "ui") },
					 { id:"tab_2", label:_tongue.get("$MENU_TAB_2", "ui") },
					 { id:"tab_3", label:_tongue.get("$MENU_TAB_3", "ui") },
					 { id:"tab_4", label:_tongue.get("$MENU_TAB_4", "ui") }];		
		
		//Make the tab menu itself:
		var tab_menu = new FlxUITabMenu(null, tabs, true);
		add(tab_menu);
		
		tab_menu.x = 500;
		tab_menu.y = 212;
		
		//Now make some content for it:
		
			/***TAB GROUP 1***/
			var tabs_radio_1 = new FlxUIRadioGroup(10, 10, 
				["1_fish", "2_fish", "0xff000000_fish", "0x0000ff_fish"],
				[_tongue.get("$MENU_1_FISH","ui"),
				_tongue.get("$MENU_2_FISH","ui"),
				_tongue.get("$MENU_RED_FISH","ui"),
				_tongue.get("$MENU_BLUE_FISH", "ui")],
				_onClickRadioGroup);		
			
			var tab_group_1:FlxUI = new FlxUI(null, tab_menu, null, _tongue);
			tab_group_1.str_id = "tab_1";
			tab_group_1.add(tabs_radio_1);
		
			/***TAB GROUP 2***/
			var tabs_check_1 = new FlxUICheckBox(10, 10, null, null, _tongue.get("$MENU_THING_1", "ui"), 100, _onClickCheckBox, ["thing 1"]);
			var tabs_check_2 = new FlxUICheckBox(10, 40, null, null, _tongue.get("$MENU_THING_2", "ui"), 100, _onClickCheckBox, ["thing 2"]);
				
			var tab_group_2:FlxUI = new FlxUI(null, tab_menu, null, _tongue);
			tab_group_2.str_id = "tab_2";
			tab_group_2.add(tabs_check_1);
			tab_group_2.add(tabs_check_2);
		
		//Add tab groups to tab menu
			
		tab_menu.addGroup(tab_group_1);
		tab_menu.addGroup(tab_group_2);
		
		//Add tab group itself to the state
		
		add(tab_menu);
				
		/***"Back" button***/
		
		var back_btn = new FlxUIButton(0, 535, _tongue.get("$MISC_BACK", "ui"));
		
		var W:Int = 0;
		if (_tongue.locale == "nb-NO") {
			W = 96;
		}		
		back_btn.loadGraphicSlice9(null, W, 0, null);
		back_btn.id = "start";
		back_btn.x = (FlxG.width - back_btn.width) / 2;
		back_btn.setOnUpCallback(_onClickButton, [["back"]]);
		
		add(back_btn);
		
		
	}
	
	private function _onClickRadioGroup(params:Dynamic = null):Void {
		FlxG.log.add("FlxUI._onClickRadioGroup(" + params + ")");
		getEvent("click_radio_group", this, params);
	}
	
	
	private function _onClickButton(params:Array<Dynamic> = null):Void {
		FlxG.log.add("FlxUI._onClickButton(" + params + ")");
		getEvent("click_button", this, params);
	}
	
	private function _onClickCheckBox(params:Dynamic = null):Void {
		FlxG.log.add("FlxUI._onClickCheckBox(" + params + ")");
		getEvent("click_checkbox", this, params);
	}
	
}