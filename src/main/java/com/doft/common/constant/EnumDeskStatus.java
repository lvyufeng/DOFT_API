package com.doft.common.constant;


/**
 * Created by Jack at 18:49 2018/3/6
 * version 1.0
 */
public enum EnumDeskStatus {

    /**
     * 餐桌状态
     * 0. 空闲
     * 1. 正在使用中
     */

    FREE(0, "FREE", "空闲"),
    BUSY(1, "BUSY", "使用中");

    private final Integer code;
    private final String enDesc;
    private final String cnDesc;

    EnumDeskStatus(Integer code, String enDesc, String cnDesc) {
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
