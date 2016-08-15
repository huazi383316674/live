package com.sad.model.shopping;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.beangle.model.pojo.LongIdObject;

/**
 * 商品
 */
@Entity
@Table(name = "a_shopping_goods")
public class ShoppingGoods extends LongIdObject {

	private static final long serialVersionUID = 1L;

	/** 编号 */
	@NotNull
	private String code;

	/** 名称 */
	@NotNull
	private String name;

	/** 出售价格 */
	private float price;

	/** 进价 */
	private float inPrice;

	/** 种类 */
	@NotNull
	private ShoppingGoodsType type;

	/** 商品描述 */
	private String description;

	/** 图片名称 */
	private String imageName;

	/** 备注 */
	private String remark;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public ShoppingGoodsType getType() {
		return type;
	}

	public void setType(ShoppingGoodsType type) {
		this.type = type;
	}

	public String getImageName() {
		return imageName;
	}

	public void setImageName(String imageName) {
		this.imageName = imageName;
	}

	public float getInPrice() {
		return inPrice;
	}

	public void setInPrice(float inPrice) {
		this.inPrice = inPrice;
	}

}
