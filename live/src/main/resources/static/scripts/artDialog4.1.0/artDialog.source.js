/*
 * artDialog 4.1.0
 * Date: 2011-08-06 22:10
 * http://code.google.com/p/artdialog/
 * (c) 2009-2010 TangBin, http://www.planeArt.cn
 *
 * This is licensed under the GNU LGPL, version 2.1 or later.
 * For details, see: http://creativecommons.org/licenses/LGPL/2.1/
 */
 
/*!
	"art"底层操作微型库，模拟 jQuery DOM 操作接口。
------------------------------------------------------------------*/
;(function (window, undefined) {
if (window.jQuery) return jQuery;

var $ = window.art = function (selector, content) {
    	return new $.fn.init(selector, content);
	},
    readyBound = false,
    readyList = [],
    DOMContentLoaded, timerId, 
	isOpacity = 'opacity' in document.documentElement.style,
	quickExpr = /^(?:[^<]*(<[\w\W]+>)[^>]*$|#([\w\-]+)$)/,
	rclass = /[\n\t]/g,
	ralpha = /alpha\([^)]*\)/i,
	ropacity = /opacity=([^)]*)/,
    rfxnum = /^([+-]=)?([\d+-.]+)(.*)$/;

if (window.$ === undefined) window.$ = $;
$.fn = $.prototype = {
	constructor: $,
	
    /**
	 * DOM 就绪
	 * @param	{Function}	回调函数
	 */
    ready: function (callback) {
        $.bindReady();

        if ($.isReady) {
            callback.call(document, $);
        } else if (readyList) {
            readyList.push(callback);
        };

        return this;
    },

    /**
	 * 判断样式类是否存在
	 * @param	{String}	名称
	 * @return	{Boolean}
	 */
    hasClass: function (name) {		
		var className = ' ' + name + ' ';
		if ((' ' + this[0].className + ' ').replace(rclass, ' ')
		.indexOf(className) > -1) return true;

		return false;
    },

    /**
	 * 添加样式类
	 * @param	{String}	名称
	 */
    addClass: function (name) {
        if (!this.hasClass(name)) this[0].className += ' ' + name;

        return this;
    },

    /**
	 * 移除样式类
	 * @param	{String}	名称
	 */
    removeClass: function (name) {
        var elem = this[0];

        if (!name) {
            elem.className = '';
        } else
		if (this.hasClass(name)) {
            elem.className = elem.className.replace(name, ' ');
        };

        return this;
    },

    /**
	 * 读写样式<br />
     * css(name) 访问第一个匹配元素的样式属性<br />
     * css(properties) 把一个"名/值对"对象设置为所有匹配元素的样式属性<br />
     * css(name, value) 在所有匹配的元素中，设置一个样式属性的值<br />
	 */
    css: function (name, value) {
        var i, elem = this[0], obj = arguments[0];

        if (typeof name === 'string') {
            if (value === undefined) {
                return $.css(elem, name);
            } else {
                name === 'opacity' ?
					$.opacity.set(elem, value) :
					elem.style[name] = value;
            };
        } else {
            for (i in obj) {
				i === 'opacity' ?
					$.opacity.set(elem, obj[i]) :
					elem.style[i] = obj[i];
			};
        };

        return this;
    },
	
	/** 显示元素 */
	show: function () {
		return this.css('display', 'block');
	},
	
	/** 隐藏元素 */
	hide: function () {
		return this.css('display', 'none');
	},

    /**
	 * 获取相对文档的坐标
	 * @return	{Object}	返回left、top的数值
	 */
    offset: function () {
        var elem = this[0],
            box = elem.getBoundingClientRect(),
            doc = elem.ownerDocument,
            body = doc.body,
            docElem = doc.documentElement,
            clientTop = docElem.clientTop || body.clientTop || 0,
            clientLeft = docElem.clientLeft || body.clientLeft || 0,
            top = box.top + (self.pageYOffset || docElem.scrollTop) - clientTop,
            left = box.left + (self.pageXOffset || docElem.scrollLeft) - clientLeft;

        return {
            left: left,
            top: top
        };
    },
	
	/**
	 * 读写HTML - (不支持文本框)
	 * @param	{String}	内容
	 */
	html: function (content) {
		if (content === undefined) return this[0].innerHTML;
		this[0].innerHTML = content;
		
		return this;
	}
};

$.fn.init = function (selector, context) {
	var match, elem;
	context = context || document;
	
	if (!selector) return this;
	
	if (selector.nodeType) {
		this[0] = selector;
		return this;
	};
	
	if (selector === 'body' && context.body) {
		this[0] = context.body;
		return this;
	};
	
	if (selector === 'head' || selector === 'html') {
		this[0] = context.getElementsByTagName(selector)[0];
		return this;
	};
		
	if (typeof selector === 'string') {
		match = quickExpr.exec(selector);

		if (match && match[2]) {
			elem = context.getElementById(match[2]);
			if (elem && elem.parentNode) this[0] = elem;
			return this;
		};
	};
	
	if (typeof selector === 'function') return $(document).ready(selector);
	
	this[0] = selector;
	
	return this;
};
$.fn.init.prototype = $.fn;

/** 空函数 */
$.noop = function () {};

/** 检测window */
$.isWindow = function (obj) {
	return obj && typeof obj === 'object' && 'setInterval' in obj;
};

/** 数组判定 */
$.isArray = function (obj) {
    return Object.prototype.toString.call(obj) === '[object Array]';
};

/**
 * 搜索子元素
 * 注意：只支持nodeName或.className的形式，并且只返回第一个元素
 * @param	{String}
 */
$.fn.find = function (expr) {
	var value, elem = this[0],
		className = expr.split('.')[1];

	if (className) {
		if (document.getElementsByClassName) {
			value = elem.getElementsByClassName(className);
		} else {
			value = getElementsByClassName(className, elem);
		};
	} else {
		value = elem.getElementsByTagName(expr);
	};
	
	return $(value[0]);
};
function getElementsByClassName (className, node, tag) {
	node = node || document;
	tag = tag || '*';
	var i = 0,
		j = 0,
		classElements = [],
		els = node.getElementsByTagName(tag),
		elsLen = els.length,
		pattern = new RegExp("(^|\\s)" + className + "(\\s|$)");
		
	for (; i < elsLen; i ++) {
		if (pattern.test(els[i].className)) {
			classElements[j] = els[i];
			j ++;
		};
	};
	return classElements;
};

/**
 * 遍历
 * @param {Object}
 * @param {Function}
 */
$.each = function (obj, callback) {
    var name, i = 0,
        length = obj.length,
        isObj = length === undefined;

    if (isObj) {
        for (name in obj) {
            if (callback.call(obj[name], name, obj[name]) === false) break;
        };
    } else {
        for (var value = obj[0];
		i < length && callback.call(value, i, value) !== false;
		value = obj[++i]) {};
    };
	
	return obj;
};

/**
 * 移除节点
 */
$.fn.remove = function () {
	var elem = this[0];

	while (elem.firstChild) {
		$.event.remove(elem.firstChild);
		$.removeData(elem.firstChild);
		elem.removeChild(elem.firstChild);
	};

	$.event.remove(elem);
	$.removeData(elem);
	elem.parentNode.removeChild(elem);
	'CollectGarbage' in window && setTimeout(CollectGarbage, 1);
	return this;
};

/**
 * 写入数据缓存
 * @param	{String}	名称
 * @param	{Object}	数据
 */
$.fn.data = function (name, data) {
	var ret = $.data(this[0], name, data);
	if (data !== undefined) return ret; 
	return this;
};

/**
 * 删除数据缓存
 * @param	{String}	名称
 * @param	{Object}	数据
 */
$.fn.removeData = function (name) {
	$.removeData(this[0], name);
	return this;
};

$.uuid = 0;
$.cache = {};
$.expando = '@cache' + (new Date).getTime();

$.data = function (elem, name, data) {
	var cache = $.cache,
		id = $._getUid(elem);
	
	if (!cache[id]) cache[id] = {};
	if (data !== undefined) cache[id][name] = data;
	
	return cache[id][name];
};

$._getUid = function (elem) {
	var expando = $.expando,
		id = elem === window ? 0 : elem[expando];
	if (id === undefined) elem[expando] = id = ++ $.uuid;
	return id;
};

$.removeData = function (elem, name) {
	var expando = $.expando,
		cache = $.cache,
		id = $._getUid(elem),
		thisCache = id && cache[id];

	if (!thisCache) return;
	if (name) return delete thisCache[name];
	
	delete cache[id];
	if (elem.removeAttribute) {
		elem.removeAttribute(expando);
	} else {
		elem[expando] = null;
	};
};

/**
 * 事件绑定
 * @param	{String}	类型
 * @param	{Function}	要绑定的函数
 */
$.fn.bind = function (type, callback) {
	$.event.add(this[0], type, callback);
	return this;
};

/**
 * 移除事件
 * @param	{String}	类型
 * @param	{Function}	要卸载的函数
 */
$.fn.unbind = function(type, callback) {
	$.event.remove(this[0], type, callback);
	return this;
};

// 事件机制
$.event = {
	
	// 添加
	add: function (elem, type, callback) {
		var types, listeners,
			data = $.data(elem, '@events') || $.data(elem, '@events', {}),
			ecma = 'addEventListener' in elem,
			add = ecma ? 'addEventListener' : 'attachEvent';
		
		types = data[type] = data[type] || {};
		listeners = types.listeners = types.listeners || [];
		listeners.push(callback);
		
		if (!types.handler) {
			types.elem = elem;
			types.handler = this.handler($._getUid(elem));
			
			type = ecma ? type : 'on' + type;
			elem[add](type, types.handler, false);
		};
	},
	
	// 卸载
	remove: function (elem, type, callback) {
		var i, types, listeners,
			data = $.data(elem, '@events'),
			ecma = 'removeEventListener' in elem,
			remove = ecma ? 'removeEventListener' : 'detachEvent';
		
		if (!data) return;
		if (type === undefined) {
			for (i in data) this.remove(elem, i);
			//return;
		};
		
		types = data[type];
		if (!types) return;
		
		listeners = types.listeners;
		if (callback === undefined) {
			types.listeners = [];
		} else {
			for (i = 0; i < listeners.length; i ++) {
				listeners[i] === callback && listeners.splice(i--, 1);
			};
		};
		
		if (listeners.length === 0) {
			delete data[type];
			type = ecma ? type : 'on' + type;
			elem[remove](type, types.handler, false);
		};
	},
	
	handler: function (id) {
		return function (event) {
			event = $.event.fix(event || window.event);
			var cache = $.cache[id]['@events'][event.type];
			for (var i = 0, fn; fn = cache.listeners[i++];) {
				if (fn.call(cache.elem, event) === false) {
					event.preventDefault();
					event.stopPropagation();
				};
			};
		};
	},
	
	// 兼容处理
	fix: function (e) {
		if (e.target) return e;
		var event = {
			target: e.srcElement || document,
			preventDefault: function () {e.returnValue = false},
			stopPropagation: function () {e.cancelBubble = true}
		};
		for (var i in e) event[i] = e[i];
		
		return event;
	}
};

// DOM就绪事件
$.isReady = false;
$.ready = function () {
    if (!$.isReady) {
        if (!document.body) return setTimeout($.ready, 13);
        $.isReady = true;

        if (readyList) {
            var fn, i = 0;
            while ((fn = readyList[i++])) {
                fn.call(document, $);
            };
            readyList = null;
        };
    };
};
$.bindReady = function () {
    if (readyBound) return;

    readyBound = true;

    if (document.readyState === 'complete') {
        return $.ready();
    };

    if (document.addEventListener) {
        document.addEventListener('DOMContentLoaded', DOMContentLoaded, false);
        window.addEventListener('load', $.ready, false);
    } else if (document.attachEvent) {
        document.attachEvent('onreadystatechange', DOMContentLoaded);
        window.attachEvent('onload', $.ready);
        var toplevel = false;
        try {
            toplevel = window.frameElement == null;
        } catch (e) {};

        if (document.documentElement.doScroll && toplevel) {
            doScrollCheck();
        };
    };
};

if (document.addEventListener) {
    DOMContentLoaded = function () {
        document.removeEventListener('DOMContentLoaded', DOMContentLoaded, false);
        $.ready();
    };
} else if (document.attachEvent) {
    DOMContentLoaded = function () {
        if (document.readyState === 'complete') {
            document.detachEvent('onreadystatechange', DOMContentLoaded);
            $.ready();
        };
    };
};

function doScrollCheck () {
    if ($.isReady) return;

    try {
        document.documentElement.doScroll('left');
    } catch (e) {
        setTimeout(doScrollCheck, 1);
        return;
    };
    $.ready();
};

// 获取css
$.css = 'defaultView' in document && 'getComputedStyle' in document.defaultView ?
	function (elem, name) {
		return document.defaultView.getComputedStyle(elem, false)[name]
} :
	function (elem, name) {
		var ret = name === 'opacity' ? $.opacity.get(elem) : elem.currentStyle[name];
		return ret || '';
};

// 跨浏览器处理opacity
$.opacity = {
	get: function (elem) {
		return isOpacity ?
			document.defaultView.getComputedStyle(elem, false).opacity :
			ropacity.test((elem.currentStyle
				? elem.currentStyle.filter
				: elem.style.filter) || '')
				? (parseFloat(RegExp.$1) / 100) + ''
				: 1;
	},
	set: function (elem, value) {
		if (isOpacity) return elem.style.opacity = value;
		var style = elem.style;
		style.zoom = 1;

		var opacity = 'alpha(opacity=' + value * 100 + ')',
			filter = style.filter || '';

		style.filter = ralpha.test(filter) ?
			filter.replace(ralpha, opacity) :
			style.filter + ' ' + opacity;
	}
};

/**
 * 获取滚动条位置 - [不支持写入]
 * $.fn.scrollLeft, $.fn.scrollTop
 * @example		获取文档垂直滚动条：$(document).scrollTop()
 * @return		{Number}	返回滚动条位置
 */
$.each(['Left', 'Top'], function (i, name) {
    var method = 'scroll' + name;

    $.fn[method] = function (val) {
        var elem = this[0], win;

		win = getWindow(elem);
		return win ?
			('pageXOffset' in win) ?
				win[i ? 'pageYOffset' : 'pageXOffset'] :
				win.document.documentElement[method] || win.document.body[method] :
			elem[method];
    };
});

function getWindow (elem) {
	return $.isWindow(elem) ?
		elem :
		elem.nodeType === 9 ?
			elem.defaultView || elem.parentWindow :
			false;
};

/**
 * 获取窗口或文档尺寸 - [只支持window与document读取]
 * @example 
   获取文档宽度：$(document).width()
   获取可视范围：$(window).width()
 * @return	{Number}
 */
$.each(['Height', 'Width'], function (i, name) {
    var type = name.toLowerCase();

    $.fn[type] = function (size) {
        var elem = this[0];
        if (!elem) {
            return size == null ? null : this;
        };

		return $.isWindow(elem) ?
			elem.document.documentElement['client' + name] || elem.document.body['client' + name] :
			(elem.nodeType === 9) ?
				Math.max(
					elem.documentElement['client' + name],
					elem.body['scroll' + name], elem.documentElement['scroll' + name],
					elem.body['offset' + name], elem.documentElement['offset' + name]
				) : null;
    };

});

/**
 * 简单ajax支持
 * @example
 * $.ajax({
 * 		url: url,
 * 		success: callback,
 * 		cache: cache
 * });
 */
$.ajax = function (config) {
	var ajax = window.XMLHttpRequest ?
			new XMLHttpRequest() :
			new ActiveXObject('Microsoft.XMLHTTP'),
		url = config.url;
	
	if (config.cache === false) {
		var ts = (new Date()).getTime(),
			ret = url.replace(/([?&])_=[^&]*/, "$1_=" + ts );
		url = ret + ((ret === url) ? (/\?/.test(url) ? "&" : "?") + "_=" + ts : "");
	};
	
	ajax.onreadystatechange = function() {
		if (ajax.readyState === 4 && ajax.status === 200) {
			config.success && config.success(ajax.responseText);
			ajax.onreadystatechange = $.noop;
		};
	};
	ajax.open('GET', url, 1);
	ajax.send(null);
};

/** 动画引擎 - [不支持链式列队操作] */
$.fn.animate = function (prop, speed, easing, callback) {
	
	speed = speed || 400;
	if (typeof easing === 'function') callback = easing;
	easing = easing && $.easing[easing] ? easing : 'swing';
	
    var $this = this, overflow,
        fx, parts, start, end, unit,
		opt = {
			speed: speed,
			easing: easing,
			callback: function () {
				if (overflow != null) $this[0].style.overflow = '';
				callback && callback();
			}
		};
	
	opt.curAnim = {};
	$.each(prop, function (name, val) {
		opt.curAnim[name] = val;
	});
	
    $.each(prop, function (name, val) {
        fx = new $.fx($this[0], opt, name);
        parts = rfxnum.exec(val);
        start = parseFloat(name === 'opacity'
			|| ($this[0].style && $this[0].style[name] != null) ?
			$.css($this[0], name) :
			$this[0][name]);
        end = parseFloat(parts[2]);
        unit = parts[3];
		if (name === 'height' || name === 'width') {
			end = Math.max(0, end);
			overflow = [$this[0].style.overflow,
			$this[0].style.overflowX, $this[0].style.overflowY];
		};
		
        fx.custom(start, end, unit);
    });
	
	if (overflow != null) $this[0].style.overflow = 'hidden';

    return this;
};

$.timers = [];
$.fx = function (elem, options, prop) {
    this.elem = elem;
    this.options = options;
    this.prop = prop;
};

$.fx.prototype = {
    custom: function (from, to, unit) {
		var that = this;
        that.startTime = $.fx.now();
        that.start = from;
        that.end = to;
        that.unit = unit;
        that.now = that.start;
        that.state = that.pos = 0;

        function t() {
            return that.step();
        };
        t.elem = that.elem;
		t();
        $.timers.push(t);
        if (!timerId) timerId = setInterval($.fx.tick, 13);
    },
    step: function () {
        var that = this, t = $.fx.now(), done = true;
		
        if (t >= that.options.speed + that.startTime) {
            that.now = that.end;
            that.state = that.pos = 1;
            that.update();
			
			that.options.curAnim[that.prop] = true;
			for (var i in that.options.curAnim) {
				if (that.options.curAnim[i] !== true) {
					done = false;
				};
			};
			
			if (done) that.options.callback.call(that.elem);
			
            return false;
        } else {
            var n = t - that.startTime;
            that.state = n / that.options.speed;
            that.pos = $.easing[that.options.easing](that.state, n, 0, 1, that.options.speed);
            that.now = that.start + ((that.end - that.start) * that.pos);
            that.update();
            return true;
        };
    },
    update: function () {
		var that = this;
		if (that.prop === 'opacity') {
			$.opacity.set(that.elem, that.now);
		} else
		if (that.elem.style && that.elem.style[that.prop] != null) {
			that.elem.style[that.prop] = that.now + that.unit;
		} else {
			that.elem[that.prop] = that.now;
		};
    }
};

$.fx.now = function () {
    return new Date().getTime();
};

$.easing = {
    linear: function (p, n, firstNum, diff) {
        return firstNum + diff * p;
    },
    swing: function (p, n, firstNum, diff) {
        return ((-Math.cos(p * Math.PI) / 2) + 0.5) * diff + firstNum;
    }
};

$.fx.tick = function () {
	var timers = $.timers;
    for (var i = 0; i < timers.length; i++) {
        !timers[i]() && timers.splice(i--, 1);
    };
    !timers.length && $.fx.stop();
};

$.fx.stop = function () {
    clearInterval(timerId);
    timerId = null;
};

$.fn.stop = function () {
	var timers = $.timers;
    for (var i = timers.length - 1; i >= 0; i--) {
    	if (timers[i].elem === this[0]) timers.splice(i, 1);
	};
    return this;
};

//-------------end
return $}(window));





/*!
	dialog		
------------------------------------------------------------------*/
;(function ($, window, undefined) {

var _box, _thisScript, _skin, _path,
	_count = 0,
	_$window = $(window),
	_$document = $(document),
	_$html = $('html'),
	_$body = $(function(){_$body = $('body')}),
	_elem = document.documentElement,
	_isIE6 = !-[1,] && !('minWidth' in _elem.style),
	_isMobile = 'createTouch' in document && !('onmousemove' in _elem)
		|| /(iPhone|iPad|iPod)/i.test(navigator.userAgent),
	_eventDown = _isMobile ? 'touchstart' : 'mousedown',
	_expando = 'artDialog' + (new Date).getTime();

var artDialog = function (config, yesFn, noFn) {
	config = config || {};
	if (typeof config === 'string' || config.nodeType === 1) {
		config = {content: config, fixed: !_isMobile};
	};
	
	var api, buttons = [],
		defaults = artDialog.defaults,
		elem = config.follow = this.nodeType === 1 && this || config.follow;
		
	// 合并默认配置
	for (var i in defaults) {
		if (config[i] === undefined) config[i] = defaults[i];		
	};
	
	// 返回跟随模式或重复定义的ID
	if (typeof elem === 'string') elem = $(elem)[0];
	config.id = elem && elem[_expando + 'follow'] || config.id || _expando + _count;
	api = artDialog.list[config.id];
	if (elem && api) return api.follow(elem).zIndex().focus();
	if (api) return api.zIndex();
	
	// 目前主流移动设备对fixed支持不好
	if (_isMobile) config.fixed = false;
	
	// 按钮队列
	if (!$.isArray(config.button)) {
		config.button = config.button ? [config.button] : [];
	};
	yesFn = yesFn || config.yesFn;
	noFn = noFn || config.noFn;
	yesFn && config.button.push({
		name: config.yesText,
		callback: yesFn,
		focus: true
	});
	noFn && config.button.push({
		name: config.noText,
		callback: noFn
	});
	
	// zIndex全局配置
	artDialog.defaults.zIndex = config.zIndex;
	
	_count ++;
	return artDialog.list[config.id] = _box ?
		_box._init(config) : new artDialog.fn._init(config);
};

artDialog.fn = artDialog.prototype = {

	version: '4.1.0',
	
	_init: function (config) {
		var that = this, DOM,
			icon = config.icon,
			iconBg = icon && (_isIE6 ? {png: 'icons/' + icon + '.png'}
			: {backgroundImage: 'url(\'' + config.path + '/skins/icons/' + icon + '.png\')'});
		
		that.config = config;
		that._listeners = {};
		that._fixed = _isIE6 ? false : config.fixed;
		that._elemBack = that._timer = that._focus = that._isClose = that._lock = null;
		
		DOM = that.DOM = that.DOM || that._getDOM();
		DOM.wrap.addClass(config.skin);
		DOM.close[config.noFn === false ? 'hide' : 'show']();
		DOM.icon[0].style.display = icon ? '' : 'none';
		DOM.iconBg.css(iconBg || {background: 'none'});
		DOM.se.css('cursor', config.resize ? 'se-resize' : 'auto');
		DOM.title.css('cursor', config.drag ? 'move' : 'auto');
		DOM.content.css('padding', config.padding);
		
		that[config.show ? 'show' : 'hide'](true)
		.button(config.button)
		.title(config.title)
		.content(config.content)
		.size(config.width, config.height)
		.zIndex(config.zIndex)
		.time(config.time);
		
		config.follow
		? that.follow(config.follow)
		: that.position(config.left, config.top);
		
		config.lock && that.lock();
		config.focus && that.focus();
		
		that._addEvent();
		_isIE6 && that._pngFix();
		_box = null;
		
		config.initFn && config.initFn.call(that, window);
		return that;
	},
	
	/**
	 * 设置内容
	 * @param	{String, HTMLElement}	内容 (可选)
	 * @return	{this, HTMLElement}				如果无参数则返回内容容器DOM对象
	 */
	content: function (msg) {
		var prev, next, parent, display,
			that = this,
			content = that.DOM.content,
			elem = content[0];
		
		that._elemBack = null;
		
		if (msg === undefined) {
			return elem;
		} else if (typeof msg === 'string') {
			content.html(msg);
		} else if (msg && msg.nodeType === 1) {
		
			// 让传入的元素在对话框关闭后可以返回到原来的地方
			display = msg.style.display;
			prev = msg.previousSibling;
			next = msg.nextSibling;
			parent = msg.parentNode;
			that._elemBack = function () {
				if (prev && prev.parentNode) {
					prev.parentNode.insertBefore(msg, prev.nextSibling);
				} else if (next && prev.parentNode) {
					next.parentNode.insertBefore(msg, next);
				} else if (parent) {
					parent.appendChild(msg);
				};
				msg.style.display = display;
			};
			
			content.html('');
			elem.appendChild(msg);
			msg.style.display = 'block';
			
		};
		
		_isIE6 && that._selectFix();
		that._runScript(elem);
		
		return that;
	},
	
	/**
	 * 设置标题
	 * @param	{String, Boolean}	标题内容. 为false则隐藏标题栏
	 * @return	{this, HTMLElement}	如果无参数则返回内容器DOM对象
	 */
	title: function (text) {
		var DOM = this.DOM,
			wrap = DOM.wrap,
			title = DOM.title,
			className = 'aui_state_noTitle';
			
		if (text === undefined) {
			return title[0];
		};
		
		if (text === false) {
			title.hide().html('');
			wrap.addClass(className);
		} else {
			title.show().html(text);
			wrap.removeClass(className);
		};
		
		return this;
	},
	
	/**
	 * 位置
	 * @param	{Number, String}
	 * @param	{Number, String}
	 */
	position: function (left, top) {
		var that = this,
			config = that.config,
			wrap = that.DOM.wrap,
			ie6Fixed = _isIE6 && that.config.fixed,
			docLeft = _$document.scrollLeft(),
			docTop = _$document.scrollTop(),
			dl = that._fixed ? 0 : docLeft,
			dt = that._fixed ? 0 : docTop,
			ww = _$window.width(),
			wh = _$window.height(),
			ow = wrap[0].offsetWidth,
			oh = wrap[0].offsetHeight,
			style = wrap[0].style;
		
		if (!left && left !== 0) left = config.left;
		if (!top && top !== 0) top = config.top;
		config.left = left;
		config.top = top;
		
		left = that._toNumber(left, ww - ow);
		if (typeof left === 'number') left = ie6Fixed ? (left += docLeft) : left + dl;

		if (top === 'goldenRatio') {
			// 黄金比例垂直居中
			top = (oh < 4 * wh / 7 ? wh * 0.382 - oh / 2 : (wh - oh) / 2) + dt;
		} else {
			top = that._toNumber(top, wh - oh);
			if (typeof top === 'number') top = ie6Fixed ? (top += docTop) : top + dt;
		};
		
		if (typeof left === 'number') {
			style.left = Math.max(left, dl) + 'px';
		} else if (typeof left === 'string') {
			style.left = left;
		};
		
		if (typeof top === 'number') {
			style.top = Math.max(top, dt) + 'px';
		} else if (typeof top === 'string') {
			style.top = top;
		};
		
		/*that.config.follow = null;*/
		that._autoPositionType();
		
		return that;
	},
	
	/**
	 *	尺寸
	 *	@param	{Number, String}	宽度
	 *	@param	{Number, String}	高度
	 *	@return	this
	 */
	size: function (width, height) {
		var maxWidth, maxHeight, scaleWidth, scaleHeight,
			that = this,
			config = that.config,
			DOM = that.DOM,
			wrap = DOM.wrap,
			main = DOM.main,
			wrapStyle = wrap[0].style,
			style = main[0].style;
			
		if (!width && width !== 0) width = config.width;
		if (!height && height !== 0) height = config.height;
				
		maxWidth = _$window.width() - wrap[0].offsetWidth + main[0].offsetWidth;
		scaleWidth = that._toNumber(width, maxWidth);
		config.width = width;
		width = scaleWidth;
		
		maxHeight = _$window.height() - wrap[0].offsetHeight + main[0].offsetHeight;
		scaleHeight = that._toNumber(height, maxHeight);
		config.height = height;
		height = scaleHeight;
		
		if (typeof width === 'number') {
			wrapStyle.width = 'auto';
			style.width = Math.max(that.config.minWidth, width) + 'px';
			wrapStyle.width = wrap[0].offsetWidth + 'px'; // 防止未定义宽度的表格遇到浏览器右边边界伸缩
		} else if (typeof width === 'string') {
			style.width = width;
			width === 'auto' && wrap.css('width', 'auto');
		};
		
		if (typeof height === 'number') {
			style.height = Math.max(that.config.minHeight, height) + 'px';
		} else if (typeof height === 'string') {
			style.height = height;
		};
		
		_isIE6 && that._selectFix();
		
		return that;
	},
	
	/**
	 * 跟随元素
	 * @param	{HTMLElement}
	 */
	follow: function (elem) {
		var $elem, that = this;

		if (typeof elem === 'string' || elem && elem.nodeType === 1) {
			$elem = $(elem);
		};
		if (!$elem || $elem.css('display') === 'none') {
			return that.position(that.config.left, that.config.top);
		};
		
		var winWidth = _$window.width(),
			winHeight = _$window.height(),
			docLeft =  _$document.scrollLeft(),
			docTop = _$document.scrollTop(),
			offset = $elem.offset(),
			width = $elem[0].offsetWidth,
			height = $elem[0].offsetHeight,
			left = that._fixed ? offset.left - docLeft : offset.left,
			top = that._fixed ? offset.top - docTop : offset.top,
			wrap = that.DOM.wrap[0],
			style = wrap.style,
			wrapWidth = wrap.offsetWidth,
			wrapHeight = wrap.offsetHeight,
			setLeft = left - (wrapWidth - width) / 2,
			setTop = top + height,
			dl = that._fixed ? 0 : docLeft,
			dt = that._fixed ? 0 : docTop;
		
		setLeft = setLeft < dl ? left :
		(setLeft + wrapWidth > winWidth) && (left - wrapWidth > dl)
		? left - wrapWidth + width
		: setLeft;

		setTop = (setTop + wrapHeight > winHeight + dt)
		&& (top - wrapHeight > dt)
		? top - wrapHeight
		: setTop;
		
		style.left = setLeft + 'px';
		style.top = setTop + 'px';
		
		that.config.follow = elem;
		$elem[0][_expando + 'follow'] = that.config.id;
		that._autoPositionType();
		return that;
	},
	
	/**
	 * 自定义按钮
	 * @example
				 button({
					name: 'login',
					callback: function () {},
					disabled: false,
					focus: true
				}, .., ..)
	 */
	button: function () {
		var that = this,
			ags = arguments,
			DOM = that.DOM,
			wrap = DOM.wrap,
			buttons = DOM.buttons,
			elem = buttons[0],
			strongButton = 'aui_state_highlight',
			list = $.isArray(ags[0]) ? ags[0] : [].slice.call(ags);
		
		$.each(list, function (i, val) {
			var name = val.name,
				listeners = that._listeners,
				isNewButton = !listeners[name],
				button = !isNewButton ?
					listeners[name].elem :
					document.createElement('button');
					
			if (!listeners[name]) listeners[name] = {};
			if (val.callback) listeners[name].callback = val.callback;
			if (val.className) button.className = val.className;
			if (val.focus) {
				that._focus && that._focus.removeClass(strongButton);
				that._focus = $(button).addClass(strongButton);
				that.focus();
			};
			
			button[_expando + 'callback'] = name;
			button.disabled = !!val.disabled;

			if (isNewButton) {
				button.innerHTML = name;
				listeners[name].elem = button;
				elem.appendChild(button);
			};
		});
		
		buttons[0].style.display = list.length ? '' : 'none';
		
		_isIE6 && that._selectFix();
		return that;
	},
	
	/** 显示对话框 */
	show: function (lock) {
		this.DOM.wrap.show();
		!lock && this._lockMaskWrap && this._lockMaskWrap.show();
		return this;
	},
	
	/** 隐藏对话框 */
	hide: function (lock) {
		this.DOM.wrap.hide();
		!lock && this._lockMaskWrap && this._lockMaskWrap.hide();
		return this;
	},
	
	/** 关闭对话框 */
	close: function () {
		var that = this,
			DOM = that.DOM,
			wrap = DOM.wrap,
			list = artDialog.list,
			fn = that.config.closeFn,
			follow = that.config.follow;
		
		if (that._isClose) return that;
		that.time();
		if (typeof fn === 'function' && fn.call(that, window) === false) {
			return that;
		};
		
		that.unlock();
		wrap[0].className = wrap[0].style.cssText = '';
		
		that._elemBack && that._elemBack();
		DOM.title.html('');
		DOM.content.html('');
		DOM.buttons.html('');
		
		if (artDialog.focus === that) artDialog.focus = null;
		if (follow) follow[_expando + 'follow'] = null;
		delete list[that.config.id];
		that._isClose = true;
		that._removeEvent();
		that.hide(true)._setAbsolute();
		
		_box ? wrap.remove() : _box = that;
		return that;
	},
	
	/**
	 * 定时关闭
	 * @param	{Number}	单位为秒, 无参数则停止计时器
	 */
	time: function (second) {
		var that = this,
			cancel = that.config.noText,
			timer = that._timer;
			
		timer && clearTimeout(timer);
		
		if (second) {
			that._timer = setTimeout(function(){
				that._trigger(cancel);
			}, 1000 * second);
		};
		
		return that;
	},
	
	/** 给按钮附加焦点 */
	focus: function () {
		var elemFocus, content,
			that = this,
			config = that.config,
			DOM = that.DOM;
			
		elemFocus = that._focus && that._focus[0] || DOM.close[0];
		
		try {
			elemFocus && elemFocus.focus();
		} catch (e) {};
		
		return that;
	},
	
	/** 置顶z-index */
	zIndex: function () {
		var that = this,
			wrap = that.DOM.wrap,
			index = artDialog.defaults.zIndex ++,
			focusElem = artDialog.focus;
			
		wrap.css('zIndex', index);
		that._lockMask && that._lockMask.css('zIndex', index - 1);
		
		// 设置最高层的样式
		if (focusElem) focusElem.DOM.wrap.removeClass('aui_state_focus');
		artDialog.focus = that;
		wrap.addClass('aui_state_focus');
		
		return that;
	},
	
	/** 设置屏锁 */
	lock: function () {
		if (this._lock) return this;
		
		var that = this,
			index = artDialog.defaults.zIndex += 2,
			wrap = that.DOM.wrap,
			config = that.config,
			docWidth = _$document.width(),
			docHeight = _$document.height(),
			lockMaskWrap = that._lockMaskWrap || $(_$body[0].appendChild(document.createElement('div'))),
			lockMask = that._lockMask || $(lockMaskWrap[0].appendChild(document.createElement('div'))),
			domTxt = '(document).documentElement',
			sizeCss = _isMobile ? 'width:' + docWidth + 'px;height:' + docHeight
				+ 'px' : 'width:100%;height:100%',
			ie6Css = _isIE6 ?
				'position:absolute;left:expression(' + domTxt + '.scrollLeft);top:expression('
				+ domTxt + '.scrollTop);width:expression(' + domTxt
				+ '.clientWidth);height:expression(' + domTxt + '.clientHeight)'
			: '';
		
		wrap.css('zIndex', index);
		
		lockMaskWrap[0].style.cssText = sizeCss + ';position:fixed;z-index:'
			+ (index - 1) + ';top:0;left:0;overflow:hidden;' + ie6Css;
		lockMask[0].style.cssText = 'height:100%;background:' + config.background
			+ ';filter:alpha(opacity=0);opacity:0';
		
		// 让IE6锁屏遮罩能够盖住下拉控件
		if (_isIE6) lockMask.html(
			'<iframe src="about:blank" style="width:100%;height:100%;position:absolute;' +
			'top:0;left:0;z-index:-1;filter:alpha(opacity=0)"></iframe>');
			
		lockMask.stop();
		lockMask[0].ondblclick = function () { that.close() };
		if (config.duration === 0) {
			lockMask.css({opacity: config.opacity});
		} else {
			lockMask.animate({opacity: config.opacity}, config.duration);
		};
		
		that._lockMaskWrap = lockMaskWrap;
		that._lockMask = lockMask;
		
		that._lock = true;
		return that;
	},
	
	/** 解开屏锁 */
	unlock: function (onfx) {
		var that = this,
			lockMaskWrap = that._lockMaskWrap,
			lockMask = that._lockMask;
		
		if (!that._lock) return that;
		var style = lockMaskWrap[0].style;
		var un = function () {
			if (_isIE6) {
				style.removeExpression('width');
				style.removeExpression('height');
				style.removeExpression('left');
				style.removeExpression('top');
			};
			style.cssText = 'display:none';
			
			if (_box) {
				lockMaskWrap.remove();
				that._lockMaskWrap = that._lockMask = null;
			};
		};
		
		lockMask.stop()
		lockMask[0].ondblclick = null;
		if (that.config.duration === 0) {// 取消动画，快速关闭
			un();
		} else {
			lockMask.animate({opacity: 0}, that.config.duration, un);
		};
		
		that._lock = false;
		return that;
	},
	
	// 获取元素
	_getDOM: function (wrap) {
		wrap = document.createElement('div');
		wrap.style.cssText = 'position:absolute;left:0;top:0';
		wrap.innerHTML = artDialog.templates;
		document.body.appendChild(wrap);
		
		var DOM = {wrap: $(wrap)},
			els = wrap.getElementsByTagName('*'),
			elsLen = els.length;
			
		for (var i = 0; i < elsLen; i ++) {
			DOM[els[i].className.split('aui_')[1]] = $(els[i]);
		};
		
		return DOM;
	},
	
	// px与%单位转换成数值 (百分比单位按照最大值换算)
	// 其他的单位返回原值
	_toNumber: function (thisValue, maxValue) {
		if (!thisValue && thisValue !== 0 || typeof thisValue === 'number') {
			return thisValue;
		};
		
		var last = thisValue.length - 1;
		if (thisValue.lastIndexOf('px') === last) {
			thisValue = parseInt(thisValue);
		} else if (thisValue.lastIndexOf('%') === last) {
			thisValue = parseInt(maxValue * thisValue.split('%')[0] / 100);
		};
		
		return thisValue;
	},
	
	// 让IE6 CSS支持PNG背景
	_pngFix: function () {
		var i = 0, elem, png, pngPath, runtimeStyle,
			path = artDialog.defaults.path + '/skins/',
			list = this.DOM.wrap[0].getElementsByTagName('*');
		
		for (; i < list.length; i ++) {
			elem = list[i];
			png = elem.currentStyle['png'];
			if (png) {
				pngPath = path + png;
				runtimeStyle = elem.runtimeStyle;
				runtimeStyle.backgroundImage = 'none';
				runtimeStyle.filter = "progid:DXImageTransform.Microsoft." +
					"AlphaImageLoader(src='" + pngPath + "',sizingMethod='crop')";
			};
		};
	},
	
	// 强制覆盖IE6下拉控件
	_selectFix: function () {
		var elem = this.DOM.wrap[0],
			expando = _expando + 'iframeMask',
			iframe = elem[expando],
			width = elem.offsetWidth,
			height = elem.offsetHeight,
			left = - (width - elem.clientWidth) / 2 + 'px',
			top = - (height - elem.clientHeight) / 2 + 'px';

		width = width + 'px';
		height = height + 'px';
		
		if (iframe) {
			iframe.style.width = width;
			iframe.style.height = height;
		} else {
			iframe = elem.appendChild(document.createElement('iframe'));
			elem[expando] = iframe;
			iframe.src = 'about:blank';
			iframe.style.cssText = 'position:absolute;z-index:-1;left:'
				+ left + ';top:' + top
				+ ';width:' + width + ';height:' + height
				+ ';filter:alpha(opacity=0)';
		};
	},
	
	// 解析HTML片段中自定义类型脚本，其this指向artDialog内部
	// <script type="text/dialog">/* [code] */</script>
	_runScript: function (elem) {
		var fun, i = 0, n = 0,
			tags = elem.getElementsByTagName('script'),
			length = tags.length,
			script = [];
			
		for (; i < length; i ++) {
			if (tags[i].type === 'text/dialog') {
				script[n] = tags[i].innerHTML;
				n ++;
			};
		};
		
		if (script.length) {
			script = script.join('');
			fun = new Function(script);
			fun.call(this);
		};
	},
	
	// 自动切换定位类型
	_autoPositionType: function () {
		var that = this;
		that[that.config.fixed ? '_setFixed' : '_setAbsolute']();
	},
	
	
	// 设置静止定位
	// IE6 Fixed @see: http://www.planeart.cn/?p=877
	_setFixed: (function () {
		_isIE6 && $(function () {
			var bg = 'backgroundAttachment';
			if (_$html.css(bg) !== 'fixed' && _$body.css(bg) !== 'fixed') {
				_$html.css({
					backgroundImage: 'url(about:blank)',
					backgroundAttachment: 'fixed'
				});
			};
		});
		
		return function () {
			var $elem = this.DOM.wrap,
				style = $elem[0].style;
			
			if (_isIE6) {
				var left = parseInt($elem.css('left')),
					top = parseInt($elem.css('top')),
					sLeft = _$document.scrollLeft(),
					sTop = _$document.scrollTop(),
					txt = '(document.documentElement)';
				
				this._setAbsolute();
				style.setExpression('left', 'eval(' + txt + '.scrollLeft + '
					+ (left - sLeft) + ') + "px"');
				style.setExpression('top', 'eval(' + txt + '.scrollTop + '
					+ (top - sTop) + ') + "px"');
			} else {
				style.position = 'fixed';
			};
		};
	}()),
	
	// 设置绝对定位
	_setAbsolute: function () {
		var style = this.DOM.wrap[0].style;
			
		if (_isIE6) {
			style.removeExpression('left');
			style.removeExpression('top');
		};

		style.position = 'absolute';
	},
	
	// 按钮事件触发
	_trigger: function (id) {
		var that = this,
			fn = that._listeners[id] && that._listeners[id].callback;
		return typeof fn !== 'function' || fn.call(that, window) !== false ?
			that.close() : that;
	},
	
	// 事件代理
	_addEvent: function () {
		var winResize, resizeTimer,
			that = this,
			config = that.config,
			DOM = that.DOM,
			winSize = _$window.width() * _$window.height();
			
		that._click = function (event) {
			var target = event.target, callbackID;
			
			if (target.disabled) return false; // IE BUG
			
			if (target === DOM.close[0]) {
				that._trigger(config.noText);
				return false;
			} else {
				callbackID = target[_expando + 'callback'];
				callbackID && that._trigger(callbackID);
			};
		};
		
		that._eventDown = function () {
			that.zIndex();
		};
		
		winResize = function () {
			var newSize,
				oldSize = winSize,
				elem = config.follow,
				width = config.width,
				height = config.height,
				left = config.left,
				top = config.top;
			
			if ('all' in document) {
				// IE6~7 window.onresize bug
				newSize = _$window.width() * _$window.height();
				winSize = newSize;
				if (oldSize === newSize) return;
			};
			
			if (width || height) that.size(width, height);
			
			if (elem) {
				that.follow(elem);
			} else if (left || top) {
				that.position(left, top);
			};
		};
		
		that._winResize = function () {
			resizeTimer && clearTimeout(resizeTimer);
			resizeTimer = setTimeout(function () {
				winResize();
			}, 40);
		};
		
		// 监听点击
		DOM.wrap.bind('click', that._click)
		.bind(_eventDown, that._eventDown);
		
		// 窗口调节事件
		_$window.bind('resize', that._winResize);
	},
	
	// 卸载事件代理
	_removeEvent: function () {
		var that = this,
			DOM = that.DOM;
		
		DOM.wrap.unbind('click', that._click)
		.unbind(_eventDown, that._eventDown);
		_$window.unbind('resize', that._winResize);
	}
	
};

artDialog.fn._init.prototype = artDialog.fn;
$.fn.dialog = $.fn.artDialog = function () {
	var config = arguments;
	this[this.live ? 'live' : 'bind']('click', function () {
		artDialog.apply(this, config);
		return false;
	});
	return this;
};



/** 最顶层的对话框API */
artDialog.focus = null;



/** 对话框列表 */
artDialog.list = {};



// 全局快捷键
_$document.bind('keydown', function (event) {
	var target = event.target,
		nodeName = target.nodeName,
		rinput = /^INPUT|TEXTAREA$/,
		api = artDialog.focus,
		keyCode = event.keyCode;

	if (!api || !api.config.esc || rinput.test(nodeName)) return;
		
	keyCode === 27 && api._trigger(api.config.noText);
});



// 获取artDialog路径
_path = window['_artDialog_path'] || (function (script, i, me) {
	for (i in script) {
		// 如果通过第三方脚本加载器加载本文件，请保证文件名含有"artDialog"字符
		if (script[i].src && script[i].src.indexOf('artDialog') !== -1) me = script[i];
	};
	
	_thisScript = me || script[script.length - 1];
	me = _thisScript.src.replace(/\\/g, '/');
	return me.lastIndexOf('/') < 0 ? '.' : me.substring(0, me.lastIndexOf('/'));
}(document.getElementsByTagName('script')));




// 无阻塞载入CSS (如"artDialog.js?skin=aero")
_skin = _thisScript.src.split('skin=')[1];
if (_skin) {
	var link = document.createElement('link');
	link.rel = 'stylesheet';
	link.href = _path + '/skins/' + _skin + '.css?' + artDialog.fn.version;
	_thisScript.parentNode.insertBefore(link, _thisScript);
};



// 触发浏览器预先缓存背景图片
_$window.bind('load', function () {
	setTimeout(function () {
		if (_count) return;
		artDialog({time: 9,left: '-9999em',fixed: false,lock: false,focus: false});
	}, 150);
});



// 开启IE6 CSS背景图片缓存
try {
	document.execCommand('BackgroundImageCache', false, true);
} catch (e) {};



/** 模板 */
artDialog.templates = [
'<div class="aui_outer">',
	'<table class="aui_border">',
		'<tbody>',
			'<tr>',
				'<td class="aui_nw"></td>',
				'<td class="aui_n"></td>',
				'<td class="aui_ne"></td>',
			'</tr>',
			'<tr>',
				'<td class="aui_w"></td>',
				'<td class="aui_center">',
					'<table class="aui_inner">',
						'<tbody>',
							'<tr>',
								'<td colspan="2" class="aui_header">',
									'<div class="aui_titleBar">',
										'<div class="aui_title"></div>',
										'<a class="aui_close" href="javascript:/*artDialog*/;">',
											'\xd7',
										'</a>',
									'</div>',
								'</td>',
							'</tr>',
							'<tr>',
								'<td class="aui_icon">',
									'<div class="aui_iconBg"></div>',
								'</td>',
								'<td class="aui_main">',
									'<div class="aui_content"></div>',
								'</td>',
							'</tr>',
							'<tr>',
								'<td colspan="2" class="aui_footer">',
									'<div class="aui_buttons"></div>',
								'</td>',
							'</tr>',
						'</tbody>',
					'</table>',
				'</td>',
				'<td class="aui_e"></td>',
			'</tr>',
			'<tr>',
				'<td class="aui_sw"></td>',
				'<td class="aui_s"></td>',
				'<td class="aui_se"></td>',
			'</tr>',
		'</tbody>',
	'</table>',
'</div>'
].join('');



/**
 * 默认配置
 */
artDialog.defaults = {
								// 消息内容
	content: '<div class="aui_loading"><span>loading..</span></div>',
	title: '\u6d88\u606f',		// 标题. 默认'消息'
	button: null,				// 自定义按钮
	yesFn: null,				// 确定按钮回调函数
	noFn: null,					// 取消按钮回调函数
	yesText: '\u786E\u5B9A',	// 确定按钮文本. 默认'确定'
	noText: '\u53D6\u6D88',		// 取消按钮文本. 默认'取消'
	width: 'auto',				// 内容宽度
	height: 'auto',				// 内容高度
	minWidth: 96,				// 最小宽度限制
	minHeight: 32,				// 最小高度限制
	padding: '20px 25px',		// 内容与边界填充距离
	skin: '',					// 皮肤名(多皮肤共存预留接口)
	icon: null,					// 消息图标名称
	initFn: null,				// 对话框初始化后执行的函数
	closeFn: null,				// 对话框关闭执行的函数
	time: null,					// 自动关闭时间
	esc: true,					// 是否支持Esc键关闭
	focus: true,				// 是否支持对话框按钮聚焦
	show: true,					// 初始化后是否显示对话框
	follow: null,				// 跟随某元素
	path: _path,				// artDialog路径
	lock: false,				// 是否锁屏
	background: '#000',			// 遮罩颜色
	opacity: .7,				// 遮罩透明度
	duration: 300,				// 遮罩透明度渐变动画速度
	fixed: false,				// 是否静止定位
	left: '50%',				// X轴坐标
	top: 'goldenRatio',			// Y轴坐标
	zIndex: 1987,				// 对话框叠加高度值(重要：此值不能超过浏览器最大限制)
	resize: true,				// 是否允许用户调节尺寸
	drag: true					// 是否允许用户拖动位置
	
};

window.artDialog = $.dialog = $.artDialog = artDialog;
}((window.jQuery && (window.art = jQuery)) || window.art, this));






/*!
	可选外置模块：话框拖拽支持
------------------------------------------------------------------*/
;(function ($) {

var _dragEvent, _use,
	_$window = $(window),
	_$document = $(document),
	_elem = document.documentElement,
	_isIE6 = !-[1,] && !('minWidth' in _elem.style),
	_isLosecapture = 'onlosecapture' in _elem,
	_isSetCapture = 'setCapture' in _elem;

// 拖拽事件
artDialog.dragEvent = function () {
	var that = this,
		proxy = function (name) {
			var fn = that[name];
			that[name] = function () {
				return fn.apply(that, arguments);
			};
		};
		
	proxy('start');
	proxy('move');
	proxy('end');
};

artDialog.dragEvent.prototype = {

	// 开始拖拽
	onstart: $.noop,
	start: function (event) {
		_$document
		.bind('mousemove', this.move)
		.bind('mouseup', this.end);
			
		this._sClientX = event.clientX;
		this._sClientY = event.clientY;
		this.onstart(event.clientX, event.clientY);

		return false;
	},
	
	// 正在拖拽
	onmove: $.noop,
	move: function (event) {		
		this._mClientX = event.clientX;
		this._mClientY = event.clientY;
		this.onmove(
			event.clientX - this._sClientX,
			event.clientY - this._sClientY
		);
		
		return false;
	},
	
	// 结束拖拽
	onend: $.noop,
	end: function (event) {
		_$document
		.unbind('mousemove', this.move)
		.unbind('mouseup', this.end);
		
		this.onend(event.clientX, event.clientY);
		return false;
	}
	
};

_use = function (event) {
	var limit, startWidth, startHeight, startLeft, startTop, isResize,
		api = artDialog.focus,
		config = api.config,
		DOM = api.DOM,
		wrap = DOM.wrap,
		title = DOM.title,
		main = DOM.main;

	// 清除文本选择
	var clsSelect = 'getSelection' in window ? function () {
		window.getSelection().removeAllRanges();
	} : function () {
		try {
			document.selection.empty();
		} catch (e) {};
	};
	
	// 对话框准备拖动
	_dragEvent.onstart = function (x, y) {
		if (isResize) {
			startWidth = main[0].offsetWidth;
			startHeight = main[0].offsetHeight;
		} else {
			startLeft = wrap[0].offsetLeft;
			startTop = wrap[0].offsetTop;
		};
		
		_$document.bind('dblclick', _dragEvent.end);
		!_isIE6 && _isLosecapture ?
			title.bind('losecapture', _dragEvent.end) :
			_$window.bind('blur', _dragEvent.end);
		_isSetCapture && title[0].setCapture();
		
		wrap.addClass('aui_state_drag');
		api.focus();
	};
	
	// 对话框拖动进行中
	_dragEvent.onmove = function (x, y) {
		if (isResize) {
			var wrapStyle = wrap[0].style,
				style = main[0].style,
				width = x + startWidth,
				height = y + startHeight;
			
			wrapStyle.width = 'auto';
			style.width = Math.max(0, width) + 'px';
			config.width = wrap[0].offsetWidth;
			wrapStyle.width = config.width + 'px';
			config.height = Math.max(0, height);
			style.height = config.height + 'px';
			
		} else {
			var style = wrap[0].style,
				left = x + startLeft,
				top = y + startTop;

			style.left = Math.max(limit.minX, Math.min(limit.maxX, left)) + 'px';
			style.top = Math.max(limit.minY, Math.min(limit.maxY, top)) + 'px';
		};
			
		clsSelect();
		_isIE6 && api._selectFix();
	};
	
	// 对话框拖动结束
	_dragEvent.onend = function (x, y) {
		_$document.unbind('dblclick', _dragEvent.end);
		!_isIE6 && _isLosecapture ?
			title.unbind('losecapture', _dragEvent.end) :
			_$window.unbind('blur', _dragEvent.end);
		_isSetCapture && title[0].releaseCapture();
		
		_isIE6 && api._autoPositionType();
		
		wrap.removeClass('aui_state_drag');
	};
	
	isResize = event.target === DOM.se[0] ? true : false;
	limit = (function () {
		var maxX, maxY,
			wrap = api.DOM.wrap[0],
			fixed = wrap.style.position === 'fixed',
			ow = wrap.offsetWidth,
			oh = wrap.offsetHeight,
			ww = _$window.width(),
			wh = _$window.height(),
			dl = fixed ? 0 : _$document.scrollLeft(),
			dt = fixed ? 0 : _$document.scrollTop(),
			
		// 坐标最大值限制
		maxX = ww - ow + dl;
		maxY = wh - oh + dt;
		
		return {
			minX: dl,
			minY: dt,
			maxX: maxX,
			maxY: maxY
		};
	})();
	
	_dragEvent.start(event);
};

// 代理 mousedown 事件触发对话框拖动
_$document.bind('mousedown', function (event) {
	var api = artDialog.focus;
	if (!api) return;

	var target = event.target,
		config = api.config,
		DOM = api.DOM;
	
	if (config.drag !== false && target === DOM.title[0]
	|| config.resize !== false && target === DOM.se[0]) {
		_dragEvent = _dragEvent || new artDialog.dragEvent();
		_use(event);
		return false;// 防止firefox与chrome滚屏
	};
});

})(window.jQuery || window.art);


