package com.doft.common.constant;


/**
 * Created by Jack at 15:40 2018/3/16
 * version 1.0
 */
public enum  EnumPaymentType {

    ONLINE(1, "online", "在线支付"),
    OFFLINE(0, "offline", "线下支付");

    private Integer code;
    private String cnDesc;
    private String enDesc;

    EnumPaymentType(Integer code, String cnDesc, String enDesc) {
        this.code = code;
        this.cnDesc = cnDesc;
        this.enDesc = enDesc;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getCnDesc() {
        return cnDesc;
    }

    public void setCnDesc(String cnDesc) {
        this.cnDesc = cnDesc;
    }

    public String getEnDesc() {
        return enDesc;
    }

    public void setEnDesc(String enDesc) {
        this.enDesc = enDesc;
    }


}
