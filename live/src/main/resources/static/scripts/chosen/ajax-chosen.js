(function() {
	(function($) {
		return $.fn.ajaxChosen = function(options, callback) {
			var select;
			select = this;
			this.chosen();
			var __input;
			if(this.attr('multiple')) {
				__input = this.next('.chzn-container').find(".search-field > input");
			} else {
				__input = this.next('.chzn-container').find(".chzn-search > input");
			}
			
			__input.bind('qj:execute', function() {
				var field, val;
				val = $.trim($(this).attr('value'));
				if (val.length < 1
						|| val === $(this).data('prevVal')) {
					return false;
				}
				$(this).data('prevVal', val);
				field = $(this);
				options.data = {
					term : val
				};
				if(options.postData != undefined) {
					var extraData = options.postData();
					$.each(extraData, function(key, value) {
						options.data[key] = value;
					}); 
				}
				if (typeof success !== "undefined"
						&& success !== null) {
					success;
				} else {
					success = options.success;
				}
				;
				options.success = function(data) {
					var items;
					if (!(data != null)) {
						return;
					}
					select.find('option').each(function() {
						if (!$(this).is(":selected")) {
							return $(this).remove();
						}
					});
					items = callback(data);
					$.each(items, function(value, text) {
						var exists = false;
						select.find('option').each(
								function(i, option) {
									if (value.indexOf('No results match') == -1 && option.value == value) {
										exists = true;
									}
								})

						if (!exists) {
							return $("<option />").attr('value', value).html(text).appendTo(select);
						}
					});
					select.trigger("liszt:updated");
					field.attr('value', val);
					field.trigger("keydown");
					if (typeof success !== "undefined"
							&& success !== null) {
						return success();
					}
				};
				return $.ajax(options);
			});
			
			
			var lastKeyUpTime = null;
			// 界定是否在输入的阈值（单位:毫秒）,如果一个用户在n毫秒内没有输入动作，那么就可以认为用户已经输入完毕可以执行ajax动作了
			var typingThreshold = 800;
			__input.bind("keyup", function() {
				lastKeyUpTime = new Date().getTime();
				setTimeout(function() {
					var currentKeyUpTime = new Date().getTime();
					var typing = true;
					if(currentKeyUpTime - lastKeyUpTime > typingThreshold) {
						typing = false;
					}
					if(!typing) {
						__input.trigger('qj:execute');
					}
				}, typingThreshold + 100);
			});
			return __input;
		};
	})(jQuery);
}).call(this);
