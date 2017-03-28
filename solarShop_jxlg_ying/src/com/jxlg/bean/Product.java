package com.jxlg.bean;
import java.util.HashSet;
import java.util.Set;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler"}) 
public class Product implements java.io.Serializable {

	//Fields
	
	private Integer productid;//产品id
	private String name;//产品名
	private String description;//产品描述
	private Double baseprice;//产品价格
	private String  manufacturer;//生产商
	private String images;//产品图片
	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	private Integer amount;//销售量


	/*private Set orderline = new HashSet(0);*/
	
	//Construcotrs
	
	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	

	/** default constructor*/
	public Product() {
	}
	
	/** minimal constructor*/
	public Product(String name,double baseprice) {
		this.name = name;
		this.baseprice = baseprice;
	}
	
	/** full constructor*/
	//Property accessors
	
	public Integer getProductid() {
		return productid;
	}

	public void setProductid(Integer productid) {
		this.productid = productid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Double getBaseprice() {
		return baseprice;
	}

	public void setBaseprice(Double baseprice) {
		this.baseprice = baseprice;
	}

	public String getImages() {
		return images;
	}

	public void setImages(String images) {
		this.images = images;
	}

	
}
