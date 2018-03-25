package com.doft.common.constant;


/**
 * Created by Jack at 15:18 2018/3/16
 * version 1.0
 */
public enum  EnumDishStatus {

    /**
     * 菜品状态
     * 1. 在售
     * 2. 已下架
     * 3. 已删除
     */

    ON_SALE(1, "on sale", "在售"),
    DROP_OFF(2, "drop off", "已下架"),
    DELETED(3, "deleted", "已删除");

    private final Integer code;
    private final String enDesc;
    private final String cnDesc;

    EnumDishStatus(Integer code, String enDesc, String cnDesc) {
        this.code = code;
        this.enDesc = enDesc;
        this.cnDesc = cnDesc;
    }

    public Integer getCode() {
        return code;
    }

    public String getEnDesc() {
        return enDesc;
    }

    public String getCnDesc() {
        return cnDesc;
    }



}
