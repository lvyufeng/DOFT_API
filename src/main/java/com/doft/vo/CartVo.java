package com.doft.vo;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author lvyufeng
 * @date 18-3-13 下午4:05
 * @classname CartVo
 */
public class CartVo {
    private List<CartDishVo> cartDishVoList;

    private BigDecimal cartTotalPrice;

    private Boolean allChecked;
    private String imgHost;

    private Boolean addedSeat;

    public List<CartDishVo> getCartDishVoList() {
        return cartDishVoList;
    }

    public void setCartDishVoList(List<CartDishVo> cartDishVoList) {
        this.cartDishVoList = cartDishVoList;
    }

    public BigDecimal getCartTotalPrice() {
        return cartTotalPrice;
    }

    public void setCartTotalPrice(BigDecimal cartTotalPrice) {
        this.cartTotalPrice = cartTotalPrice;
    }

    public Boolean getAllChecked() {
        return allChecked;
    }

    public void setAllChecked(Boolean allChecked) {
        this.allChecked = allChecked;
    }

    public String getImgHost() {
        return imgHost;
    }

    public void setImgHost(String imgHost) {
        this.imgHost = imgHost;
    }

    public Boolean getAddedSeat() {
        return addedSeat;
    }

    public void setAddedSeat(Boolean addedSeat) {
        this.addedSeat = addedSeat;
    }
}
