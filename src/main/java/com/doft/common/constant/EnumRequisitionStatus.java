package com.doft.common.constant;


/**
 * Created by Jack at 18:49 2018/3/6
 * version 1.0
 */
public enum EnumRequisitionStatus {

    /**
     * 申请单状态
     * 1. 未处理
     * 2. 已同意
     * 3. 已拒绝
     */

    UNDEALT(1, "UNDEALT", "未处理"),
    APPROVED(2, "APPROVED", "已同意"),
    REJECTED(3, "REJECTED", "已拒绝");

    private final Integer code;
    private final String enDesc;
    private final String cnDesc;

    EnumRequisitionStatus(Integer code, String enDesc, String cnDesc) {
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
