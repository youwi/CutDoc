/* 
 * author : fang yongbao
 * data : 2014.12.24
 * model : 拖拽，平移面板
 * info ：知识在于积累，每天一小步，成功永远属于坚持的人。
 * blog : http://www.best-html5.net
 */

/*
 *
 * @param {type} option
 * {
 *   @param resizable: true,//是否允许拖拽
 *   @param resizableId: "u-resizable",//拖拽元素ID
 *   @param drag: true,//是否允许平移
 *   @param dragId: "u-resizable",//平移元素ID
 *   @param width: 400,//元素初始宽度
 *   @param height: 200,//元素初始高度
 *   @param minWidth: 400,//元素最小宽度
 *   @param minHeight: 200,//元素最小高度
 *   @param maxWidth: 400,//元素最大宽度
 *   @param minHeight: 200,//元素最大高度
 * }
 * return obj
 *   none
 *
 *
 */
(function(window, undefined) {

	var _ismoving = 0;
	var _isdraging = 0;
	addEvent(document, "mousemove", function(e) {
		var e = e || window.event;
		m_to_x = e.pageX || e.clientX;
		m_to_y = e.pageY || e.clientY;
	});

	addEvent(document, "mouseup", function(e) {
		clearInterval(_ismoving);
		clearInterval(_isdraging);
		_ismoving = 0;
		_isdraging = 0;
	});

	function Resizable(option) {
		/************set parameter********************/

		this.drag = option.drag;
		this.resizable = option.resizable;
		this._id = option.resizableId || "u-resizable";
		this._controlerwidth = 10;
		this._width = option.width || 200;
		this._height = option.height || 200;

		this.panel = document.getElementById(this._id);
		this.panel.style.width = this._width + "px";
		this.panel.style.height = this._height + "px";



		if (this.resizable) {
			this._minwidth = option.minWidth;
			this._minheight = option.minHeight;
			this._maxwidth = option.maxWidth - this._controlerwidth;
			this._maxheight = option.maxHeight - this._controlerwidth;
			/*********add controller***************************/
			this.appendControler(this.panel);
			/*********add Stretch event**************************/
			this.eventStretchHandler();
		}


		if (this.drag) {
			this._dragid = option.dragId || "u-dragtitle";
			this._dragobj = document.getElementById(this._dragid);
			this._dragobj.style.cursor = "move";

			/*********add drag event**************************/
			this.eventDragHandler();
		}


	}


	Resizable.prototype.appendControler = function(_panel) {
		var _this = this;
		_this.r = document.createElement("div");
		_this.b = document.createElement("div");
		_this.rb = document.createElement("div");

		/**************add class********************/
		_this.r.className = "u-resizable-r ui-resizable-ctrl";
		_this.b.className = "u-resizable-b ui-resizable-ctrl";
		_this.rb.className = "u-resizable-rb ui-resizable-ctrl";

		_panel.appendChild(_this.r);
		_panel.appendChild(_this.b);
		_panel.appendChild(_this.rb);
	}

	Resizable.prototype.eventStretchHandler = function() {
		var _this = this;

		addEvent(_this.r, "mousedown", function(e) {
			_this.mouseDownHandler(e, _this.r, "r");
		});
		addEvent(_this.b, "mousedown", function(e) {
			_this.mouseDownHandler(e, _this.b, "b");
		});
		addEvent(_this.rb, "mousedown", function(e) {
			_this.mouseDownHandler(e, _this.rb, "rb");
		});
	}



	Resizable.prototype.mouseDownHandler = function(e, ctrl, type) {
		var _this = this;
		/******防止鼠标右键和滚轮干扰,引入jquery判断方法*******************/
		if (!e.which && e.button !== undefined) {
			e.which = (e.button & 1 ? 1 : (e.button & 2 ? 3 : (e.button & 4 ? 2 : 0)));
		}

		if (e.which == 1) {
			var e = e || window.event;
			_this.m_start_x = (e.pageX || e.clientX) - ctrl.offsetLeft;
			_this.m_start_y = (e.pageY || e.clientY) - ctrl.offsetTop;

			_ismoving = setInterval(function() {
				_this.movingHander(type);
			}, 13);
		} else {
			return false;
		}




	}

	Resizable.prototype.movingHander = function(type) {
		var _this = this;
		if (_ismoving && !_isdraging) {

			/**********************************/
			var to_x = Math.max(_this._minwidth, m_to_x - _this.m_start_x);
			var to_y = Math.max(_this._minheight, m_to_y - _this.m_start_y);
			to_x = Math.min(to_x, _this._maxwidth);
			to_y = Math.min(to_y, _this._maxheight);



			switch (type) {
				case "r":
					_this.panel.style.width = to_x + _this._controlerwidth + "px";
					break;
				case "b":
					_this.panel.style.height = to_y + _this._controlerwidth + "px";
					break;
				case "rb":
					_this.panel.style.width = to_x + _this._controlerwidth + "px";
					_this.panel.style.height = to_y + _this._controlerwidth + "px";
					break;
			}
		} else if (!_ismoving && _isdraging) {

			var pageWidth = document.documentElement.clientWidth;
			var pageHeight = document.documentElement.clientHeight;
			var dragobjWidth = _this.panel.offsetWidth;
			var dragobjHeight = _this.panel.offsetHeight;
			var maxX = pageWidth - dragobjWidth;
			var maxY = pageHeight - dragobjHeight;



			var to_x = Math.min(maxX, Math.max(0, m_to_x - _this.m_start_x));
			var to_y = Math.min(maxY, Math.max(0, m_to_y - _this.m_start_y));


			_this.panel.style.left = to_x + "px";
			_this.panel.style.top = to_y + "px";
		}
	};


	Resizable.prototype.eventDragHandler = function() {
		var _this = this;
		addEvent(_this._dragobj, "mousedown", function(e) {
			var e = e || window.event;
			_this.m_start_x = (e.pageX || e.clientX) - _this.panel.offsetLeft;
			_this.m_start_y = (e.pageY || e.clientY) - _this.panel.offsetTop;
			_isdraging = setInterval(function() {
				_this.movingHander();
			}, 13);

		});
	};


	if (typeof window === "object" && typeof window.document === "object") {
		window.Resizable = Resizable;
	}

	function addEvent(obj, event, callback) {
		if (window.attachEvent) {
			obj.attachEvent("on" + event, callback);
		} else {
			obj.addEventListener(event, callback, true);
		}
	};


})(window);