/*
 * List 大小可变数组
 *  author: 吴安国
 * version: 1.0
 */
function List() {
	this.list = new Array();
};

/**
 * 将指定的元素添加到此列表的尾部。
 * 
 * @param object
 *            指定的元素
 */
List.prototype.add = function(object) {
	this.list[this.list.length] = object;
};

/**
 * 将List添加到此列表的尾部。
 * 
 * @param listObject
 *            一个列表
 */
List.prototype.addAll = function(listObject) {
	this.list = this.list.concat(listObject.list);
};

/**
 * 返回此列表中指定位置上的元素。
 * 
 * @param index
 *            指定位置
 * @return 此位置的元素
 */
List.prototype.get = function(index) {
	return this.list[index];
};

/**
 * 移除此列表中指定位置上的元素。
 * 
 * @param index
 *            指定位置
 * @return 此位置的元素
 */
List.prototype.removeIndex = function(index) {
	var object = this.list[index];
	this.list.splice(index, 1);
	return object;
};

/**
 * 移除此列表中指定元素。
 * 
 * @param object
 *            指定元素
 * @return 此位置的元素
 */
List.prototype.remove = function(object) {
	var i = 0;
	for (; i < this.list.length; i++) {
		if (this.list[i] === object) {
			break;
		}
	}
	if (i >= this.list.length) {
		return null;
	} else {
		return this.removeIndex(i);
	}
};

/**
 * 移除此列表中的所有元素。
 */
List.prototype.clear = function() {
	this.list.splice(0, this.list.length);
};

/**
 * 返回此列表中的元素数。
 * 
 * @return 元素数量
 */
List.prototype.size = function() {
	return this.list.length;
};

/**
 * 返回列表中指定的 start（包括）和 end（不包括）之间列表。
 * 
 * @param start
 *            开始位置
 * @param end
 *            结束位置
 * @return 新的列表
 */
List.prototype.subList = function(start, end) {
	var list = new List();
	list.list = this.list.slice(start, end);
	return list;
};

/**
 * 如果列表不包含元素，则返回 true。
 * 
 * @return true or false
 */
List.prototype.isEmpty = function() {
	return this.list.length == 0;
};