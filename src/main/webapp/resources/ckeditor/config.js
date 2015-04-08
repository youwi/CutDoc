/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	 config.language = 'zh-cn';
	 config.autoGrow_onStartup = true;
	// config.uiColor = '#AADC6E';
	config.toolbarCanCollapse = true;
//	config.width = '100%';
//	config.height='400';
	
	config.autoGrow_maxHeight = 1200;
//	config.fullscrcam=true;
	config.keystrokes = [
        [ CKEDITOR.CTRL + 90 /*Z*/, 'undo' ], //撤销
        [ CKEDITOR.CTRL + 83 /* S*/, 'save' ],  //  83s 84t 85u
        [ CKEDITOR.CTRL + 89 /*Y*/, 'redo' ], //重做
        [ CKEDITOR.CTRL + CKEDITOR.SHIFT + 90 /*Z*/, 'redo' ], //
        [ CKEDITOR.CTRL + 76 /*L*/, 'link' ], //链接
        [ CKEDITOR.CTRL + 66 /*B*/, 'bold' ], //粗体
        [ CKEDITOR.CTRL + 73 /*I*/, 'italic' ], //斜体
        [ CKEDITOR.CTRL + 85 /*U*/, 'underline' ], //下划线
        [ CKEDITOR.ALT + 109 /*-*/, 'toolbarCollapse' ],
        [ CKEDITOR.CTRL+70   ,'find'],                           // F   find
        [ CKEDITOR.CTRL+72,'replace']                       //   H
    ];
    //设置快捷键 可能与浏览器快捷键冲突 plugins/keystrokes/plugin.js.
    config.blockedKeystrokes = [
		CKEDITOR.CTRL + 83   /* S*/,  
        CKEDITOR.CTRL + 66 /*B*/,
        CKEDITOR.CTRL + 73 /*I*/,
        CKEDITOR.CTRL + 85 /*U*/,
        CKEDITOR.CTRL +70  ,/* F*/
        CKEDITOR.CTRL +72 /*H*/
    ];
    config.font_names = '微软雅黑;宋体;黑体;隶书;楷体_GB2312;Arial;Comic Sans MS,'; 
    config.tabSpaces = 4;//  Tab键4个空格
    config.startupFocus = true;// 编辑焦点...
    config.allowedContent=true;
   // config.fullPage = true;
   config.enterMode = CKEDITOR.ENTER_BR;
    //  config.startupMode ='source';
   

};

